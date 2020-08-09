插件根目录**至少**需要包含两个文件：

* `info.json` 描述插件信息的 json 文件，[请参考](plugin/quickstart/info.md)
* `main.js` 实现功能的 JavaScript 脚本，[请参考](plugin/quickstart/main.md)

另外，可在插件根目录放一个 `icon.png` 文件作为插件图标。为了更好的展示效果，建议使用 `256x256` 像素的 png 图片。除了这个方法，也可以在 `info.json` 文件中设置 `icon` 字段，使用 Bob 内置的一些图标，这个在介绍 `info.json` 的文档中有说明。

## 手动创建

你可以手动创建一个文件夹做为插件根目录，再创建以上文件放入该文件夹即可。

## 使用模板

为了方便开发，我们给不同类型的插件分别创建了模板，你可以直接**点击下方链接下载**，每个模板文件是一个压缩包，将其解压即可。

* [文本翻译插件模板](https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0805/bob-plugin-template-translate.zip)
* [文本识别插件模板](https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0805/bob-plugin-template-ocr.zip)
* [语音合成插件模板](https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0805/bob-plugin-template-ocr.zip)