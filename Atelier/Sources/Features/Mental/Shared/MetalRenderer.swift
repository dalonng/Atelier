import MetalKit

@MainActor
protocol MetalRenderer: MTKViewDelegate {
  var device: any MTLDevice { get }
}
