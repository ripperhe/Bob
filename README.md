<p align="center">
  <img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2019/1222/bob-logo.png" width=240 />
</p>
<p align="center">
	<a href="https://github.com/ripperhe/Bob/releases/latest"><img src="https://img.shields.io/github/v/release/ripperhe/Bob?logo=github" alt="GitHub release" /></a>
	<a href="https://qm.qq.com/cgi-bin/qm/qr?k=giz1s49Y8MM1sVMJkTgl9TDAJ1223tqo&jump_from=webapi"><img src="https://img.shields.io/badge/QQ%20%E7%BE%A4-459542798-red" alt="QQ群" /></a>
	<a href="https://ripperhe.gitee.io/bob/"><img src="https://img.shields.io/badge/docsify-%E8%AF%A6%E7%BB%86%E4%BD%BF%E7%94%A8%E6%96%87%E6%A1%A3-brightgreen" alt="Document" /></a>
</p>
<p align="center">
  <strong>Chinese</strong> | <a href="https://github.com/ripperhe/Bob/blob/master/README.en.md">English</a>
</p>

# Bob

Bob 是一款 Mac 端翻译软件，支持**划词翻译**、**截图翻译**以及手动输入翻译。

- [x] 划词翻译
- [x] 截图翻译
- [x] 输入翻译
- [x] 翻译多开
- [x] 自定义插件
- [x] 自动识别语种
- [x] 驼峰拆分、蛇形拆分
- [x] AppleScript 调用
- [x] PopClip 调用

## 如何安装

### 系统要求

| 版本 | 系统要求 |
| --- | --- |
| 0.1.0 - 0.4.0 | macOS 10.12+ |
| 0.5.0+ | macOS 10.13+ |

### Homebrew Cask 安装

```bash
brew install --cask bob
```

### 手动安装

| 渠道 | 建议 | 下载 |
| --- | --- | --- |
| 从 [GitHub release](https://github.com/ripperhe/Bob/releases) 下载 | 国外从这里下载更快 | [点此下载 ⬇](https://github.com/ripperhe/Bob/releases/latest/download/Bob.zip) |
| 从 [Gitee release](https://gitee.com/ripperhe/Bob/releases) 下载 | 国内从这里下载更快 | [点此下载 ⬇](https://gitee.com/ripperhe/Bob/attach_files/893969/download/Bob.zip) |

下载完成之后，解压并拖拽到**应用程序**文件夹即可

## 使用方法

| 功能 | 描述 | 预览 |
| :---: | :---: | :---: |
| 划词翻译 | 选中需要翻译的文本之后，按下划词翻译快捷键即可（默认 `⌥ + D`） | ![划词翻译-句子](https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0117/划词翻译-句子.gif) |
| 截图翻译 | 按下截图翻译快捷键（默认 `⌥ + S`），截取需要翻译的区域 | ![截图翻译-句子](https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0117/截图翻译-句子.gif) |
| 输入翻译| 按下输入翻译快捷键（默认 `⌥ + A`），输入需要翻译的文本，`Enter` 键翻译 | ![输入翻译-单词](https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0117/输入翻译-单词.gif) |
| PopClip 调用 | `0.3.0` 版本开始支持，选中需要翻译的文本之后，点击 [PopClip](https://pilotmoon.com/popclip/) 插件图标即可，详情见 [PopClip 调用](https://ripperhe.gitee.io/bob/#/general/integration/popclip) | ![插件翻译-句子](https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0117/插件翻译-句子.gif) |

* 划词翻译在**可以选中文本，并且可以复制**的情况下使用
* 截图翻译建议在无法选中或复制的情况下使用
* 输入翻译通常在以上方法获取的文本不准的情况下使用

## 开发者

<!--<a href="https://github.com/ripperhe/Bob/graphs/contributors"><img src="https://opencollective.com/bob_/contributors.svg?width=890&button=false" /></a>
-->

<p>
<a href="https://github.com/chensifang">
<img src="https://avatars0.githubusercontent.com/u/10810457?v=4" alt="chengsifang" width="50" style="border-radius:50%"/></a>
<a href="https://github.com/ripperhe">
<img src="https://avatars0.githubusercontent.com/u/13943595?v=4" alt="ripperhe" width="50" style="border-radius:50%"/></a>
</p>

## 感谢

* 感谢 [@isee15](https://github.com/isee15/Capture-Screen-For-Multi-Screens-On-Mac) 提供最初版本截图功能的思路
* 感谢 [@可口可乐](https://github.com/wwk7225) 长期帮忙解决用户反馈
* 感谢 [@ix4n33](https://github.com/IsaacXen) 不定期提供技术支持
* 感谢朋友们的赞赏（由于更新缓慢，赞赏码暂时不贴了） [赞赏列表](https://ripperhe.gitee.io/bob/#/general/reward)
* 感谢作者们发文支持 Bob（时间倒序）
    * @奇客派：[macOS 翻译工具 Bob 大更新：支持更多翻译服务，增强 OCR 功能](https://sspai.com/post/62721)
    * @鹿額：[截图/划词/输入都能查，快捷高效的 macOS 翻译工具: Bob](https://sspai.com/post/58249)
    * @Newlearnerの自留地：[Bob：一款 macOS 全局翻译软件，支持划词翻译和截图翻译](https://t.me/NewlearnerChannel/3329)

## 最后

目前本仓库主要用于部署使用教程和提供反馈渠道，**最后一个开源的版本为 `0.2.0`，可在 `archive_0.2.0` 文件夹查看。**

有任何问题或建议请优先在 GitHub [提 issue](https://github.com/ripperhe/Bob/issues)，回复不一定及时，我有空闲时间一定会来处理的。

另外，非常欢迎加入 QQ 群 **459542798** 讨论。