发布插件可以让他人也能使用你的插件，私人使用请忽略这一步。

## 支持检索

将项目传到 GitHub，然后给这个项目添加一个名为 `bobplugin` 的 `topic`，这样大家就可以通过下面这个链接找到这个项目了。

<https://github.com/topics/bobplugin>

## 支持检查更新

在介绍 [info.json](plugin/quickstart/info.md) 的文章中可以看到描述插件信息里面有个字段是 `appcast`，这个字段是一个 URL，用于请求获取插件的最新版本信息。

这个接口请求应返回 json 格式数据，具体如下：

| 字段 | 类型 | 是否必须 | 说明 |
| --- | --- | :---:| --- |
| identifier | string | ✅ | 插件的唯一标识符，需和插件 info.json 文件中的唯一标识符一致。 |
| versions | array | ✅ | 版本信息数组，请倒序排列，新版本放前面。具体结构看 `version object`。 |

version object 结构如下：

| 字段 | 类型 | 是否必须 | 说明 |
| --- | --- | :---:| --- |
| version | string | ✅ | 版本号，请与对应插件包 info.json 中的信息一致。 |
| desc | string | ✅ | 插件的更新内容。 |
| sha256 | string | ✅ | 插件包 SHA256 哈希值，会和从 url 中下载的插件包进行比对校验。 |
| url | string | ✅ | 插件包下载地址。 |
| minBobVersion | string | - | 最低支持本插件的 Bob 版本，请与对应插件包 info.json 中的信息一致。 |

### SHA256

`sha256` 通过以下方式获取，打开 Mac 终端输入以下命令

```sh
shasum -a 256 <这里换成插件包文件路径>
```

### 文件存放

前面建议的是将插件仓库放到 GitHub，所以这里也以 GitHub 为例。

#### 存放 appcast.json

可将 `appcast.json` 文件放到插件仓库某个位置，假如放到根目录，即可通过以下链接获取 json 文件信息，将以下链接填写到 `info.json` 中的 `appcast` 字段即可。（将用户名和仓库名替换为自己的）

```
https://raw.githubusercontent.com/用户名/插件仓库名/master/appcast.json
```

考虑到 GitHub 经常被墙，在国内请求可能会失败，建议使用 [jsDelivr](https://www.jsdelivr.com/?docs=gh) 加速，将上面的链接替换为如下链接

```
https://cdn.jsdelivr.net/gh/用户名/插件仓库名@master/appcast.json
```

使用 jsDelivr 会有缓存，所以修改 `appcast.json` 文件后，利用以上链接请求回来的数据没办法立即更新。每次修改 `appcast.json` 文件后，在浏览器请求一下如下链接，一般来说可以强制刷新缓存。

```
https://purge.jsdelivr.net/gh/用户名/插件仓库名@master/appcast.json
```

!> 注意不要恶意地频繁刷新，更新文件后刷新一次就好。不强制刷新其实也没啥问题，一般 24 小时内会自动刷新。

#### 存放插件包

一般插件包也不会太大，可能几百 KB，如果直接传到 `GitHub Releases` 将无法使用 jsDelivr（我没找到如何使用），所以还是建议放到仓库的某个位置，然后利用 jsDelivr 加速。

所以在 `version object` 的 url 字段中，也务必填入 jsDelivr 的资源链接，否则检查更新成功后，下载资源可能会失败。

建议将每次插件安装包的名字加上版本号，这样对应的 url 就不同，不需要去手动更新 jsDelivr 缓存。

### 示例

`appcast.json` 文件内容示例：

```json
{
    "identifier": "com.ripperhe.translate.test",
    "versions": [
        {
            "version": "0.2.0",
            "desc": "修复xxx问题",
            "sha256": "00744ca8b8d84713425b7fc2073ca498aa7633faac537a1c1fa80d1264d3fc03",
            "url": "https://raw.githubusercontent.com/ripperhe/test/master/bobplugin/test_0.2.0.bobplugin",
            "minBobVersion": "0.5.0"
        },
        {
            "version": "0.1.0",
            "desc": "初始版本",
            "sha256": "5ec845ee2b60ac931ecac6f56c6a74ee16928ea4a8a4c98e2e85f09316b5ac1e",
            "url": "https://raw.githubusercontent.com/ripperhe/test/master/bobplugin/test_0.1.0.bobplugin",
            "minBobVersion": "0.5.0"
        }
    ]
}
```
