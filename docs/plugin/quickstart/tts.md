语音合成插件需要实现两个函数：

1. 获取支持的语言数组的函数
2. 执行语音合成的函数

## 1. 获取支持的语言数组

与文本翻译插件要求相同，[点此查看](plugin/quickstart/translate.md)。

## 2. 执行文字识别

```javascript
function tts(query, completion) {
    ...
    ...
    completion({'result': result});
    // or
    completion({'error': error});    
}
```

该函数在每次进行语音合成的时候会被调用。

* `query` 参数为 `object` 类型，用于描述需要合成的文本信息
* `completion` 参数为 `function` 类型，用于合成完成后回调

### query

`query` 参数的结构如下:

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| text | string | 需要合成的文本 |
| lang | string | 当前文本的语言，一定不是 `auto`。查看 [语言代码](plugin/addtion/language.md)。 |

示例：

```javascript
{
    'text': 'What are you doing',
    'lang': 'en'
}
```

### completion

`completion` 函数的参数为 `object` 类型，根据不同情况赋值对应属性：

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| result | [tts result](plugin/object/ttsresult.md) | 翻译成功时，设置该属性。 |
| error | [service error](plugin/object/serviceerror.md) | 合成错误时，设置该属性。 |

