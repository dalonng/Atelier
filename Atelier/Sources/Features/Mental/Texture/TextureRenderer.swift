import MetalKit

@MainActor
final class TextureRenderer: NSObject, MetalRenderer {
  let device: any MTLDevice
  private let queue: any MTLCommandQueue
  private let pipeline: any MTLRenderPipelineState
  private let texture: any MTLTexture

  private enum SetupError: Error {
    case unavailable
  }

  init(device: (any MTLDevice)? = MTLCreateSystemDefaultDevice()) throws {
    guard let device,
          let queue = device.makeCommandQueue(),
          let library = device.makeDefaultLibrary(),
          let vertex = library.makeFunction(name: "textureVertex"),
          let fragment = library.makeFunction(name: "textureFragment")
    else {
      throw SetupError.unavailable
    }

    let pipelineDescriptor = MTLRenderPipelineDescriptor()
    pipelineDescriptor.vertexFunction = vertex
    pipelineDescriptor.fragmentFunction = fragment
    pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm

    // A generated checkerboard makes the sample independent of external images.
    let side = 256
    let descriptor = MTLTextureDescriptor.texture2DDescriptor(
      pixelFormat: .rgba8Unorm,
      width: side,
      height: side,
      mipmapped: false,
    )
    descriptor.usage = .shaderRead
    descriptor.storageMode = .shared
    guard let texture = device.makeTexture(descriptor: descriptor) else {
      throw SetupError.unavailable
    }

    var pixels = [UInt8](repeating: 0, count: side * side * 4)
    for y in 0 ..< side {
      for x in 0 ..< side {
        let offset = (y * side + x) * 4
        let light = (x / 32 + y / 32).isMultiple(of: 2)
        pixels[offset] = light ? UInt8(x) : 24
        pixels[offset + 1] = light ? UInt8(y) : 40
        pixels[offset + 2] = light ? 240 : 72
        pixels[offset + 3] = 255
      }
    }
    pixels.withUnsafeBytes { bytes in
      texture.replace(
        region: MTLRegionMake2D(0, 0, side, side),
        mipmapLevel: 0,
        withBytes: bytes.baseAddress!,
        bytesPerRow: side * 4,
      )
    }

    self.device = device
    self.queue = queue
    self.pipeline = try device.makeRenderPipelineState(descriptor: pipelineDescriptor)
    self.texture = texture
    super.init()
  }

  func mtkView(_: MTKView, drawableSizeWillChange _: CGSize) {}

  func draw(in view: MTKView) {
    guard view.drawableSize.width > 0, view.drawableSize.height > 0,
          let pass = view.currentRenderPassDescriptor,
          let drawable = view.currentDrawable,
          let command = queue.makeCommandBuffer(),
          let encoder = command.makeRenderCommandEncoder(descriptor: pass)
    else {
      return
    }

    let size = view.drawableSize
    let shorter = min(size.width, size.height)
    var scale = SIMD2<Float>(Float(shorter / size.width), Float(shorter / size.height))
    encoder.setRenderPipelineState(pipeline)
    encoder.setVertexBytes(&scale, length: MemoryLayout<SIMD2<Float>>.stride, index: 0)
    encoder.setFragmentTexture(texture, index: 0)
    encoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 6)
    encoder.endEncoding()
    command.present(drawable)
    command.commit()
  }
}
