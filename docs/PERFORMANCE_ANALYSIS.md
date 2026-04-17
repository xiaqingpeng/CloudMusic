# QML 性能分析指南

## Qt Creator 内置工具

### 1. QML Profiler

**启动方式：**
- 点击 Qt Creator 左侧的 "Analyze" 按钮
- 选择 "QML Profiler"
- 运行应用

**查看数据：**

#### Timeline 视图
- **绿色条**：JavaScript 执行时间
- **蓝色条**：QML 编译时间
- **紫色条**：信号处理时间
- **橙色条**：渲染时间
- **红色条**：性能瓶颈（超过 16ms）

#### Flame Graph（火焰图）
- 宽度 = 函数耗时
- 高度 = 调用层次
- 点击可查看详细信息

#### Statistics（统计）
- 按总耗时排序
- 查看调用次数
- 识别热点函数

### 2. 性能指标

**目标值：**
- 60 FPS = 每帧 16.67ms
- 30 FPS = 每帧 33.33ms

**关键指标：**
- JavaScript 执行 < 5ms
- 渲染时间 < 10ms
- 信号处理 < 1ms

## 命令行工具

### 使用 profile.sh 脚本

```bash
./scripts/profile.sh
```

**分析模式：**

1. **基础性能监控**
   - 查看 FPS
   - JavaScript 执行时间
   - 渲染时间

2. **过度绘制分析**
   - 红色区域 = 过度绘制严重
   - 优化：减少重叠元素

3. **批次分析**
   - 查看渲染批次数量
   - 优化：合并相似元素

4. **内存分配跟踪**
   - 查看内存分配情况
   - 识别内存泄漏

## 环境变量

### 渲染调试

```bash
# 显示渲染信息
export QSG_INFO=1

# 可视化过度绘制
export QSG_VISUALIZE=overdraw

# 可视化渲染批次
export QSG_VISUALIZE=batches

# 可视化裁剪区域
export QSG_VISUALIZE=clip

# 显示 FPS
export QSG_RENDER_TIMING=1
```

### QML 调试

```bash
# 显示 QML 导入信息
export QML_IMPORT_TRACE=1

# 显示绑定信息
export QT_LOGGING_RULES="qt.qml.binding.removal.info=true"

# 禁用磁盘缓存（便于调试）
export QML_DISABLE_DISK_CACHE=1

# V4 引擎统计
export QV4_MM_STATS=1
```

## 常见性能问题

### 1. 过度绘制

**症状：**
- 渲染时间过长
- FPS 低

**解决方案：**
```qml
// 使用 visible 而不是 opacity
Item {
    visible: false  // ✅ 不渲染
    // opacity: 0   // ❌ 仍然渲染
}

// 使用 clip 限制绘制区域
Rectangle {
    clip: true
}
```

### 2. JavaScript 执行慢

**症状：**
- JavaScript 执行时间 > 5ms
- UI 卡顿

**解决方案：**
```qml
// 使用 WorkerScript 处理复杂计算
WorkerScript {
    id: worker
    source: "worker.js"
}

// 避免在绑定中使用复杂计算
property int value: heavyCalculation()  // ❌
property int value: cachedValue         // ✅
```

### 3. 频繁的属性绑定更新

**症状：**
- 绑定更新频繁
- CPU 占用高

**解决方案：**
```qml
// 使用 Binding 控制更新
Binding {
    target: item
    property: "x"
    value: mouseArea.mouseX
    when: mouseArea.pressed  // 只在按下时更新
}

// 使用防抖
Timer {
    id: debounceTimer
    interval: 100
    onTriggered: updateValue()
}
```

### 4. 列表性能问题

**症状：**
- 滚动卡顿
- 内存占用高

**解决方案：**
```qml
ListView {
    // 使用缓存
    cacheBuffer: 200
    
    // 异步加载
    asynchronous: true
    
    // 使用 Loader 延迟加载
    delegate: Loader {
        asynchronous: true
        sourceComponent: itemDelegate
    }
}
```

## 性能优化检查清单

### 渲染优化
- [ ] 减少不可见元素的渲染
- [ ] 使用 clip 限制绘制区域
- [ ] 合并相似的渲染批次
- [ ] 避免透明度动画（使用 visible）

### JavaScript 优化
- [ ] 避免在绑定中使用复杂计算
- [ ] 使用 WorkerScript 处理耗时操作
- [ ] 缓存计算结果
- [ ] 减少属性绑定的更新频率

### 内存优化
- [ ] 使用 Loader 延迟加载
- [ ] 及时释放不用的对象
- [ ] 使用对象池复用对象
- [ ] 优化图片资源大小

### 列表优化
- [ ] 设置合适的 cacheBuffer
- [ ] 使用异步加载
- [ ] 简化 delegate
- [ ] 避免在 delegate 中使用复杂绑定

## 分析工具对比

| 工具 | 优点 | 缺点 | 适用场景 |
|------|------|------|----------|
| QML Profiler | 详细的时间线 | 需要 Qt Creator | 日常开发 |
| QSG_VISUALIZE | 直观的可视化 | 只能看渲染 | 渲染问题 |
| QSG_INFO | 详细的日志 | 信息量大 | 深度分析 |
| Valgrind | 内存泄漏检测 | 运行慢 | 内存问题 |
| Heaptrack | 内存分配分析 | 需要安装 | 内存优化 |

## 推荐工作流

1. **开发阶段**
   - 使用 Qt Creator QML Profiler
   - 定期检查性能指标

2. **发现问题**
   - 使用 Timeline 定位问题类型
   - 使用 Flame Graph 找到热点函数

3. **深度分析**
   - 使用环境变量可视化问题
   - 使用 Statistics 查看详细数据

4. **验证优化**
   - 对比优化前后的数据
   - 确保 FPS 稳定在 60

## 参考资源

- [Qt QML Performance](https://doc.qt.io/qt-6/qtquick-performance.html)
- [QML Profiler Manual](https://doc.qt.io/qtcreator/creator-qml-performance-monitor.html)
- [Scene Graph Renderer](https://doc.qt.io/qt-6/qtquick-visualcanvas-scenegraph-renderer.html)
