import SwiftUI

struct RootView: View {
  private enum Page: String, CaseIterable, Identifiable {
    case home
    case favorites
    case mental

    var id: Self {
      self
    }

    var title: LocalizedStringResource {
      switch self {
      case .home: "Home"
      case .favorites: "Favorites"
      case .mental: "Mental"
      }
    }

    var systemImage: String {
      switch self {
      case .home: "house"
      case .favorites: "star"
      case .mental: "m.square"
      }
    }
  }

  @State private var selection: Page?

  var body: some View {
    NavigationSplitView {
      List(Page.allCases, selection: $selection) { page in
        NavigationLink(value: page) {
          Label {
            Text(page.title)
          } icon: {
            Image(systemName: page.systemImage)
          }
        }
      }
      .navigationTitle("Atelier")
      .navigationSplitViewColumnWidth(min: 180, ideal: 220)
    } detail: {
      switch selection {
      case .home:
        Text("Hello, world!")
          .padding()
          .navigationTitle("Home")
      case .favorites:
        ContentUnavailableView("No Favorites", systemImage: "star")
          .navigationTitle("Favorites")
      case .mental:
        MentalView()
      case nil:
        ContentUnavailableView("Select a Page", systemImage: "sidebar.left")
      }
    }
  }
}

#Preview {
  RootView()
}
