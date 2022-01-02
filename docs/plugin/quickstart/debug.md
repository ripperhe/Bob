目前没有什么太好的方法调试插件，可按照如下流程可勉强调试一下：

1. 将插件全部代码写好，可能有疑点的地方使用 [$log](plugin/api/log.md) 打印
2. 将写好的插件代码打包成 `.bobplugin` 文件，如何打包请参考 [打包插件](plugin/quickstart/pack.md) 
3. 安装到 Bob 主程序，并使用
4. 发现有问题的地方，通过查看日志定位问题
    1. 通过 Mac 自带的 控制台（Console） App 查看日志
        1. 开启控制台显示简介信息

            <img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2022/0102/Xnip2022-01-02_18-03-36.jpg" alt="开启控制台简介信息" width=400 />
        2. 点击上方「开始」按钮，并在搜索框输入 `[{当前插件 identifier}]`（图中以插件 `[com.ripper.test-trans]` 为例）

            <img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2022/0102/Xnip2022-01-02_18-04-17.jpg" alt="搜索框输入插件id" width=1000 />
        
        
    2. 通过 Bob「菜单栏图标-帮助-导出日志」将日志导出来，在日志中搜索 `[{当前插件 identifier}]` 即可找到与当前插件有关的所有日志

是的，目前就是这么麻烦，我后面会想办法简化一下。