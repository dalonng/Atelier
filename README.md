# Atelier

工程使用 Tuist 管理，`Project.swift` 负责组装工程，`Tuist/ProjectDescriptionHelpers/` 统一管理 Target、Scheme、Info.plist 生成设置和构建配置。

`Atelier/Sources/` 存放代码，`Atelier/Resources/` 存放资源（包括 Asset Catalog 和 App Icon）。

## 开发

安装 [mise](https://mise.jdx.dev/)，然后运行：

```sh
mise install
just generate
```

打开生成的 `Atelier.xcworkspace`，选择 `Atelier` Scheme。

Bundle ID 和签名团队由开发者本地配置：

```sh
cp .env.example .env
# 编辑 .env，填写自己的 TUIST_DEVELOPMENT_TEAM 和 TUIST_BUNDLE_ID
just generate
```

`.env` 不提交到版本控制，`just` 会自动加载它。不配置时，Bundle ID 使用 `com.example.Atelier`，签名团队为空，仍可进行无签名构建。真机运行或归档前执行 `just check-signing` 检查配置，再重新生成工程。

直接执行 `tuist generate` 不会自动加载 `.env`，需要先导出上述 `TUIST_` 环境变量；CI 也可直接注入这两个变量。

支持 iPhone、iPad、macOS 和 visionOS，最低系统版本均为 27.0，需要 Xcode 27 或更高版本。

```sh
just generate
xcodebuild -workspace Atelier.xcworkspace -scheme Atelier \
  -configuration Debug -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO build
```

应用名称、版本、最低系统版本及本地配置读取逻辑位于 `Tuist/ProjectDescriptionHelpers/AppSettings.swift`。应用构建设置位于 `AppBuildSettings.swift`，工程共用及 Debug/Release 设置位于 `ProjectBuildSettings.swift`。新增源码和资源或修改工程配置后，重新运行 `just generate`。生成的 Xcode 工程、Workspace 和 `Derived` 目录不提交到版本控制。

## just 命令

安装 `just` 和 `mise` 后，可使用以下快捷命令；运行 `just` 查看完整列表。

```sh
just setup                # 安装固定版本的工具
just generate             # 生成工程
just open                 # 生成并打开 Workspace
just build-ios            # iOS 模拟器 Debug 构建
just build-mac            # macOS Debug 构建
just build-vision         # visionOS 模拟器 Debug 构建
just build-ios Release    # 指定 Release 配置
```

构建命令会先重新生成工程，构建产物位于 `.build/`。
