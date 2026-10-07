import ProjectDescription

let project = Project(
    name: "Atelier",
    options: .options(automaticSchemesOptions: .disabled),
    settings: .settings(
        configurations: [
            .debug(name: "Debug", xcconfig: "Config/Project-Debug.xcconfig"),
            .release(name: "Release", xcconfig: "Config/Project-Release.xcconfig"),
        ],
        defaultSettings: .none
    ),
    targets: [
        .target(
            name: "Atelier",
            destinations: [.iPhone, .iPad, .mac, .appleVision],
            product: .app,
            bundleId: "devplaceholder.XVJCQFM6.Atelier",
            deploymentTargets: .multiplatform(iOS: "27.0", macOS: "27.0", visionOS: "27.0"),
            infoPlist: nil,
            sources: ["Atelier/**/*.swift"],
            resources: ["Atelier/Assets.xcassets", "Design/AppIcon.icon"],
            settings: .settings(
                base: ["ASSETCATALOG_COMPILER_APPICON_NAME": "AppIcon"],
                configurations: [
                    .debug(name: "Debug", xcconfig: "Config/App-Debug.xcconfig"),
                    .release(name: "Release", xcconfig: "Config/App-Release.xcconfig"),
                ],
                defaultSettings: .none
            )
        ),
    ],
    schemes: [
        .scheme(
            name: "Atelier",
            shared: true,
            buildAction: .buildAction(targets: ["Atelier"]),
            runAction: .runAction(configuration: "Debug"),
            archiveAction: .archiveAction(configuration: "Release"),
            profileAction: .profileAction(configuration: "Release"),
            analyzeAction: .analyzeAction(configuration: "Debug")
        ),
    ],
    additionalFiles: ["Config/**", "README.md"],
    resourceSynthesizers: []
)
