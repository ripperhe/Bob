# 截图问题如何解决？

部分用户在截图的时候会出现各种各样的问题，比如

* Bob 截图时出现白屏、黑屏或灰屏
* Bob 反复提示需要开启屏幕录制权限，关闭权限后重新授权也无效
* 「系统偏好设置-安全性与隐私-隐私-屏幕录制」 授权列表中无法添加上 Bob

如果遇到这一问题，可以按照以下步骤重置 Bob 的屏幕录制权限：

## 1. 打开终端 App

在启动台搜索终端，将其打开

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2021/0825/Xnip2021-08-25_16-39-22.png" alt="Terminal" width=800 />

## 2. 输入命令

输入命令，并单击键盘 Enter 键执行

```bash
tccutil reset ScreenCapture com.ripperhe.Bob
```

如果输出以下结果，代表重置成功

``` bash
➜ tccutil reset ScreenCapture com.ripperhe.Bob

Successfully reset ScreenCapture approval status for com.ripperhe.Bob
```

## 3. 重启电脑

重置完成后，**先重启电脑**，然后再尝试使用 Bob 的截图相关功能，并重新赋予 Bob 「屏幕录制」权限（赋予权限后需再次重启 Bob 才能生效）。

## 仍未解决？

如果正确执行上述方案后仍不能正常截图，请联系我吧。





