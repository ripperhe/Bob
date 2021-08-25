# 取词问题如何解决？

部分用户在使用划词翻译时，即便在「系统偏好设置-安全性与隐私-隐私-辅助功能」授权列表里面已经开启了，Bob 仍旧提示需要开启辅助功能权限。

此时可以尝试重置整个电脑的辅助功能权限，不过重置后所有需要辅助功能权限的 App 都需要重新授权。

接下来讲下重置步骤。

## 打开终端 App

在启动台搜索终端，将其打开

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2021/0825/Xnip2021-08-25_16-39-22.png" alt="Terminal" width=800 />

## 输入命令

输入命令，单击 Enter 键

```bash
tccutil reset Accessibility
```

如果输出以下结果，代表重置成功

``` bash
➜ tccutil reset Accessibility

Successfully reset Accessibility
```

## 重启电脑

重置完成后，**先重启电脑**，然后再尝试使用 Bob 的取词相关功能。







