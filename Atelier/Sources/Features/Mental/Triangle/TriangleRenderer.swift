import MetalKit

@MainActor
final class TriangleRenderer: NSObject, MetalRenderer {
  let device: any MTLDevice
  private let queue: any MTLCommandQueue
  private let pipeline: any MTLRenderPipelineState

  private enum SetupError: Error {
    case unavailable
  }

  init(device: (any MTLDevice)? = MTLCreateSystemDefaultDevice()) throws {
    guard let device,
          let queue = device.makeCommandQueue(),
          let library = device.makeDefaultLibrary(),
          let vertex = library.makeFunction(name: "triangleVertex"),
          let fragment = library.makeFunction(name: "shapeFragment")
    else {
      throw SetupError.unavailable
    }

    let descriptor = MTLRenderPipelineDescriptor()
    descriptor.vertexFunction = vertex
    descriptor.fragmentFunction = fragment
    descriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
    self.device = device
    self.queue = queue
    self.pipeline = try device.makeRenderPipelineState(descriptor: descriptor)
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

    var myUniforms = Uniforms(
      mvpMatrix: matrix_identity_float4x4,
      tintColor: simd_float4(1.0, 0.8, 0.0, 1.0),
    )

    // Scale both axes by the shorter dimension to keep the square square.
    let size = view.drawableSize
    let shorter = min(size.width, size.height)
    var scale = SIMD2<Float>(Float(shorter / size.width), Float(shorter / size.height))
    encoder.setRenderPipelineState(pipeline)
    encoder.setVertexBytes(&scale, length: MemoryLayout<SIMD2<Float>>.stride, index: 0)
    encoder.setVertexBytes(&myUniforms, length: MemoryLayout<Uniforms>.stride, index: 2)

    encoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)
    encoder.endEncoding()
    command.present(drawable)
    command.commit()
  }
}
