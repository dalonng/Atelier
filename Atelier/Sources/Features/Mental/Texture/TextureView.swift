import SwiftUI

struct TextureView: View {
  @State private var renderer: TextureRenderer?
  @State private var failed = false

  var body: some View {
    ZStack {
      if let renderer {
        MetalCanvas(renderer: renderer)
          .accessibilityLabel(Text("Checkerboard Texture"))
      } else if failed {
        ContentUnavailableView("Metal Unavailable", systemImage: "exclamationmark.triangle")
      } else {
        ProgressView()
      }
    }
    .navigationTitle("Texture")
    .task {
      guard renderer == nil, !failed else {
        return
      }

      do {
        renderer = try TextureRenderer()
      } catch {
        failed = true
      }
    }
  }
}

#Preview {
  TextureView()
}
