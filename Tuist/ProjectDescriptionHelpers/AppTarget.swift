import ProjectDescription

public enum AppTarget {
  public static func make() -> Target {
    .target(
      name: AppSettings.projectName,
      destinations: [.iPhone, .iPad, .mac, .appleVision],
      product: .app,
      bundleId: AppSettings.bundleId,
      deploymentTargets: .multiplatform(
        iOS: AppSettings.deploymentTarget,
        macOS: AppSettings.deploymentTarget,
        visionOS: AppSettings.deploymentTarget
      ),
      infoPlist: nil,
      sources: ["Atelier/Sources/**/*.swift"],
      resources: ["Atelier/Resources/**"],
      settings: AppBuildSettings.settings
    )
  }
}
