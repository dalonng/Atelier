import SwiftUI

struct TriangleView: View {
  @State private var renderer: TriangleRenderer?
  @State private var failed = false

  var body: some View {
    ZStack {
      if let renderer {
        MetalCanvas(renderer: renderer)
          .accessibilityLabel(Text("Triangle"))
      } else if failed {
        ContentUnavailableView("Metal Unavailable", systemImage: "exclamationmark.triangle")
      } else {
        ProgressView()
      }
    }
    .navigationTitle("Triangle")
    .task {
      guard renderer == nil, !failed else {
        return
      }

      do {
        renderer = try TriangleRenderer()
      } catch {
        failed = true
      }
    }
  }
}

#Preview {
  TriangleView()
}
