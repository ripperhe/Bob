
# service error

为了统一错误信息，所有插件返回错误的时候都按照以下格式

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| type | string | 错误类型，可设置为下方错误之一 |
| message | string | 错误描述，用于展示给用户看 |
| addtion | any | 附加信息，可以是任何可 json 序列化的数据类型，用于 debug |

错误类型（`type`）如下：

* `unknown` 未知错误
* `param` 参数错误
* `unsupportLanguage` 不支持的语种
* `secretKey` 缺少秘钥
* `network` 网络异常，网络请失败
* `api` 服务接口异常

请尽量将错误类型（`type`）设置正确，如果实在不知道错误类型归为哪一类，`type` 可设置为 `unknown`，但一定要设置好 `message`，用于提示
