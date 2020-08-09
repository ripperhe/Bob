
考虑到插件内部有时候可能会需要获取插件的一些元信息，故在提供了 `$info` 用于获取 `info.json` 的数据。`$info` 不会进行任何处理，会直接将 `info.json` 文件解析之后返回。

例如获取插件主页，可以直接如下使用：

```js
var homepage = $info.homepage;
```

