!> 注意：本文信息可能会过时，仅供参考，请以服务商最新官方文档为准。本文发布日期：2020 年 5 月 2 日。

?> 官方文档：https://open.youtu.qq.com/#/open/developer/join

## 0. 收费模式

| 服务 | 免费额度 | 超出免费额度 | 并发请求数 | 查看详情 |
| :-- | :-- | :-- | :-- | :-- |
| 通用印刷体文字识别 | 每天1000次 👍 | 禁止使用 | 10次/秒 | [点此跳转](https://open.youtu.qq.com/#/open/developer/general) |
| 通用印刷体文字识别（高精度） | 每天500次 👍 | 禁止使用 | 1次/秒 | [点此跳转](https://open.youtu.qq.com/#/open/developer/general_hp) |
| 通用印刷体文字识别（高性能） | 每天50000次 👍 | 禁止使用 | 10次/秒 | [点此跳转](https://open.youtu.qq.com/#/open/developer/general_fast) |

## 1. 注册登录

[点击此处跳转网页](https://open.youtu.qq.com/#/open)

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0502/tencentyoutu_ocr_login.png" alt="tencentyoutu_ocr_login" width=1000 />

## 2. 申请公有云服务

进入 [「业务申请-公用云服务」](https://open.youtu.qq.com/#/open/application/all)，点击「申请公有云服务」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0502/tencentyoutu_ocr_apply_1.png" alt="tencentyoutu_ocr_apply_1" width=1000 />

内容按照下图填写即可，然后点击「提交申请」

```
应用名称：Bob
应用简介：Mac 端翻译软件，识别文字后进行翻译
应用地址：https://github.com/ripperhe/Bob
```

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0502/tencentyoutu_ocr_apply_2.png" alt="tencentyoutu_ocr_apply_2" width=1000 />

!> 审核时间大概需要两天

## 3. 获取秘钥

审核通过之后，进入 [「业务申请-公有云服务」](https://open.youtu.qq.com/#/open/application/all) 即可查看秘钥，如下图所示

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0502/tencentyoutu_ocr_secret.png" alt="tencentyoutu_ocr_secret" width=1000 />

## 4. 填写秘钥

在 Bob 的 偏好设置 > 服务 中，选中「文本识别」，点击 `+` 号，选中「腾讯优图通用OCR」，然后将刚才获取到的秘钥填写到对应位置即可。

详细使用方法可查看 [服务](general/quickstart/service) 页面。
