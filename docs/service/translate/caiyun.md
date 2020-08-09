!> 免责声明：以下信息仅供参考，请以服务商官网最新信息为准。更新时间：2020年5月1日。

## 0. 收费模式

?> 彩云官方提供了一个测试 Token `3975l6lr5pcbvidl6jl2 `，不保证可用性

[查看详情](https://open.caiyunapp.com/%E4%BA%94%E5%88%86%E9%92%9F%E5%AD%A6%E4%BC%9A%E5%BD%A9%E4%BA%91%E5%B0%8F%E8%AF%91_API)

| 服务 | 免费额度 | 超出免费额度 | 并发请求数 |
| :-- | :-- | :-- | :-- |
| 彩云小译API | 每月100万字符 👍 | 20元/100万字符 | 无相关说明 |

## 1. 注册登录

[点击此处跳转网页](https://dashboard.caiyunapp.com/user/sign_in/)

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0501/caiyun_translate_login.png" alt="caiyun_translate_login" width=1000 />

## 2. 申请令牌

进入 [「我的账户-开发者信息」](https://dashboard.caiyunapp.com/user/user/info/)

账户类型选默认的「个人姓名/非盈利组织」，个人姓名和联系名均填自己名字，电话填真实的就好，然后点击「下一步」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0501/caiyun_translate_apply_1.png" alt="caiyun_translate_apply_1" width=1000 />

如下图所示，选中「彩云小译API」，依次填入以下信息，然后点击「提交」

```
应用名：Bob
应用连接：https://github.com/ripperhe/Bob
应用开发情况：Mac端软件，可直接使用
```

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0501/caiyun_translate_apply_2.png" alt="caiyun_translate_apply_2" width=1000 />

看到以下提示就算申请完成了，审核大概需要1-2天

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0501/caiyun_translate_apply_3.png" alt="caiyun_translate_apply_3" width=1000 />

## 3. 获取秘钥

审核通过之后，进入 [「我的令牌-令牌列表」](https://dashboard.caiyunapp.com/v1/token/)，点击「令牌」下方的字符串

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0501/caiyun_translate_secret_1.png" alt="caiyun_translate_secret_1" width=1000 />

如下图所示即为需要的秘钥

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0501/caiyun_translate_secret_2.png" alt="caiyun_translate_secret_2" width=1000 />

## 4. 填写秘钥

在 Bob 的 偏好设置 > 服务 中，选中「文本翻译」，点击 `+` 号，选中「彩云小译」，然后将刚才获取到的秘钥填写到对应位置即可。

详细使用方法可查看 [服务](general/quickstart/service) 页面。

