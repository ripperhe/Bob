!> 注意：本文信息可能会过时，仅供参考，请以服务商最新官方文档为准。本文发布日期：2022 年 5 月 3 日。

?> 官方文档：https://ai.youdao.com/doc.s#guide

## 0. 收费模式

?> 新用户注册，赠送50元体验资金

[查看详情](https://ai.youdao.com/DOCSIRMA/html/%E8%87%AA%E7%84%B6%E8%AF%AD%E8%A8%80%E7%BF%BB%E8%AF%91/%E4%BA%A7%E5%93%81%E5%AE%9A%E4%BB%B7/%E6%96%87%E6%9C%AC%E7%BF%BB%E8%AF%91%E6%9C%8D%E5%8A%A1/%E6%96%87%E6%9C%AC%E7%BF%BB%E8%AF%91%E6%9C%8D%E5%8A%A1-%E4%BA%A7%E5%93%81%E5%AE%9A%E4%BB%B7.html)

| 服务 | 免费额度 | 超出免费额度 | 并发请求数 |
| :-- | :-- | :-- | :-- |
| 中文与语种一互译 | 无 | 48元/100万字符 | 无相关说明 |
| 中文与语种二互译 | 无 | 100元/100万字符 | 无相关说明 |
| 其他语种间互译 | 无 | 100元/100万字符 | 无相关说明 |

## 1. 注册登录

[点击此处跳转网页](https://ai.youdao.com/)

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0428/youdao_translate_login.png" alt="youdao_translate_login" width=1000 />

> 注册完成后，按照页面提示添加有道客服微信并发送账号信息，可再获得50元体验金。

## 2. 创建应用

登录完成后，进入 [「业务指南-应用总览」](https://ai.youdao.com/console/#/app-overview)，点击「创建应用」

<img src="https://cdn.jsdelivr.net/gh/wakewon/oss@main/image/bob/202205032017733.webp" alt="youdao_translate_app_1" width=1000 />

应用名称随意填写，服务需勾选「文本翻译」，并按需勾选「语音合成」，接入方式选「API」，应用类别可随意选择，其他信息不用填，然后点击「确定」

> 在翻译单词时，有道翻译可以为单词提供额外的美音和英音发音。如希望使用有道提供的发音功能，此处需同时勾选「语音合成」。语音合成是收费服务，会单独按发音使用量计费，详见 [「智能语音合成服务-产品定价」](https://ai.youdao.com/DOCSIRMA/html/%E8%AF%AD%E9%9F%B3%E5%90%88%E6%88%90TTS/%E4%BA%A7%E5%93%81%E5%AE%9A%E4%BB%B7/%E8%AF%AD%E9%9F%B3%E5%90%88%E6%88%90%E6%9C%8D%E5%8A%A1/%E8%AF%AD%E9%9F%B3%E5%90%88%E6%88%90%E6%9C%8D%E5%8A%A1-%E4%BA%A7%E5%93%81%E5%AE%9A%E4%BB%B7.html)

<img src="https://cdn.jsdelivr.net/gh/wakewon/oss@main/image/bob/202205032020904.webp" alt="youdao_translate_app_2" width=1000 />

!> 请不要填写「服务器 IP」这一项设定，填写后很可能会导致你无法正常访问服务。

## 3. 获取秘钥

!> 请妥善保管自己的秘钥，秘钥泄露可能会给你带来损失！

进入 [「自然语言翻译服务-文本翻译」](https://ai.youdao.com/console/#/service-singleton/text-translation)，在「已开通本服务的应用」中找到第2步创建的应用，点击「应用 ID」和「应用密钥」旁的复制按钮可分别复制所需的应用 ID 和应用密钥

<img src="https://cdn.jsdelivr.net/gh/wakewon/oss@main/image/bob/202205032044439.webp" alt="youdao_translate_secret_1" width=1000 />

> 如果你在查词中，希望使用有道翻译结果中的发音按钮进行发音，请务必确保这里的服务卡片中同时写着「文本翻译 / 语音合成」两项服务。否则，请修改这一服务，并补充勾选「语音合成」项，或按照第2步重新创建一个同时勾选了「文本翻译」和「语音合成」两项服务的应用。

## 4. 填写秘钥

在 Bob 的 偏好设置 > 翻译 > 服务 中，选中「文本翻译」，点击 `+` 号，选中「有道翻译」，然后将刚才获取到的应用 ID 和应用密钥填写到对应位置即可。

详细使用方法可查看 [服务](general/quickstart/service) 页面。