# tts result

语音合成数据对象，具体如下

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| type | string | 数据类型，必传。 |
| value | string | 值，必传。 |
| raw | any | 如果插件内部调用了某语音合成接口，可将接口原始数据传回，方便定位问题，可不传。|

其中类型（`type`）可以为：

* `url`  表示 `value` 对应的值为一个 URL，可直接将音频下载播放
* `base64` 表示 `value` 对应的值为一个 Base64 字符串，可将其转换为音频数据后播放

## 示例

`url` 类型

```json
{
    "type": "url",
    "value": "http://xxxxxxxxxx...",
    "raw": {}
}
```

`base64` 类型

```json
{
    "type": "base64",
    "value": "UklGRht/AABXQVZFZm10IBAAAAABAAEA...",
    "raw": {}
}
```