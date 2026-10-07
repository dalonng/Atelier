import SwiftUI

struct MentalView: View {
  private enum ShapePage: Hashable {
    case triangle
    case square
    case texture
  }

  var body: some View {
    NavigationStack {
      List {
        NavigationLink(value: ShapePage.triangle) {
          Label("Triangle", systemImage: "triangle")
        }
        NavigationLink(value: ShapePage.square) {
          Label("Square", systemImage: "square")
        }
        NavigationLink(value: ShapePage.texture) {
          Label("Texture", systemImage: "photo")
        }
      }
      .navigationTitle("Mental")
      .navigationDestination(for: ShapePage.self) { page in
        switch page {
        case .triangle:
          TriangleView()
        case .square:
          SquareView()
        case .texture:
          TextureView()
        }
      }
    }
  }
}

#Preview {
  MentalView()
}
