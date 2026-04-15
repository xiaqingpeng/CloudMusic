# CloudMusic 打包说明

## 快速打包

类似 KMP 项目的打包方式，运行：

```bash
./package.sh
```

这个命令会：
1. 配置 CMake 构建
2. 编译应用程序
3. 使用 macdeployqt 打包 Qt 依赖
4. 创建 DMG 安装包

## 分步打包

如果你想分步执行，可以使用：

```bash
# 1. 配置项目
cmake -B build -DCMAKE_BUILD_TYPE=Release

# 2. 编译
cmake --build build --config Release

# 3. 部署 Qt 依赖
cmake --build build --target deploy

# 4. 创建 DMG
cmake --build build --target packageDmg
```

## 输出文件

打包完成后，DMG 文件位于：
```
build/CloudMusic-0.1.dmg
```

## 安装应用

1. 双击打开 `CloudMusic-0.1.dmg`
2. 将 CloudMusic 拖拽到 Applications 文件夹
3. 从启动台或 Applications 文件夹运行应用

## 系统要求

- macOS 10.15 或更高版本
- Qt 6.x 已安装
- CMake 3.16 或更高版本

## 应用图标

应用图标使用 `resources/image/appicon.png` 自动生成。构建时会自动转换为 macOS 所需的 .icns 格式。

图标会在构建时使用 macOS 内置的 sips 工具自动生成多种尺寸（16x16 到 1024x1024），包括 Retina 显示屏的 @2x 版本。

开发模式和发布模式都会自动生成和使用图标。

## 故障排除

如果遇到 "macdeployqt not found" 错误：
- 确保 Qt 已正确安装
- 检查 Qt 的 bin 目录是否在 PATH 中
- 或手动指定 Qt 路径：`export Qt6_DIR=/path/to/Qt/6.x.x/macos`
