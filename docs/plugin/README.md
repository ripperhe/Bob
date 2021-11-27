Bob 这个软件本身非常轻量，对于 macOS 系统而言就像是一个「插件」一样，Bob 插件我也尽量把它做得简单。

插件本质上就是对 [服务](general/quickstart/service) 的一种扩充，通过插件你可以自定义服务，并将其接入到 Bob 主程序。

## 原理

插件需要使用 `JavaScript` 语言开发，使用插件的时候，Bob 主程序会利用 [JavaScriptCore](https://developer.apple.com/documentation/javascriptcore) 引擎将插件加载到内存中，然后调用插件实现的相关函数，以达到调用插件的效果。

## 运行环境

需要注意的是，插件运行环境不是 `Web` 环境，也不是 `Node.js` 环境，只可以使用如下几种 API：

* JavaScript 语言内置对象和内建函数
* Bob 额外提供的对象和函数（[点此查看](plugin/api/intro.md)）
* 自行导入或实现的代码模块

## 插件类型

由于插件是对服务的一种扩充，服务分为几种类型（文本翻译、文本识别...），所以插件也是需要指定类型，不同类型的插件，需要实现的函数也有所差异。

## 感谢

Bob 插件主要参考钟颖大佬的 [JSBox](https://docs.xteko.com/#/)，特此感谢。

