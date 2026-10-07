import SwiftUI

struct SquareView: View {
  @State private var renderer: SquareRenderer?
  @State private var failed = false

  var body: some View {
    ZStack {
      if let renderer {
        MetalCanvas(renderer: renderer)
          .accessibilityLabel(Text("Square"))
      } else if failed {
        ContentUnavailableView("Metal Unavailable", systemImage: "exclamationmark.triangle")
      } else {
        ProgressView()
      }
    }
    .navigationTitle("Square")
    .task {
      guard renderer == nil, !failed else {
        return
      }

      do {
        renderer = try SquareRenderer()
      } catch {
        failed = true
      }
    }
  }
}

#Preview {
  SquareView()
}
