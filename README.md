<p align="center">
  <img src="https://raw.githubusercontent.com/ripperhe/Resource/master/20191222/bob-log.png" />
</p>

# Bob

Bob 是一款  Mac 端翻译软件，支持**划词翻译**和**截图翻译**，当然，手动输入进行翻译也是可以的。

## 如何安装

### 下载安装

从 [GitHub release](https://github.com/ripperhe/Bob/releases) 中下载最新的 `Bob.app.zip` 安装包，然后解压拖拽到**应用程序**文件夹即可

### 开启辅助功能权限

第一次使用**划词翻译**的时候会弹出以下提示，点击 `打开系统偏好设置`，勾选上 Bob

![辅助功能权限提醒](https://raw.githubusercontent.com/ripperhe/Resource/master/20191221/辅助功能权限提醒.png)

如果不小心拒绝了，打开 `系统偏好设置-安全性与隐私-隐私-辅助功能`，确保勾选上了 Bob

![辅助功能权限](https://raw.githubusercontent.com/ripperhe/Resource/master/20191222/辅助功能权限.png)

### 开启屏幕录制权限 （macOS 10.15 以上才需要）

第一次使用**截图翻译**的时候会弹出以下提示，点击 `打开系统偏好设置`，勾选上 Bob

![屏幕录制权限提醒](https://raw.githubusercontent.com/ripperhe/Resource/master/20191221/屏幕录制权限提醒.png)

如果不小心拒绝了，打开 `系统偏好设置-安全性与隐私-隐私-屏幕录制`，确保勾选上了 Bob

![屏幕录制权限](https://raw.githubusercontent.com/ripperhe/Resource/master/20191222/屏幕录制权限.png)

## 使用方法

| 功能 | 描述 | 预览 |
| :---: | :---: | :---: |
| 划词翻译 | 选中需要翻译的文本之后，按下划词翻译快捷键即可（默认 `⌥ + D`） | ![划词翻译-句子](https://raw.githubusercontent.com/ripperhe/Resource/master/20191222/划词翻译-句子.gif) |
| 截图翻译 | 按下截图翻译快捷键（默认 `⌥ + S`），截取需要翻译的区域 | ![截图翻译-句子](https://raw.githubusercontent.com/ripperhe/Resource/master/20191222/截图翻译-句子.gif) |
| 输入翻译| 按下输入翻译快捷键（默认 `⌥ + A`），输入需要翻译的文本，`Enter` 键翻译 | ![输入翻译-单词](https://raw.githubusercontent.com/ripperhe/Resource/master/20191222/输入翻译-单词.gif) |

* 划词翻译在**可以选中文本，并且可以复制**的情况下使用
* 截图翻译建议在无法选中或复制的情况下使用
* 输入翻译通常在以上方法获取的文本不准的情况下使用

## 支持的翻译源

目前 Bob 支持有道翻译、百度翻译和谷歌翻译，以下对比比较粗糙，主要根据个人的使用体验评判的，具体细节可以自行感受

| 功能 | 有道翻译 | 百度翻译 | 谷歌翻译（国内） | 谷歌翻译 |
| :---: | :---: | :---: | :---: |  :---: |
| 支持的语种数量 |  114 | 28 | 104 | 104 |
| 速度 | 快 | 一般 | 较慢 | 较慢 |
| 是否需要科学上网| 不需要 | 不需要 | 不需要 | 需要 |
| 英语音标 | ✅ | ✅ | ❌ | ❌ |
| 句子翻译 | ✅ | ✅ | ✅ | ✅ |
| 是否有 OCR 接口 | ✅ | ✅ | ❌ | ❌ |

百度翻译和谷歌翻译可以识别驼峰形式的句子，形如 "WhatAreYouDoing"。

由于谷歌翻译没有找到合适的 OCR 接口，所以在截图翻译的时候，使用有道的 OCR 接口进行识图，然后再调用谷歌的翻译接口进行翻译。

国内谷歌翻译和谷歌翻译结果完全一样，只是谷歌翻译需科学上网使用，但国内谷歌翻译不需要。

注意：如果你已经科学上网，那么国内谷歌翻译可能会无法使用。**另外，如果你的科学上网配置不当，那会导致其他翻译接口如百度、有道翻译速度明显下降，请使用 PAC 模式而不是全局模式。**

## 常见问题

### 划词翻译获取不到文本？

首先检查一下是否开启了辅助功能权限（文章前面有开启方法），如果已开启，再检查一下所选中的文本是否可复制。划词翻译本质上就是发出 `⌘ + C` 这个组合键复制选中的文本，然后从剪切板获取文本进行翻译，所以如果文本本身没法复制，则没法获取到，此时建议使用截图翻译。

有些软件或者网站复制文本之后还会在文本后面追加一些信息，所以有时候翻译的文本和选中的可能有些出入。

### 朗读按钮点击了没反应？

朗读按钮点击之后，会进行网络请求获取音频播放，没有反应可能是句子太长，加载较慢，当然也有可能是 BUG，后期会考虑点击之后进行一些 UI 提示

### 翻译报错？

可能的原因：

* 网络问题
* 接口调用过于频繁
* 接口数据结构改变
* BUG?

建议尝试以下方案：

1. 切换翻译源
2. 重启 Bob

如果尝试之后仍旧不行，建议点击 Status Bar 图标，选中 `帮助-导出日志` ，然后提 issue，或在 QQ 群 **971584165** 反馈，并将日志文件上传

## 感谢

本仓库的灵感和部分代码来源于以下仓库

* [Selection-Translator/crx-selection-translate](https://github.com/Selection-Translator/crx-selection-translate)
* [isee15/Capture-Screen-For-Multi-Screens-On-Mac](https://github.com/isee15/Capture-Screen-For-Multi-Screens-On-Mac)

## 最后

Bob 还很年轻，可能会有各种大大小小的问题，有任何问题或者建议可以直接提 issue，或者加入 QQ 群 **971584165** 反馈，希望大家可以陪 TA 一起成长~