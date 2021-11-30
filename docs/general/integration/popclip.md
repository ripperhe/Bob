如果期望划词之后鼠标附近出现一个小图标，点击之后即可翻译选中的文本，则你的电脑上需要安装 [PopClip](https://pilotmoon.com/popclip/)，并且给 PopClip 安装调用 Bob 的插件

!> Bob 从 `0.3.0` 版本开始支持 PopClip 插件

## 如何安装

有的朋友可能没有用过 PopClip，PopClip 也是一个 Mac 软件，主要作用就是你选中一段文本之后，鼠标位置会出现一个菜单，每个菜单对应一个功能，我们要为 PopClip 安装一个插件，让它支持调用 Bob。

### 安装 PopClip

进入 PopClip 官网下载安装 <https://pilotmoon.com/popclip/>

### 安装插件

PopClip 插件项目地址: <https://github.com/ripperhe/bob-popclip>

* 下载插件 `Bob.popclipextz` [点此下载 ⬇](https://cdn.jsdelivr.net/gh/ripperhe/bob-popclip@master/extension/Bob.popclipextz)
* 插件下载完成后，**双击插件**
* 如果在 PopClip 的插件页面出现以下图示即代表安装成功
	
<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0202/popclip-install-bob.png" alt="popclip-install-bob" width="250" />

## 如何使用

将 PopClip 开启，选中一段文本之后会在鼠标附近出现一个菜单（具体显示什么根据你所安装的插件而定），此时点击 Bob 插件图标即可翻译

![bob-popclip](https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0117/插件翻译-句子.gif)

## 几点建议

1. 如果 PopClip 只是用于调用 Bob 的话，建议在插件页面将其他插件全部关闭
2. PopClip 默认会进行一些拼写的检测，选中某些文本之后会出现以下样式的菜单

	<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0202/popclip-spell.png" alt="popclip-spell" width="300" />
	
	为了防止其影响使用，可以在设置页面将 `拼写语言` 设置为 `无`
	
	<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0202/popclip-spell-close.png" alt="popclip-spell-close" width="250" />

3. 如果想要在某些 App 不展示菜单，可以在排除页面加上对应 App
	
	<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0202/popclip-shield-app.png" alt="popclip-shield-app" width="250" />
