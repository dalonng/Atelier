# Atelier

工程使用 Tuist 管理，`Project.swift` 和 `Config/*.xcconfig` 是工程配置的来源。

## 开发

安装 [mise](https://mise.jdx.dev/)，然后运行：

```sh
mise install
mise exec -- tuist generate
```

打开生成的 `Atelier.xcworkspace`，选择 `Atelier` Scheme。已安装 Tuist 4.211.0 时也可直接运行 `tuist generate`。

支持 iPhone、iPad、macOS 和 visionOS，最低系统版本均为 27.0，需要 Xcode 27 或更高版本。

```sh
tuist generate --no-open
xcodebuild -workspace Atelier.xcworkspace -scheme Atelier \
  -configuration Debug -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO build
```

签名团队和版本配置位于 `Config/App-*.xcconfig`。新增源码和资源或修改工程配置后，重新运行 `tuist generate`。生成的 Xcode 工程、Workspace 和 `Derived` 目录不提交到版本控制。

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
