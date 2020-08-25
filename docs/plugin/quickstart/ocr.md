文本识别插件需要实现两个函数：

1. 获取支持的语种数组的函数
2. 执行文字识别的函数

## 1. 获取支持的语种数组

与文本翻译插件要求相同，[点此查看](plugin/quickstart/translate.md)。

## 2. 执行文字识别

```javascript
function ocr(query, completion) {
    ...
    ...
    completion({'result': result});
    // or
    completion({'error': error});    
}
```

该函数在每次进行图片识别的时候会被调用。

* `query` 参数为 `object` 类型，用于描述需要识别的图片信息
* `completion` 参数为 `function` 类型，用于识别完成后回调

### query

`query` 参数的结构如下:

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| image | [$data](plugin/api/data.md) | 需要识别的图片数据 |
| from | string | 目前用户选中的源语言，可能是 `auto`。查看 [语种列表](plugin/addtion/language.md)。 |
| detectFrom | string | 图片中最可能的语言，一定不是 `auto`，如果插件不具备检测语种的能力，可直接使用该属性。查看 [语种列表](plugin/addtion/language.md)。 |

示例：

```javascript
{
    'image': $data数据,
    'from': 'auto',
    'detectFrom': 'en'
}
```

### completion

`completion` 函数的参数为 `object` 类型，根据不同情况赋值对应属性：

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| result | [ocr result](plugin/object/ocrresult.md) | 翻译成功时，设置该属性。 |
| error | [service error](plugin/object/serviceerror.md) | 识别错误时，设置该属性。 |

