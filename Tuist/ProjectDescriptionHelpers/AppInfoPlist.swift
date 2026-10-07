import ProjectDescription

public enum AppInfoPlist {
  // Xcode generates the Info.plist using these build settings.
  public static let buildSettings: SettingsDictionary = [
    "GENERATE_INFOPLIST_FILE": "YES",
    "INFOPLIST_KEY_UIApplicationSceneManifest_Generation[sdk=iphoneos*]": "YES",
    "INFOPLIST_KEY_UIApplicationSceneManifest_Generation[sdk=iphonesimulator*]": "YES",
    "INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents[sdk=iphoneos*]": "YES",
    "INFOPLIST_KEY_UIApplicationSupportsIndirectInputEvents[sdk=iphonesimulator*]": "YES",
    "INFOPLIST_KEY_UILaunchScreen_Generation[sdk=iphoneos*]": "YES",
    "INFOPLIST_KEY_UILaunchScreen_Generation[sdk=iphonesimulator*]": "YES",
    "INFOPLIST_KEY_UIStatusBarStyle[sdk=iphoneos*]": "UIStatusBarStyleDefault",
    "INFOPLIST_KEY_UIStatusBarStyle[sdk=iphonesimulator*]": "UIStatusBarStyleDefault",
    "INFOPLIST_KEY_UISupportedInterfaceOrientations_iPad": "UIInterfaceOrientationPortrait UIInterfaceOrientationPortraitUpsideDown UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight",
    "INFOPLIST_KEY_UISupportedInterfaceOrientations_iPhone": "UIInterfaceOrientationPortrait UIInterfaceOrientationLandscapeLeft UIInterfaceOrientationLandscapeRight",
  ]
}
