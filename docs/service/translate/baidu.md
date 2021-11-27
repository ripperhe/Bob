!> 注意：本文信息可能会过时，仅供参考，请以服务商最新官方文档为准。本文发布日期：2020 年 4 月 27 日。

?> 官方文档：https://fanyi-api.baidu.com/product/11

## 0. 收费模式

[查看详情](http://fanyi-api.baidu.com/product/112)

| 服务 | 免费额度 | 超出免费额度 | 并发请求数 |
| :-- | :-- | :-- | :-- |
| 通用翻译API（标准版） | 完全免费，无限使用 👍 | | 1次/秒 |
| 通用翻译API（高级版） | 每月200万字符 | 49元/100万字符 | 10次/秒 |
| 通用翻译API（尊享版） | 每月200万字符 | 49元/100万字符 | 100次/秒 |

## 1. 注册登录

[点击此处跳转网页](http://fanyi-api.baidu.com/api/trans/product/prodinfo)

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0427/baidu_translate_login.png" alt="baidu_translate_login" width=1000 />


## 2. 注册开发者

登录完成之后，点击 [该网页](http://fanyi-api.baidu.com/api/trans/product/prodinfo) 下方的「立即使用」按钮，然后点击「开始注册」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0427/baidu_translate_developer_1.png" alt="baidu_translate_developer_1" width=1000 />

接下来填写个人信息，**请如实填写**，完成之后点击「下一步」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0427/baidu_translate_developer_2.png" alt="baidu_translate_developer_2" width=1000 />

如果你准备使用标准版，直接点击「暂不认证」即可；如果想使用高级版，需填写真实的姓名以及身份证号进行认证

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0427/baidu_translate_developer_3.png" alt="baidu_translate_developer_3" width=1000 />


看到这个提示就代表注册开发者成功了，这个时候直接点击「开通服务」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0427/baidu_translate_developer_4.png" alt="baidu_translate_developer_4" width=1000 />


## 3. 开通通用翻译API

注册完成开发者之后，点击「开通服务」即可进入开通服务页面，如果刚才忘了点击，可以 [点击此处跳转开通服务页面](http://fanyi-api.baidu.com/api/trans/product/apichoose)

选中「通用翻译API」，然后点击「下一步」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0427/baidu_translate_open_1.png" alt="baidu_translate_open_1" width=1000 />


点击「开通标准版」（如果你想使用「高级版」，也可以点击「开通高级版」，不过你需要填写身份证进行认证）

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0427/baidu_translate_open_2.png" alt="baidu_translate_open_2" width=1000 />


填写应用名称，可以随意填写，其他的不用填。然后勾选「我已知晓翻译API计费规则」，点击「我已了解，确认开通」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0427/baidu_translate_open_3.png" alt="baidu_translate_open_3" width=1000 />


当你看到如下提示则代表开通成功了

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0427/baidu_translate_open_4.png" alt="baidu_translate_open_4" width=1000 />


## 4. 获取秘钥

!> 请妥善保管自己的秘钥，秘钥泄露可能会给你带来损失！

[点击此处跳转查询秘钥的页面](http://fanyi-api.baidu.com/api/trans/product/desktop?req=developer)

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0427/baidu_translate_secret.png" alt="baidu_translate_secret" width=1000 />

## 5. 填写秘钥

在 Bob 的 偏好设置 > 服务 中，选中「文本翻译」，点击 `+` 号，选中「百度翻译」，然后将刚才获取到的秘钥填写到对应位置即可。

详细使用方法可查看 [服务](general/quickstart/service) 页面。