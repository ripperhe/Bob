之前在介绍 [info.json](plugin/quickstart/info.md) 文件的时候讲过，插件可以通过配置 `info.json` 的 `options` 字段来提供一些配置项供用户设置。`$option` 就是用于获取用户的设置。

`options` 是一个数组，每个元素是一个 `option object` 对象，每个 `option object` 对象都包含 `identifier` 属性。一个 `option object` 对象本质上就是一个选项，通过每个选项的 `identifier` 就可以获取到选项的值。

假如有这样一个 `info.json` 文件：

```json
{
    "identifier": "com.xxx.xxx",
    "version": "0.1.0",
    ...
    "options": [
        {
            "identifier": "token",
            "type": "text",
            "title": "秘钥"
        }
    ]
}

```

那么在获取用户设置的「秘钥」的时候，就可以这样获取

```js
var token = $option.token;
```