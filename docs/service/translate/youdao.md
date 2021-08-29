!> 注意：本文信息可能会过时，仅供参考，请以服务商最新官方文档为准。本文发布日期：2020 年 5 月 1 日。

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

## 2. 创建应用

登录完成后，进入 [「应用管理-我的应用」](https://ai.youdao.com/appmgr.s)，点击「创建应用」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0824/youdao_translate_app_1.png" alt="youdao_translate_app_1" width=1000 />

应用名称随意填写，类别不用选，描述不用填，接入方式选「API」，然后点击「下一步」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0824/youdao_translate_app_2.png" alt="youdao_translate_app_2" width=1000 />

然后点击「创建应用」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0824/youdao_translate_app_3.png" alt="youdao_translate_app_3" width=1000 />

## 3. 创建文本翻译实例

应用创建完成，进入 [「自然语言翻译-翻译实例」](https://ai.youdao.com/fanyi-services.s) 创建实例

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0824/youdao_translate_service_1.png" alt="youdao_translate_service_1" width=1000 />

实例名称随意填写，类型选「文本翻译」，然后点击「下一步」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0824/youdao_translate_service_2.png" alt="youdao_translate_service_2" width=1000 />

点击「创建实例」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0824/youdao_translate_service_3.png" alt="youdao_translate_service_3" width=1000 />

## 4. 创建语音合成实例

!> 在查单词时，有道翻译结果中往往会有单词发音，需要创建语音合成实例并绑定到应用才能正常播放。

进入 [「语音合成TTS-TTS实例」](https://ai.youdao.com/tts-services.s) 创建实例

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0824/youdao_translate_service_tts_1.png" alt="youdao_translate_service_tts_1" width=1000 />

实例名称随意填写，然后点击「下一步」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0824/youdao_translate_service_tts_2.png" alt="youdao_translate_service_tts_2" width="1000" />

点击「创建实例」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0824/youdao_translate_service_tts_3.png" alt="youdao_translate_service_tts_3" width="1000" />

## 5. 将实例和应用绑定

进入 [「应用管理-我的应用」](https://ai.youdao.com/appmgr.s)，点击刚才创建的应用右边的「绑定服务」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0824/youdao_translate_bind_1.png" alt="youdao_translate_bind_1" width="1000" />

勾选上刚才创建的**翻译实例**和**语音合成实例**，点击「提交更改」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0824/youdao_translate_bind_2.png" alt="youdao_translate_bind_2" width="1000" />

## 6. 获取秘钥

!> 请妥善保管自己的秘钥，秘钥泄露可能会给您带来损失！

进入 [「应用管理-我的应用」](https://ai.youdao.com/appmgr.s)，点击第2步创建的应用

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0824/youdao_translate_secret_1.png" alt="youdao_translate_secret_1" width=1000 />

下图所示即为所需的秘钥

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0824/youdao_translate_secret_2.png" alt="youdao_translate_secret_2" width=1000 />

## 7. 填写秘钥

在 Bob 的 偏好设置 > 服务 中，选中「文本翻译」，点击 `+` 号，选中「有道翻译」，然后将刚才获取到的秘钥填写到对应位置即可。

详细使用方法可查看 [服务](general/quickstart/service) 页面。