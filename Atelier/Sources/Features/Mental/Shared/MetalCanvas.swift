import MetalKit
import SwiftUI

struct MetalCanvas {
  let renderer: any MetalRenderer

  func makeCanvas() -> MTKView {
    let view = MTKView(frame: .zero, device: renderer.device)
    view.colorPixelFormat = .bgra8Unorm
    view.clearColor = MTLClearColor(red: 0.04, green: 0.05, blue: 0.08, alpha: 1)
    // Static shapes only redraw when requested or resized.
    view.isPaused = true
    view.enableSetNeedsDisplay = true
    view.delegate = renderer
    return view
  }
}

#if os(macOS)
extension MetalCanvas: NSViewRepresentable {
  func makeNSView(context _: Context) -> MTKView {
    makeCanvas()
  }

  func updateNSView(_ view: MTKView, context _: Context) {
    view.needsDisplay = true
  }
}
#else
extension MetalCanvas: UIViewRepresentable {
  func makeUIView(context _: Context) -> MTKView {
    makeCanvas()
  }

  func updateUIView(_ view: MTKView, context _: Context) {
    view.setNeedsDisplay()
  }
}
#endif
