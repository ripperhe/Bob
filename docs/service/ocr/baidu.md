!> 免责声明：以下信息仅供参考，请以服务商官网最新信息为准。更新时间：2021年4月27日。

## 0. 收费模式

[查看详情](https://cloud.baidu.com/doc/OCR/s/9k3h7xuv6)

| 服务 | 免费额度 | 超出免费额度 | 并发请求数 |
| :-- | :-- | :-- | :-- |
| 通用文字识别（免费使用状态） | 每月1000次（认证后） 👍 | 直接禁止使用，不会扣费 | 2次/秒 |
| 通用文字识别（高精度版）（免费使用状态） | 每月1000次（认证后） 👍  | 直接禁止使用，不会扣费 | 2次/秒 |
| 通用文字识别（按量付费状态） | 每月1000次（认证后） 👍 | 0.0050元/次 | 10次/秒 |
| 通用文字识别（高精度版）（按量付费状态） | 每月1000次（认证后） 👍  | 0.030元/次 | 10次/秒 |

!> 2021年4月24日更新：如需使用**请尽快注册并实名认证**，百度官方在2021年5月24日开始将调低免费额度，具体看[这篇文章](blog/2021-04-26-baidu-ocr-news)

!> 2021年5月26日更新：如果您现在才准备注册百度，**上面显示的就是注册完并且身份认证之后的额度**

## 1. 注册登录

[点击此处跳转网页](https://cloud.baidu.com/)

![baidu_ocr_login](https://gitee.com/ripperhe/oss/raw/master/2020/0502/baidu_ocr_login.png)

## 2. 实名认证

如果你看到这篇文章是在2021年5月24日之前，建议您进行实名认证，这样可以获取巨多的免费额度。（2021年5月24日之后实名认证了相对也会有更多免费额度，但差别没那么大）

[点击此处跳转网页](https://console.bce.baidu.com/qualify/#/qualify/index)

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2021/0426/baidu_ocr_auth.png" alt="baidu_ocr_auth.png" width=1000 />

## 3. 创建新应用

登录成功后，点击左边「产品服务」

![baidu_ocr_app_1](https://gitee.com/ripperhe/oss/raw/master/2020/0502/baidu_ocr_app_1.png)

在展开的页面进入「全部产品」，搜索框中输入「文字识别」，点击搜索结果中的「文字识别」

![baidu_ocr_app_2](https://gitee.com/ripperhe/oss/raw/master/2020/0502/baidu_ocr_app_2.png)

进入「文字识别」页面后，点击「创建应用」

![baidu_ocr_app_3](https://gitee.com/ripperhe/oss/raw/master/2020/0502/baidu_ocr_app_3.png)

按照下图所示填写信息，点击立即创建

![baidu_ocr_app_4](https://gitee.com/ripperhe/oss/raw/master/2020/0502/baidu_ocr_app_4.png)

## 4. 获取秘钥

进入「文字识别」页面，进入「概览」，点击「管理应用」

![baidu_ocr_secret_1](https://gitee.com/ripperhe/oss/raw/master/2020/0502/baidu_ocr_secret_1.png)

下图所示即为需要的秘钥

![baidu_ocr_secret_2](https://gitee.com/ripperhe/oss/raw/master/2020/0502/baidu_ocr_secret_2.png)

## 5. 填写秘钥

在 Bob 的 偏好设置 > 服务 中，选中「文本识别」，点击 `+` 号，选中「百度智能云通用OCR」，然后将刚才获取到的秘钥填写到对应位置即可。

详细使用方法可查看 [服务](general/quickstart/service) 页面。