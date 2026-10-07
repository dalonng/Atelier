import ProjectDescription

public enum AppSchemes {
  public static let app = Scheme.scheme(
    name: AppSettings.projectName,
    shared: true,
    buildAction: .buildAction(targets: [.target(AppSettings.projectName)]),
    runAction: .runAction(configuration: "Debug"),
    archiveAction: .archiveAction(configuration: "Release"),
    profileAction: .profileAction(configuration: "Release"),
    analyzeAction: .analyzeAction(configuration: "Debug")
  )
}
