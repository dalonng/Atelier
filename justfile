set shell := ["/bin/zsh", "-eu", "-c"]

# 列出可用命令
default:
    @just --list

# 安装 mise.toml 中固定版本的工具
setup:
    mise install

# 生成 Xcode 工程，不自动打开
generate:
    mise exec -- tuist generate --no-open

# 生成工程并在 Xcode 中打开
open: generate
    open Atelier.xcworkspace

# 构建 iOS 模拟器版本（无需签名）
build-ios configuration="Debug": generate
    xcodebuild -workspace Atelier.xcworkspace -scheme Atelier -configuration "{{configuration}}" -destination 'generic/platform=iOS Simulator' -derivedDataPath .build/ios CODE_SIGNING_ALLOWED=NO build

# 构建 macOS 版本（无需签名）
build-mac configuration="Debug": generate
    xcodebuild -workspace Atelier.xcworkspace -scheme Atelier -configuration "{{configuration}}" -destination 'generic/platform=macOS' -derivedDataPath .build/mac CODE_SIGNING_ALLOWED=NO build

# 构建 visionOS 模拟器版本（无需签名）
build-vision configuration="Debug": generate
    xcodebuild -workspace Atelier.xcworkspace -scheme Atelier -configuration "{{configuration}}" -destination 'generic/platform=visionOS Simulator' -derivedDataPath .build/vision CODE_SIGNING_ALLOWED=NO build
