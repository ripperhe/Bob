!> 注意：本文信息可能会过时，仅供参考，请以服务商最新官方文档为准。本文发布日期：2020 年 5 月 2 日。

?> 官方文档：https://ai.youdao.com/doc.s#guide

## 0. 收费模式

?> 新用户注册，赠送50元体验资金

[查看详情](https://ai.youdao.com/DOCSIRMA/html/%E6%96%87%E5%AD%97%E8%AF%86%E5%88%ABOCR/%E4%BA%A7%E5%93%81%E5%AE%9A%E4%BB%B7/%E9%80%9A%E7%94%A8OCR%E6%9C%8D%E5%8A%A1/%E9%80%9A%E7%94%A8OCR%E6%9C%8D%E5%8A%A1-%E4%BA%A7%E5%93%81%E5%AE%9A%E4%BB%B7.html)

| 服务 | 免费额度 | 超出免费额度 | 并发请求数 |
| :-- | :-- | :-- | :-- |
| 通用文本识别 | 无 | 0.01元/次 | 无相关说明 |

## 1. 注册登录

[点击此处跳转网页](https://ai.youdao.com/)

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0502/youdao_ocr_login.png" alt="youdao_ocr_login" width=1000 />

> 注册完成后，按照页面提示添加有道客服微信并发送账号信息，可再获得50元体验金。

## 2.创建应用

登录完成后，进入 [「业务指南-应用总览」](https://ai.youdao.com/console/#/app-overview)，点击「创建应用」

<img src="https://cdn.jsdelivr.net/gh/wakewon/oss@main/image/bob/202205032017733.webp" alt="youdao_translate_app_1" width=1000 />

应用名称随意填写，服务需勾选「通用文字识别」，接入方式选「API」，应用类别可随意选择，其他信息不用填，然后点击「确定」

<img src="https://cdn.jsdelivr.net/gh/wakewon/oss@main/image/bob/202205032209379.webp" alt="youdao_ocr_app_2" width=1000 />

!> 请不要填写「服务器 IP」这一项设定，填写后很可能会导致你无法正常访问服务。

## 3. 获取秘钥

!> 请妥善保管自己的秘钥，秘钥泄露可能会给你带来损失！

进入 [「业务指南-业务总览」](https://ai.youdao.com/console/#/)，在「我的应用」中找到开通了「通用文字识别」服务的应用，点击「应用 ID」和「应用密钥」旁的复制按钮可分别复制所需的应用 ID 和应用密钥

<img src="https://cdn.jsdelivr.net/gh/wakewon/oss@main/image/bob/202205032216257.webp" alt="youdao_ocr_secret_1" width=1000 />

## 4. 填写秘钥

在 Bob 的 偏好设置 > 翻译 > 服务 中，选中「文本识别」，点击 `+` 号，选中「有道智云通用OCR」，然后将刚才获取到的应用 ID 和应用密钥填写到对应位置即可。

详细使用方法可查看 [服务](general/quickstart/service) 页面。