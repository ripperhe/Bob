<p align="center">
  <img src="https://cdn.ripperhe.com/oss/master/2019/1222/bob-logo.png" width=240 />
</p>
<p align="center">
	<a href="https://bobtranslate.com"><img src="https://img.shields.io/badge/%E5%AE%98%E6%96%B9%E7%BD%91%E7%AB%99-bobtranslate.com-brightgreen?logo=Safari" alt="Website" /></a>
  <a href="https://bobtranslate.com/general/contact.html"><img src="https://img.shields.io/badge/QQ%20%E7%BE%A4-696381611-blue?logo=Tencent%20QQ" alt="QQ 群" /></a>
</p>

> [!NOTE]
> Bob 不是开源软件，本仓库曾经用于提供反馈渠道，现在请通过 [这个链接](https://bobtranslate.com/general/contact.html) 联系我们。

# Bob

Bob 是一款 macOS 平台的 **翻译** 和 **OCR** 软件。

主要特性：

- **翻译功能**：划词翻译、截图翻译、输入翻译、翻译多开、自定义插件、自动识别语种、驼峰拆分、蛇形拆分、AppleScript 调用、PopClip 调用
- **OCR 功能**：截图 OCR、静默截图 OCR、访达选图 OCR、离线识别、连续识别、二维码识别、自动复制、智能分段

支持的服务：

- **文本翻译**：系统翻译、火山翻译、腾讯翻译君、阿里翻译、百度翻译、有道翻译、彩云小译、小牛翻译、Google 翻译、Microsoft 翻译、Amazon 翻译、DeepL 翻译、OpenAI 翻译
- **文本识别**：离线文本识别、火山 OCR、腾讯 OCR、腾讯图片翻译、百度 OCR、有道 OCR、Google OCR
- **语音合成**：离线语音合成、火山语音合成	、腾讯语音合成、Google 语音合成、Microsoft 语音合成

## 安装

[![Download on the Mac App Store](https://cdn.ripperhe.com/oss/master/2022/0626/Download_on_the_Mac_App_Store_Badge_US-UK_RGB_blk_092917.svg)](https://apps.apple.com/cn/app/id1630034110#?platform=mac)

## 使用方法

详细使用方法请直接查看文档 [👉 点此跳转文档](https://bobtranslate.com)

Bob 是一个菜单栏软件，启动之后，菜单栏会出现一个图标，点击菜单选项即可触发相应的功能，如下所示：

<img src="https://cdn.ripperhe.com/oss/master/2022/0627/status_item.jpg" alt="statesitem.jpg" width=548>

### 翻译功能

| 方式 | 描述 | 预览 |
| :---: | :---: | :---: |
| 划词翻译 | 选中需要翻译的文本之后，按下划词翻译快捷键即可（默认 `⌥ + D`） | ![划词翻译-句子](https://cdn.ripperhe.com/oss/master/2022/0508/translate_selection.gif) |
| 截图翻译 | 按下截图翻译快捷键（默认 `⌥ + S`），截取需要翻译的区域 | ![截图翻译-句子](https://cdn.ripperhe.com/oss/master/2022/0508/translate_snip.gif) |
| 输入翻译| 按下输入翻译快捷键（默认 `⌥ + A`），输入需要翻译的文本，`Enter` 键翻译 | ![输入翻译-单词](https://cdn.ripperhe.com/oss/master/2022/0508/translate_input.gif) |
| PopClip 调用 | 选中需要翻译的文本之后，点击 [PopClip](https://pilotmoon.com/popclip) 插件图标即可，详情见 [PopClip 调用](https://bobtranslate.com/guide/integration/popclip.html) | ![插件翻译-句子](https://cdn.ripperhe.com/oss/master/2022/0508/translate_popclip.gif) |

### OCR 功能

**截图识别**

* 按下「截图 OCR」快捷键（默认 `⇧ + ⌥ + S`）或者点击菜单栏 Bob 图标菜单中的「截图 OCR」
* 选中屏幕上的对应的位置
* 松手即可开始识别

<img src="https://cdn.ripperhe.com/oss/master/2022/0507/snip_ocr.gif" alt="截图 OCR" width=660 />

**静默截图 OCR**

* 按下「静默截图 OCR」快捷键（默认 `⌥` `C`）或者点击菜单栏 Bob 图标菜单中的「静默截图 OCR」
* 选中屏幕上的对应的位置
* 松手即可开始识别

「静默截图 OCR」不会自动显示 OCR 窗口，识别完成后直接将文本拷贝到剪切板。

**访达选图 OCR**

按下「访达选图 OCR」快捷键（没有设置默认快捷键，可去「 Bob 偏好设置-OCR-OCR 设置」添加）或者点击菜单栏 Bob 图标菜单中的「访达选图 OCR」。

在弹出的访达窗口中选中对应的图片文件（可以一次性选中多张），点击右下角「开始识别」即可。

<img src="https://cdn.ripperhe.com/oss/master/2022/0507/file_ocr.jpg" alt="访达选图 OCR" width=600 />

## 感谢

* 感谢 [@isee15](https://github.com/isee15/Capture-Screen-For-Multi-Screens-On-Mac) 提供最初版本截图功能的思路
* 感谢 [@可口可乐](https://github.com/wakewon) 长期帮忙解决用户反馈
* 感谢 [@ix4n33](https://github.com/IsaacXen) 不定期提供技术支持
* 感谢朋友们的赞赏 [赞赏列表](https://bobtranslate.com/general/reward.html)
* 感谢作者们发文支持 Bob（时间倒序）
    * @火山翻译：[双厨狂喜：Bob x 火山翻译梦幻联动！](https://mp.weixin.qq.com/s/c5zwcDsCgL10m_WdBiksEQ)
    * @奇客派：[macOS 翻译工具 Bob 大更新：支持更多翻译服务，增强 OCR 功能](https://sspai.com/post/62721)
    * @鹿額：[截图/划词/输入都能查，快捷高效的 macOS 翻译工具: Bob](https://sspai.com/post/58249)
    * @Newlearnerの自留地：[Bob：一款 macOS 全局翻译软件，支持划词翻译和截图翻译](https://t.me/NewlearnerChannel/3329)

## 优秀软件推荐

* [uPic: 一个强大的图床工具](https://github.com/gee1k/uPic)
* [MWeb Pro: 专业的 Markdown 写作、记笔记、静态博客生成软件](https://zh.mweb.im/)
* [Picsee: 专业的图片采集收藏、照片整理标记、查找查看、分享协同软件](https://picsee.chitaner.com)
* [赤友 NTFS 助手: Mac用户最喜欢的 NTFS for Mac 读写软件](https://aibotech.cn/ntfs-for-mac/)
* [赤友右键超人: Mac 右键快捷操作工具，集合右键新建文件、卸载软件、压缩文件、剪切、截图录屏超多功能，一键快速搞定！](https://aibotech.cn/right-click-menu/)

