`info.json` 文件是一个 json 文件，用于描述插件的元信息，由以下字段组成。

| 字段 | 类型 | 是否必须 | 说明 |
| --- | --- | :---: | --- |
| identifier | string | ✅ | 插件的唯一标识符，必须由数字、小写字母和 `.` 组成。 |
| version | string | ✅ | 插件版本号，必须由数字、小写字母和 `.` 组成。 |
| category | string | ✅ | 插件类别，值只可以是 `translate`、`ocr` 和 `tts`，分别对应文本翻译、文本识别和语音合成。 |
| name | string | ✅ | 插件名称，无限制，建议别太长。 |
| summary | string | - | 插件描述信息。 |
| icon | string | - | 插件图标标识符，如果插件根目录有 `icon.png` 文件，则会将其作为插件图标，不会读取该字段；如果没有，会读取该字段，值可以为 [这个图标列表](plugin/addtion/icon.md) 中所包含的任意一个ID。 |
| author | string | - | 插件作者。 |
| homepage| string | - | 插件主页网址。 |
| appcast | string | - | 插件发布信息 URL。详情见 [发布插件](plugin/quickstart/publish.md)。 |
| minBobVersion | string | - | 最低支持本插件的 Bob 版本，建议填写您开发插件时候的 Bob 版本，目前应该是 `0.5.0`。 |
| options | array | - | 插件选项数组，该字段用于提供一些选项供用户选择或填写，详情见 `option object`。 |

## option object

| 字段 | 类型 | 是否必须 | 说明 |
| --- | --- | :---:| --- |
| identifier | string | ✅ | 选项唯一标识符，取值时使用。 |
| type | string | ✅ | 选项类型，值只可以是 `text` 和 `menu`，分别对应输入框和菜单。 |
| title | string | ✅ | 选项名称，用于展示。 |
| defaultValue | string | - | 默认值。 |
| menuValues | array | type 为 `menu` 时必须有 | 菜单选项数组，详情见 `menu object`。 |

## menu object

| 字段 | 类型 | 是否必须 | 说明 |
| --- | --- | :---: | --- |
| title | string | ✅ | 菜单选项名称，用于展示。 | 
| value | string | ✅ | 当前菜单被选中时的值。 |

## 示例

```json
{
    "identifier": "com.ripperhe.translate.test",
    "version": "0.1.0",
    "category": "translate",
    "name": "测试插件",
    "summary": "这是一个用于测试的插件。",
    "icon": "001",
    "author": "ripperhe",
    "homepage": "https://github.com",
    "minBobVersion": "0.5.0",
    "options": [
        {
            "identifier": "option1",
            "type": "text",
            "title": "测试输入框"
        },
        {
            "identifier": "option2",
            "type": "menu",
            "title": "测试菜单",
            "defaultValue": "1",
            "menuValues": [
                {
                    "title": "菜单1",
                    "value": "1"
                },
                {
                    "title": "菜单2",
                    "value": "2"
                }
            ]
        }
    ]
}
```

由于以上 json 设置了 `options` 字段，所以使用该插件时可以看到设置项，如下所示：

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0807/plugin-option-1.png" alt="plugin-option-1" width="800" />

`menu` 类型的展开效果如下：

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0807/plugin-option-2.png" alt="plugin-option-2" width="400" />

用户在这里设置之后，插件内部可以根据相应 `option object` 的 `identifier` 取值，具体请查看 [$option](plugin/api/option.md) 相关文章。








