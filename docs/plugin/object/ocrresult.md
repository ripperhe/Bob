# ocr result

文本识别结果对象，具体如下

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| from | string | 图片中的文字的主要语言，可与查询参数中传入的 `from` 不一致，可不传。查看 [语言代码](plugin/addition/language.md)。 |
| texts | array | 文本识别结果数组，按照段落分割，见 [ocr text](#ocr-text)，必传。 |
| raw | any | 如果插件内部调用了某文本识别接口，可将接口原始数据传回，方便定位问题，可不传。 |

## ocr text

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| text | string | 识别出的文本 |

##  示例

```json
{
    "from": "en",
    "texts": [
        {
            "text": "New features available with macOS Catalina."
        },
        {
            "text": "macOS Catalina gives users powerful ways to do amazing things. So you can create and discover like never before."
        }
    ],
    "raw": {}
}
```