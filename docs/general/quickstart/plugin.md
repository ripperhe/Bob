尽管目前已经接入了多家的翻译服务，但还是可能会有用户想要其他的服务，根据 [issue#53](https://github.com/ripperhe/Bob/issues/53) 的建议，我们实现了自定义 API 的功能，为了使这个功能足够灵活且可复用，我们采用的是插件的形式。

## 下载插件

Bob 目前所有用户开发的插件基本都托管在 GitHub 上，可以在下面这个链接找到：

<https://github.com/topics/bobplugin>

!> 注意，以 `.bobplugin` 为后缀的才是 Bob 插件，别下载错了。（别问我为啥要在这里加这句话 😄）

## 查看插件源码

Bob 插件文件以 `.bobplugin` 为后缀名，但本质上是一个压缩包。如需查看源码，可以将文件后缀名改为 `.zip`，解压之后即可查看插件源码。

## 安装插件

!> 在安装使用他人开发的插件之前，请自行评估插件是否会损坏你的利益

如果电脑上已安装 Bob 0.5.0 以上版本，鼠标左键双击插件文件（以 `.bobplugin` 为后缀名），即可自动安装。安装成功或异常，会弹窗提示。

安装好插件之后，在 Bob「偏好设置-插件」中可查看已安装的插件。这里以一个「文本翻译」插件为例，如下所示：

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0807/plugin-installed.png" alt="plugin-installed" width="800" />

## 删除插件

如果想要删除插件，在 Bob「偏好设置-插件」中将其选中，然后点击下方的齿轮按钮，点击「删除插件」

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0807/plugin-delete.png" alt="plugin-delete" width="800" />

## 使用插件

使用插件和使用其他普通服务的方法一样，具体如下。

点击「偏好设置-服务」中对应类型的服务列表下方的 `+` 号，弹出的菜单中可以看到安装好的插件，点击对应插件将其添加到服务列表中

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0807/plugin-use-1.png" alt="plugin-use-1" width="800" />

将刚才添加的插件服务勾选上，然后点击右下方 `保存` 按钮

<img src="https://gitee.com/ripperhe/oss/raw/master/2020/0807/plugin-use-2.png" alt="plugin-use-2" width="800" />

## 开发插件

如果想要自行开发插件，请查看 [开发插件](plugin/) 相关文章。







