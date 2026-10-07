import ProjectDescription

public enum AppSettings {
  public static let projectName = "Atelier"
  public static let bundleId = Environment.bundleId.getString(default: "com.example.Atelier")
  public static let marketingVersion = "1.0"
  public static let buildNumber = "1"
  public static let developmentTeam = Environment.developmentTeam.getString(default: "")
  public static let deploymentTarget = "27.0"
}
