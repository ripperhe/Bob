文本翻译插件需要实现两个函数:

1. 获取支持的语言数组的函数
2. 执行翻译的函数

## 1. 获取支持的语言数组

```js
function supportLanguages() {
    return ['auto', 'zh-Hans', 'en', ...];
}
```

该函数不需要参数，调用时返回支持的语言字符串数组即可。

鉴于各个服务商的语言标识符都略有差异，我定义了一套 Bob 专用的语言代码，所有需要回传语言给 Bob 主程序的地方，都要使用 [这套语言代码](plugin/addition/language.md)。

## 2. 执行翻译

```js
function translate(query, completion) {
    ...
    ...
    completion({'result': result});
    // or
    completion({'error': error});    
}
```

该函数在每次翻译的时候会被调用。

* `query` 参数为 `object` 类型，用于传入需要翻译的文本信息
* `completion` 参数为 `function` 类型，用于翻译完毕之后回调

### query

`query` 参数的结构如下:

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| text | string | 需要翻译的文本。 |
| from | string | 用户选中的源语言代码，可能是 `auto`。查看 [语言代码](plugin/addition/language.md)。 |
| to | string | 用户选中的目标语言代码，可能是 `auto`。查看 [语言代码](plugin/addition/language.md)。 |
| detectFrom | string | 检测过后的源语言，一定不是 `auto`，如果插件不具备检测语言的能力，可直接使用该属性。查看 [语言代码](plugin/addition/language.md)。 |
| detectTo | string | 检测过后的目标语言，一定不是 `auto`，如果不想自行推测用户实际需要的目标语言，可直接使用该属性。查看 [语言代码](plugin/addition/language.md)。 |

示例：

```javascript
{
    "text": "good",
    "from": "auto",
    "to": "auto",
    "detectFrom": "en",
    "detectTo": "zh-Hans"
}
```

### completion

`completion` 函数的参数为 `object` 类型，根据不同情况赋值对应属性：

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| result | [translate result](plugin/object/translateresult.md) | 翻译成功时，设置该属性。 |
| error | [service error](plugin/object/serviceerror.md) | 翻译错误时，设置该属性。 |