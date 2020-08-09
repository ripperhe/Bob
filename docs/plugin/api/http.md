发送网络请求可能是插件最核心的需求了，`$http` 就是用来解决这个问题的。

## $http.request(object)

发送一个 HTTP 请求，参数是一个 `object` 类型，可具有以下属性：

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| method | string | GET/POST/DELETE 等 |
| url | string | 链接 |
| header | object | http header |
| body | object / [$data](plugin/api/data.md) | http body |
| files | array | 文件列表 |
| timeout | number | 请求超时 |
| handler | function | 回调函数 |

#### body

其中 `body` 可以是一个 JSON 结构或 [$data](plugin/api/data.md) 类型的数据。

> 如果 `body` 为一个 JSON 结构：

* 当发送 `GET`、`HEAD` 和 `DELETE` 请求时，默认会将 body 作为 `query string` 拼接到 url 后方
* 当设置了 `files`，header 中的 `Content-Type` 将被强制设置为 `multipart/form-data`，body 将作为 form-data 中其他的参数
* 当 header 中的 `Content-Type` 为 `application/json` 时，body 将会以 json 的形式编码
* 当 header 中的 `Content-Type` 为 `application/x-www-form-urlencoded` 时，`body` 将会转换成 a=b&c=d 的 query 结构
* `Content-Type` 默认值是 `application/x-www-form-urlencoded`

> 如果 `body` 是 `$data` 类型的数据：

这时 http body 不会进行编码，会直接使用传进来的数据。

#### files

某些接口上传文件需要以 `multipart/form-data` 的形式，此时需要设置 `files` 参数，`files` 是一个数组，包含的元素需要以如下结构：

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| data | $data | 二进制数据 |
| name | string	 | 上传表单中的名称 |
| filename | string | 上传之后的文件名 |
| content-type | string | 文件格式 |

#### handler

`handler` 是网络请求的回调，该回调函数只有一个参数，结构如下：

| 参数 | 类型 | 说明 |
| --- | --- | --- |
| data | object / string / $data | 解析过后的数据 |
| rawData | $data | 返回的原始的二进制数据 |
| response | response | 请求响应信息 |
| error | error | 错误 |

关于 `data` 参数：

* 返回数据为 json 数据时会自动解析为 `object`
* 解析 json 失败时，会尝试解析为 `UTF-8` 格式的 `string`
* 如果再次失败，会直接设置为 $data 类型的原始二进制数据

`response` 包含请求响应信息:

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| url | string | url |
| MIMEType | string | MIME 类型 |
| expectedContentLength | number | 长度 |
| textEncodingName | string | 编码 |
| suggestedFilename | string | 建议的文件名 |
| statusCode | number | HTTP 状态码 |
| headers | object | HTTP header |

当存在 `error` 参数，代表网络请求错误，结构如下：

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| domain | string | domain |
| code | number | code |
| userInfo | object | userInfo |
| localizedDescription | string | 描述 |
| localizedFailureReason | string | 原因 |
| localizedRecoverySuggestion | string | 建议 |

尝试发送一个网络请求：

```js
$http.request({
  method: "POST",
  url: "https://apple.com",
  header: {
    k1: "v1",
    k2: "v2"
  },
  body: {
    k1: "v1",
    k2: "v2"
  },
  handler: function(resp) {
    var data = resp.data
  }
});
```

## $http.get(object)

所有参数和 `request` 方法一致，唯一就是自动将 `method` 方法设置为 `GET`。

发送一个 `GET` 请求：

```js
$http.get({
  url: "https://apple.com",
  handler: function(resp) {
    var data = resp.data
  }
});
```

## $http.post(object)

所有参数和 `request` 方法一致，唯一就是自动将 `method` 方法设置为 `POST`。

发送一个 `GET` 请求：

```js
$http.post({
  url: "https://apple.com",
  handler: function(resp) {
    var data = resp.data
  }
});
```

## Promise

`$http` 所有 API 支持 Promise，如果设置了 `handler` 参数，将通过该回调函数返回数据；如果没有设置 `handler` 参数，将返回一个 Promise 对象。

例如：

```js
async function foo() {
    var resp = await $http.get({url: "https://apple.com"});
}
```