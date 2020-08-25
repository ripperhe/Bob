# translate result

文本翻译插件翻译成功之后，需要将数据组装为以下结构，以便 Bob 解析展示。如果只回传翻译结果，数据结构并不复杂，但是如果加上词典结果，会复杂不少，具体如下

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| from | string | 由翻译接口提供的源语种，可以与查询时的 from 不同。查看 [语种列表](plugin/addtion/language.md)。 |
| to | string | 由翻译接口提供的目标语种，可以与查询时的 to 不同。查看 [语种列表](plugin/addtion/language.md)。 |
| fromParagraphs | array | 原文分段拆分过后的 `string` 数组，可不传。 |
| toParagraphs | array | 译文分段拆分过后的 `string` 数组，必传。 |
| toDict | object | 词典结果，见 [to dict object](#to-dict-object)。可不传。 |
| fromTTS | [tts result](plugin/object/ttsresult.md) | 原文的语音合成数据，如果没有，可不传。 |
| toTTS | [tts result](plugin/object/ttsresult.md) | 译文的语音合成数据，如果没有，可不传。 |
| raw | any | 如果插件内部调用了某翻译接口，可将接口原始数据传回，方便定位问题，可不传。 |

从上面表格可以看出，一个有效的翻译结果对象，只需要 `toParagraphs` 属性有值就可以了，其他属性最好有，没有也不影响。

## to dict object

该对象用于描述词典结果，相对比较复杂。

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| phonetics | array | 音标数据数组，一般英文查词会有，见 [phonetic object](#phonetic-object)。 |
| parts | array | 词性词义数组，一般英文查词会有，见 [part object](#part-object)。 |
| exchanges | array | 其他形式数组，一般英文查词会有，见 [exchange object](#exchange-object)。 |
| relatedWordParts | array | 相关的单词数组，一般中文查词会有，表示和该中文对应的英文单词有哪些，见 [related word part object](#related-word-part-object)。 |
| addtions | array | 附加内容数组，考虑到以上字段无法覆盖所有词典内容，比如例句、记忆技巧等，可将相应数据添加到该数组，最终也会显示到翻译结果中，见 [addtion object](#addtion-object)。 |

## phonetic object

该对象用于描述音标。

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| type | string | 音标类型，值可以是 `us` 或 `uk`，分别对应美式音标和英式音标。|
| value | string | 音标字符串。例如 `ɡʊd`。 |
| tts |  [tts result](plugin/object/ttsresult.md) | 音标发音数据。 |

其中 `type` 为必须包含的字段，`value` 或 `tts` 至少包含一个。

## part object

该对象用于描述某单词的词性和词义。

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| part | string | 单词词性，例如 `n.`、`vi.`... |
| means | array | 词义 `string` 数组。 |

## exchange object

该对象用于描述某单词的其他形式。

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| name | string | 形式的名字，例如 `比较级`、`最高级`... |
| words | array | 该形式对于的单词 `string` 数组，一般只有一个 |

## related word part object

该对象用于描述一组与所查询的文本相关的单词，分组的标准为词性。

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| part | string | 词性。 |
| words | array | 相关的单词数组，见 [related word object](#related-word-part-object)。 |

如果无法获取，`part` 可以不传，但 `words` 中至少要有一个元素。

## related word object

该对象用于描述一个单词。

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| word | string | 单词本身。 |
| means | array | 词义 `string` 数组。 |

`word` 必须有值，`means` 可以不传。

## addtion object

该对象用于描述一段附加内容。

| 属性 | 类型 | 说明 |
| --- | --- | --- |
| name | string | 附加内容名称。 |
| value | string | 附加内容。 |

## 示例

内容较长，请点击展开：

<details>
<summary>翻译「good」的示例</summary>

[example-translate-word-en.json](./_media/example-translate-word-en.json ':include :type=code')

</details>

<details>
<summary>翻译「愤怒」的示例</summary>

[example-translate-word-zh.json](./_media/example-translate-word-zh.json ':include :type=code')

</details>

<details>
<summary>翻译句子的示例</summary>

[example-translate-sentence.json](./_media/example-translate-sentence.json ':include :type=code')

</details>
