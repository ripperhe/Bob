# 取词问题如何解决？

部分用户在使用划词翻译时，即便在「系统偏好设置-安全性与隐私-隐私-辅助功能」授权列表里面已经开启了，Bob 仍旧提示需要开启辅助功能权限。

如果遇到这一问题，可以按照以下步骤重置 Bob 的辅助功能权限：

## 打开终端 App

在启动台搜索终端，将其打开

<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2021/0825/Xnip2021-08-25_16-39-22.png" alt="Terminal" width=800 />

## 输入命令

输入命令，并单击键盘 Enter 键执行

```bash
tccutil reset Accessibility com.ripperhe.Bob
```

如果输出以下结果，代表重置成功

``` bash
➜ tccutil reset Accessibility com.ripperhe.Bob

Successfully reset Accessibility approval status for com.ripperhe.Bob
```

## 重启电脑

重置完成后，**先重启电脑**，然后再尝试使用 Bob 的取词相关功能，并重新赋予 Bob 「辅助功能」权限。

## 仍未解决？

如果正确执行上述方案后仍不能正常划词翻译，请联系我吧。






