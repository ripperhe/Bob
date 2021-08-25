# 截图问题如何解决？

部分用户在截图的时候会出现各种各样的问题，比如

* Bob 截图时出现白屏、黑屏或灰屏
* Bob 反复提示需要开启屏幕录制权限，关闭权限后重新授权也无效
* 「系统偏好设置-安全性与隐私-隐私-屏幕录制」 授权列表中无法添加上 Bob

目前有个比较有效的方法就是直接重置整个电脑的屏幕录制权限，重置之后，以上的问题应该都能解决掉。不过带来的副作用就是所有需要屏幕录制权限的 App 都需要重新授权，我个人感觉影响不大。

接下来讲下重置步骤。

## 打开终端 App

在启动台搜索终端，将其打开

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2021/0825/Xnip2021-08-25_16-39-22.png" alt="Terminal" width=800 />

## 输入命令

输入命令，单击 Enter 键

```bash
tccutil reset ScreenCapture
```

如果输出以下结果，代表重置成功

``` bash
➜ tccutil reset ScreenCapture

Successfully reset ScreenCapture
```

## 重启电脑

重置完成后，**先重启电脑**，然后再尝试使用 Bob 的截图相关功能。







