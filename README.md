<p align="center">
  <img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2019/1222/bob-logo.png" width=240 />
</p>
<p align="center">
	<a href="https://github.com/ripperhe/Bob/releases/latest"><img src="https://img.shields.io/github/v/release/ripperhe/Bob?logo=github" alt="GitHub release" /></a>
	<a href="https://jq.qq.com/?_wv=1027&k=UYj7vAPG"><img src="https://img.shields.io/badge/QQ%20%E7%BE%A4-971584165-red" alt="QQ群" /></a>
</p>
<p align="center">
  <strong>Chinese</strong> | <a href="https://github.com/ripperhe/Bob/blob/master/README.en.md">English</a>
</p>
<p align="center">
  <a href="https://ripperhe.gitee.io/bob/">⚡️ 详细使用教程</a>
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
brew cask install bob
```

### 手动安装

| 渠道 | 建议 | 下载 |
| --- | --- | --- |
| 从 [GitHub release](https://github.com/ripperhe/Bob/releases) 下载 | 国外用这个 | [点此下载 ⬇](https://github.com/ripperhe/Bob/releases/latest/download/Bob.zip) |
| 从 [Gitee release](https://gitee.com/ripperhe/Bob/releases) 下载 | 国内用这个 | [点此下载 ⬇](https://gitee.com/ripperhe/Bob/attach_files/534304/download/Bob.zip) |

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

本仓库的灵感和部分代码来源于以下仓库

* [Selection-Translator/crx-selection-translate](https://github.com/Selection-Translator/crx-selection-translate)
* [isee15/Capture-Screen-For-Multi-Screens-On-Mac](https://github.com/isee15/Capture-Screen-For-Multi-Screens-On-Mac)

## 最后

**最后一个开源的版本为 `0.2.0`，如需查看，可克隆仓库，在 `archive_0.2.0` 文件夹查看**

有任何问题和建议可以加 QQ 群 **971584165** 讨论，由于更新缓慢，赞赏码暂时不贴了，再次感谢所有曾经支持过 Bob 的朋友 🤝

[赞赏列表](RewardList.md)