import ProjectDescription

public enum AppBuildSettings {
  public static let settings: Settings = .settings(
    base: baseSettings.merging(AppInfoPlist.buildSettings) { _, value in value },
    configurations: [.debug(name: "Debug"), .release(name: "Release")],
    defaultSettings: .none
  )

  private static let baseSettings: SettingsDictionary = [
    "ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon",
    "CODE_SIGN_STYLE": "Automatic",
    "ENABLE_APP_SANDBOX": "YES",
    "ENABLE_PREVIEWS": "YES",
    "ENABLE_USER_SELECTED_FILES": "readonly",
    "LD_RUNPATH_SEARCH_PATHS": "@executable_path/Frameworks",
    "LD_RUNPATH_SEARCH_PATHS[sdk=macosx*]": "@executable_path/../Frameworks",
    "REGISTER_APP_GROUPS": "YES",
    "STRING_CATALOG_GENERATE_SYMBOLS": "YES",
    "SWIFT_APPROACHABLE_CONCURRENCY": "YES",
    "SWIFT_DEFAULT_ACTOR_ISOLATION": "MainActor",
    "SWIFT_EMIT_LOC_STRINGS": "YES",
    "SWIFT_UPCOMING_FEATURE_MEMBER_IMPORT_VISIBILITY": "YES",
    "SWIFT_VERSION": "5.0",
    "MARKETING_VERSION": .string(AppSettings.marketingVersion),
    "CURRENT_PROJECT_VERSION": .string(AppSettings.buildNumber),
    "DEVELOPMENT_TEAM": .string(AppSettings.developmentTeam),
  ]
}
