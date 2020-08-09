!> 免责声明：以下信息仅供参考，请以服务商官网最新信息为准。更新时间：2020年5月2日。

## 0. 收费模式

?> 新用户注册，赠送50元体验资金

[查看详情](https://ai.youdao.com/DOCSIRMA/html/%E6%96%87%E5%AD%97%E8%AF%86%E5%88%ABOCR/%E4%BA%A7%E5%93%81%E5%AE%9A%E4%BB%B7/%E9%80%9A%E7%94%A8OCR%E6%9C%8D%E5%8A%A1/%E9%80%9A%E7%94%A8OCR%E6%9C%8D%E5%8A%A1-%E4%BA%A7%E5%93%81%E5%AE%9A%E4%BB%B7.html)

| 服务 | 免费额度 | 超出免费额度 | 并发请求数 |
| :-- | :-- | :-- | :-- |
| 通用文本识别 | 无 | 0.01元/次 | 无相关说明 |

## 1. 注册登录

[点击此处跳转网页](https://ai.youdao.com/)

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0502/youdao_ocr_login.png" alt="youdao_ocr_login" width=1000 />

## 2.创建应用

登录完成后，进入 [「应用管理-我的应用」](https://ai.youdao.com/appmgr.s)，点击「创建应用」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0502/youdao_ocr_app_1.png" alt="youdao_ocr_app_1" width=1000 />

应用名称随意填写，类别不用选，描述不用填，接入方式选「API」，然后点击「下一步」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0502/youdao_ocr_app_2.png" alt="youdao_ocr_app_2" width=1000 />

然后点击「创建应用」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0502/youdao_ocr_app_3.png" alt="youdao_ocr_app_3" width=1000 />

## 3. 创建OCR实例

应用创建完成，进入 [「文字识别OCR-OCR实例」](https://ai.youdao.com/ocr-services.s) 创建实例

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0502/youdao_ocr_service_1.png" alt="youdao_ocr_service_1" width=1000 />

实例名称随意填写，类型选「通用文本识别」，然后点击「下一步」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0502/youdao_ocr_service_2.png" alt="youdao_ocr_service_2" width=1000 />

点击「创建实例」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0502/youdao_ocr_service_3.png" alt="youdao_ocr_service_3" width=1000 />

## 4.  将OCR实例和应用绑定

进入 [「文字识别OCR-OCR实例」](https://ai.youdao.com/ocr-services.s) ，点击刚才创建的OCR实例的「绑定应用」按钮

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0502/youdao_ocr_bind_1.png" alt="youdao_ocr_bind_1" width=1000 />

勾选上第2步创建的应用，点击「提交更改」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0502/youdao_ocr_bind_2.png" alt="youdao_ocr_bind_2" width=1000 />

## 5. 获取秘钥

进入 [「应用管理-我的应用」](https://ai.youdao.com/appmgr.s)，点击第2步创建的应用

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0502/youdao_ocr_secret_1.png" alt="youdao_ocr_secret_1" width=1000 />

下图所示即为所需的秘钥

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0502/youdao_ocr_secret_2.png" alt="youdao_ocr_secret_2" width=1000 />

## 6. 填写秘钥

在 Bob 的 偏好设置 > 服务 中，选中「文本识别」，点击 `+` 号，选中「有道智云通用OCR」，然后将刚才获取到的秘钥填写到对应位置即可。

详细使用方法可查看 [服务](general/quickstart/service) 页面。