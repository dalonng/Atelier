import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: AppSettings.projectName,
  options: .options(
    automaticSchemesOptions: .disabled,
    disableSynthesizedResourceAccessors: true,
  ),
  settings: ProjectBuildSettings.settings,
  targets: [AppTarget.make()],
  schemes: [AppSchemes.app],
  additionalFiles: [
    "Project.swift",
    "Tuist.swift",
    "Tuist/ProjectDescriptionHelpers/**",
    "mise.toml",
    "justfile",
    "Scripts/**",
    ".swiftformat",
    "README.md",
  ],
  resourceSynthesizers: [],
)
