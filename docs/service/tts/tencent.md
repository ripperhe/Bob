!> 注意：本文信息可能会过时，仅供参考，请以服务商最新官方文档为准。本文发布日期：2020 年 12 月 28 日。

?> 官方文档：https://cloud.tencent.com/product/tts/getting-started

## 0. 收费模式

[查看详情](https://cloud.tencent.com/product/tts/pricing)

| 服务 | 免费额度 | 超出免费额度 | 并发请求数 |
| :-- | :-- | :-- | :-- |
| 语音合成 – 普通音色 | 新用户可领取800万字符，3月内有效 | 0.2元/万字符 | 20次/秒（免费试用为3次/秒） |
| 语音合成 – 精品音色 | 与普通音色共用800万免费额度 | 0.3元/万字符 | 20次/秒（免费试用为3次/秒） |

> 1个中文、1个字母、1个标点符号都计算为1个字符。

## 1. 注册登录

[点击此处跳转网页](https://cloud.tencent.com/)

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0501/tencent_translate_login.png" alt="tencent_translate_login" width=1000 />

## 2. 个人认证

!> 腾讯云免费服务使用之前需要认证，普通用户申请「个人认证」即可，如果已经认证，请直接跳过此步骤

 进入 [「账号信息-查看或修改认证」](https://console.cloud.tencent.com/developer/auth)，点击「开始个人认证」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0501/tencent_translate_auth_1.png" alt="tencent_translate_auth_1" width=1000 />

以下信息如实填写，然后点击「下一步」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0501/tencent_translate_auth_2.png" alt="tencent_translate_auth_2" width=1000 />

如下提示即代表认证成功

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0501/tencent_translate_auth_3.png" alt="tencent_translate_auth_3" width=1000 />

## 3. 开通语音合成

进入 [「语音合成」](https://console.cloud.tencent.com/tts) 页面，点「免费试用」就行。如果进入语音合成页面能直接看到调用量，可接着看下看。

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0808/tencent_tts_open.png" alt="tencent_tts_open" width="1000" />

前面讲过，新用户可以领取一个免费资源包，内含800万调用字符，有效期为3个月。进入 [「语言合成-资源包管理」](https://console.cloud.tencent.com/tts/resourcebundle) 页面，点击「免费领取资源包」即可

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/1128/tencent_tts_get_free_1.png" alt="tencent_tts_get_free_1" width=1000 />

领取成功如下所示

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/1128/tencent_tts_get_free_2.png" alt="tencent_tts_get_free_2" width=1000 />

如果免费资源包已使用完毕，想继续使用，有预付费和后付费两种方案，[收费模式详情页]((https://cloud.tencent.com/product/tts/pricing)) 说的比较清楚，这里不再赘述了。

## 4. 获取秘钥

!> 请妥善保管自己的秘钥，秘钥泄露可能会给你带来损失！

获取秘钥有两个方法，方法1更快捷，方法2更安全，**任选一个跟着操作就可以了**。

!> 注意，无论使用哪个方式获取秘钥，前面的步骤（个人认证、开通语音合成）都是需要操作的。如果不操作，即便获取到了秘钥也无法正常使用！

### 方法1（更快捷）

如果想更快捷地获取秘钥，可以直接获取「主账号」的秘钥，**该秘钥可以直接访问你账户下的所有腾讯云资源**。

进入 [「访问管理-访问秘钥-API秘钥管理」](https://console.cloud.tencent.com/cam/capi)，点击「新建秘钥」

?> 如果已有秘钥，可直接使用，无需再新建

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0501/tencent_translate_secret_1_1.png" alt="tencent_translate_secret_1_1" width=1000 />

如下图所示即所需的秘钥

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0501/tencent_translate_secret_1_2.png" alt="tencent_translate_secret_1_2" width=1000 />

### 方法2（更安全）

如果想要更安全一些，可以创建一个「子用户」，然后只给这个「子用户」开启访问「语音合成」API的权限

进入 [「访问管理-用户-用户列表」](https://console.cloud.tencent.com/cam)，点击「新建用户」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0501/tencent_translate_user_1.png" alt="tencent_translate_user_1" width=1000 />

点击「自定义创建」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0501/tencent_translate_user_2.png" alt="tencent_translate_user_2" width=1000 />

选择「可访问资源并接受消息」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0501/tencent_translate_user_3.png" alt="tencent_translate_user_3" width=1000 />

用户名随意设置，勾选上「编程访问」，其他的不用勾选，然后点击「下一步」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0501/tencent_translate_user_4.png" alt="tencent_translate_user_4" width=1000 />

在搜索框输入「tts」即可快速找到「语音合成」相关服务，然后勾选上「QcloudTTSFullAccess」，点击「下一步」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0808/tencent_tts_user_5.png" alt="tencent_tts_user_5" width=1000 />

点击「完成」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0808/tencent_tts_user_6.png" alt="tencent_translate_user_6" width=1000 />

如下图所示即为所需秘钥

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0501/tencent_translate_user_7.png" alt="tencent_translate_user_7" width=1000 />

如果已经创建完「子用户」，想重新查看秘钥，则进入 [「访问管理-用户-用户列表」](https://console.cloud.tencent.com/cam)，展开对应子用户，然后点击「查看用户详情」

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0501/tencent_translate_secret_2_1.png" alt="tencent_translate_secret_2_1" width=1000 />

点击「API 秘钥」，下图所示即可所需秘钥

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0501/tencent_translate_secret_2_2.png" alt="tencent_translate_secret_2_2" width=1000 />

## 5. 填写秘钥

在 Bob 的 偏好设置 > 服务 中，选中「语音合成」，点击 `+` 号，选中「腾讯云语音合成」，然后将刚才获取到的秘钥填写到对应位置即可。

详细使用方法可查看 [服务](general/quickstart/service) 页面。