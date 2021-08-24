!> 注意：本文信息可能会过时，仅供参考，请以服务商最新官方文档为准。本文发布日期：2020 年 12 月 27 日。

?> 官方文档：https://cloud.google.com/text-to-speech/docs/before-you-begin?hl=zh_CN

## 0. 收费模式

[查看详情](https://cloud.google.com/text-to-speech/pricing?hl=zh_CN)

| 服务 | 免费额度 | 超出免费额度 | 并发请求数 |
| :-- | :-- | :-- | :-- |
| 标准（非 WaveNet）语音 | 每月400万字符 👍 | 4美元/100万字符 | 无相关说明 |
| WaveNet 语音 | 每月100万字符 👍 | 16美元/100万字符 | 无相关说明 |

> 注意：声音名称中带 `WaveNet` 即为 WaveNet 语音

## 1. 申请条件

!> 注意，在国内使用 Google 语音合成 API 需要使用 VPN，如果不能接受这一点，不需要再往下看了。

?> Google 语音合成 API 地址为 `https://texttospeech.googleapis.com/v1/text:synthesize`

Google 语音合成 API 秘钥申请和 Google 翻译的秘钥申请类似，以下很多步骤是直接从 Goole 翻译申请文档拷贝过来的，有些步骤可根据实际情况跳过。

假设你是在国内，在申请 Google 语音合成 API 之前，需要准备好以下道具：

1. 用于访问 Google 的 VPN
2. 用于海外支付的 Visa 卡（不清楚其他卡是否可行）

VPN 的问题请自行解决，不在本文讨论的范畴。

我使用的 Visa 卡是「招商银行 Visa 全币卡」，卡面是下图中框住的那一张，可自行到招商银行官网申请。

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0831/google_translate_visa.png" alt="google_translate_visa.png" width="1000" />

## 2. 注册登录

[点击此处跳转网页](https://accounts.google.com/signin/v2/identifier?flowName=GlifWebSignIn&flowEntry=ServiceLogin)

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0831/google_translate_login.png" alt="google_translate_login.png" width=1000 />

## 3. 设置语言

如果想要将语言设置为中文，可以进入 [这个链接](https://console.cloud.google.com/user-preferences/languages) 修改。

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0831/google_translate_language.png" alt="google_translate_language.png" width=1000 />

## 4. 创建结算账号

?> 如果已经创建过结算账户，可跳过该步骤

!> 启用服务需要有结算账号，我拿到信用卡第一天绑定报错，隔了一天又试，结果又成功了。我不能确定我做的每一步都是必要的，甚至不能保证完全按照我的操作能绑定成功，我只是尽可能详细地描述一下我当时是怎么做的。只要这一步成功了，后面的应该就都没问题了。

因为我后面地址填的是「香港」，所以我 VPN 使用的是一个香港的节点。

进入 [结算账户管理页面](https://console.cloud.google.com/billing)，点击「添加结算账号」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0831/google_translate_pay1.png" alt="google_translate_pay1" width=1000 />

地区我选的「香港」（你也可以试试美国），然后勾选上同意服务条款，点击「继续」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0831/google_translate_pay2.png" alt="google_translate_pay2" width=1000 />

账号类型选「个人」，地址我随便填的一个香港地址，名字我填的真实的

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0831/google_translate_pay3.png" alt="google_translate_pay3" width=1000 />

付款方式填前面申请的 Visa 卡，持卡人姓名我填的真实的，账单邮寄地址我勾选的与上述地址相同，点击「开始免费试用」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0831/google_translate_pay4.png" alt="google_translate_pay4" width=1000 />

如果成功，应该会出现如下提示；否则应该会在上个页面报错

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0831/google_translate_pay5.png" alt="google_translate_pay5" width=1000 />

!> 注意：Google 会尝试扣 1 美元用以验证信用卡是否可用，之后会退回来。

## 5. 创建项目

?> 如果已经创建过项目，可跳过该步骤

进入 [项目管理](https://console.cloud.google.com/cloud-resource-manager) 点击「创建项目」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0831/google_translate_project1.png" alt="google_translate_project1" width=1000 />

名称随意填写，然后点击「创建」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0831/google_translate_project2.png" alt="google_translate_project2" width=1000 />

## 6. 启用 Cloud Text-to-Speech API

进入 [Cloud Text-to-Speech API](https://console.cloud.google.com/apis/library/texttospeech.googleapis.com)，选中刚才创建的项目，点击「打开」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/1227/google_tts_api1.png" alt="google_translate_api1" width=1000 />

点击「启用」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/1227/google_tts_api2.png" alt="google_translate_api2" width=1000 />

?> 注意，如果你选中项目还没启用结算功能，则会有下面提示；如果没有提示，直接跳过这一步

点击「启用结算功能」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0831/google_translate_api3.png" alt="google_translate_api3" width=1000 />

选中刚开始创建的结算账号，点击「设置账号」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0831/google_translate_api4.png" alt="google_translate_api4" width=1000 />

## 7. 获取秘钥（凭据）

进入 [首页](https://console.cloud.google.com/home/dashboard)，选中刚才创建的项目，点击左上角，点击「API和服务」，再选中「凭据」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0831/google_translate_secret1.png" alt="google_translate_secret1" width=1000 />

点击「创建凭据」，点击「API秘钥」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0831/google_translate_secret2.png" alt="google_translate_secret2" width=1000 />

如下图所示即为需要的秘钥

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/1227/google_tts_secret3.png" alt="google_translate_secret3" width=1000 />

如果想要安全一些，可以点击上图中的「限制秘钥」，指定该秘钥仅可访问「Cloud Text-to-Speech API」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/1227/google_tts_secret4.png" alt="google_translate_secret4" width=1000 />

## 8. 填写秘钥

在 Bob 的 偏好设置 > 服务 中，选中「语音合成」，点击 `+` 号，选中「Google 语音合成」，然后将刚才获取到的秘钥填写到对应位置即可。

详细使用方法可查看 [服务](general/quickstart/service) 页面。


