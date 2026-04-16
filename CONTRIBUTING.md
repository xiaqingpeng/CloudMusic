# 贡献指南

感谢您考虑为 CloudMusic 做出贡献！

## 行为准则

请遵守我们的行为准则，保持友好和专业的交流。

## 如何贡献

### 报告 Bug

在提交 Bug 报告之前，请：

1. 检查是否已有相同的 Issue
2. 使用最新版本测试问题是否仍然存在
3. 收集相关信息（系统版本、Qt 版本、错误日志等）

提交 Bug 时请包含：

- 清晰的标题和描述
- 重现步骤
- 预期行为和实际行为
- 截图（如适用）
- 环境信息

### 提交功能请求

功能请求应该：

- 清楚地描述功能
- 解释为什么需要这个功能
- 提供使用场景示例

### 提交代码

#### 开发环境设置

```bash
# 克隆仓库
git clone https://github.com/yourusername/CloudMusic.git
cd CloudMusic

# 创建开发分支
git checkout -b feature/your-feature-name

# 安装依赖
# 确保已安装 Qt 6.2+

# 构建项目
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTS=ON
cmake --build .
```

#### 代码规范

**C++ 代码**

```cpp
// 类名：PascalCase
class AudioService {
public:
    // 函数名：camelCase
    void playAudio();
    
    // 成员变量：m_ 前缀 + camelCase
    int m_volume;
    
private:
    // 私有成员
    QString m_currentTrack;
};

// 常量：UPPER_CASE
const int MAX_VOLUME = 100;

// 命名空间：小写
namespace cloudmusic {
    // ...
}
```

**QML 代码**

```qml
// 组件名：PascalCase
Rectangle {
    id: root  // id 使用 camelCase
    
    // 属性：camelCase
    property int itemCount: 0
    property string userName: ""
    
    // 信号：camelCase
    signal itemClicked(int index)
    
    // 函数：camelCase
    function updateData() {
        // ...
    }
}
```

#### 提交信息规范

使用语义化的提交信息：

```
<type>(<scope>): <subject>

<body>

<footer>
```

类型（type）：
- `feat`: 新功能
- `fix`: Bug 修复
- `docs`: 文档更新
- `style`: 代码格式调整
- `refactor`: 代码重构
- `test`: 测试相关
- `chore`: 构建/工具相关

示例：

```
feat(player): add shuffle play mode

- Implement shuffle algorithm
- Add UI toggle button
- Update player state management

Closes #123
```

#### Pull Request 流程

1. 确保代码通过所有测试
2. 更新相关文档
3. 添加必要的测试用例
4. 确保代码符合规范
5. 提交 PR 并填写模板

PR 标题格式：

```
[Type] Brief description
```

示例：
```
[Feature] Add dark theme support
[Fix] Resolve audio playback issue on macOS
[Docs] Update installation guide
```

#### 代码审查

所有 PR 都需要至少一位维护者的审查。审查者会检查：

- 代码质量和可读性
- 是否符合项目规范
- 测试覆盖率
- 文档完整性
- 性能影响

### 测试

#### 运行测试

```bash
cd build
ctest --output-on-failure
```

#### 编写测试

为新功能添加单元测试：

```cpp
#include <QtTest>

class AudioServiceTest : public QObject {
    Q_OBJECT

private slots:
    void testPlayAudio();
    void testPauseAudio();
};

void AudioServiceTest::testPlayAudio() {
    AudioService service;
    service.play();
    QVERIFY(service.isPlaying());
}

QTEST_MAIN(AudioServiceTest)
#include "AudioServiceTest.moc"
```

### 文档

更新文档时：

- 使用清晰简洁的语言
- 提供代码示例
- 添加截图（如适用）
- 保持格式一致

## 发布流程

1. 更新版本号（CMakeLists.txt）
2. 更新 CHANGELOG.md
3. 创建 Git tag
4. 构建发布包
5. 发布到 GitHub Releases

## 获取帮助

如有疑问，可以：

- 查看 [文档](docs/)
- 提交 Issue
- 加入讨论区
- 发送邮件至 dev@cloudmusic.com

## 许可证

贡献的代码将采用与项目相同的 MIT 许可证。

---

再次感谢您的贡献！
