# 应用图标指南

## 当前问题

当前的 `resources/image/appicon.png` 只有 16x16 像素，这导致图标在 macOS 上显示模糊。

## 解决方案

替换 `resources/image/appicon.png` 为高分辨率版本：

### 推荐尺寸
- 最佳：1024x1024 像素
- 最小：512x512 像素

### 图标要求
- 格式：PNG（支持透明背景）
- 尺寸：正方形
- 分辨率：至少 512x512，推荐 1024x1024
- 颜色：RGB 或 RGBA

### 如何创建高质量图标

1. 使用设计工具（Figma、Sketch、Photoshop 等）创建 1024x1024 的图标
2. 导出为 PNG 格式
3. 替换 `resources/image/appicon.png`
4. 重新构建：`cmake --build build`

### 临时解决方案

如果你有 SVG 格式的图标（如 `resources/qrc/icon/music.svg`），可以转换为高分辨率 PNG：

```bash
# 使用 rsvg-convert（需要先安装 librsvg）
brew install librsvg
rsvg-convert -w 1024 -h 1024 resources/qrc/icon/music.svg -o resources/image/appicon.png

# 或使用在线工具转换 SVG 到 1024x1024 PNG
```

### 验证图标尺寸

```bash
sips -g pixelWidth -g pixelHeight resources/image/appicon.png
```

应该显示至少 512x512 或更大。

## 重新构建

替换图标后，重新构建应用：

```bash
# 清理旧图标
rm -f build/AppIcon.icns

# 重新构建
cmake --build build

# 或完整打包
./package.sh
```

## 图标设计建议

- 使用简洁的设计，避免过多细节
- 确保在小尺寸（16x16）下仍然清晰可辨
- 使用圆角矩形背景（macOS 会自动应用圆角）
- 考虑深色和浅色模式下的显示效果
