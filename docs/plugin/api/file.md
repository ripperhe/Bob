Bob 提供了访问文件系统的接口，便于让插件进行一些简单的文件存取。

在前面介绍模块的文章里面我提过，`require` 方法如果使用绝对路径需要传入虚拟路径，通过 `__filename` 和 `__dirname` 获取到的路径也都是虚拟路径。

同样地，在访问文件系统相关接口的时候，也要使用**虚拟路径**，并且**必须使用绝对路径**。插件不需要关心某个文件在电脑上的真实路径是什么，能读取的路径也很有限。

插件的文件系统可以访问两部分路径：

1. 插件自身目录下的所有文件，访问时以 `/` 开头，**只有读取权限**。
2. 我为每个插件都分配了一个独立的区域，可用于缓存文件，暂且称之为「插件沙盒目录」，访问时以 `$sandbox/` 开头，**具有读写权限**。当插件被卸载的时候，这个路径里的文件也会被清空。

注意，写入、移动和删除等操作的目标路径都是需要写入权限的，所以这些操作只能在插件沙盒目录下完成。

## $file.read(path)

读取文件，参数为文件路径，返回结果是 [$data](plugin/api/data.md) 类型的数据。

```js
var data = $file.read('/demo.txt');
```

## $file.write(object)

写入文件，参数是 `object` 类型

* `data` 属性对应需要写入的 `$data` 类型的数据
* `path` 属性对应目标路径

返回值是 `bool` 类型，代表是否写入成功。

```js
var success = $file.write({
  data: $data.fromUTF8('Hello world!'),
  path: "$sandbox/demo.txt"
});
```

## $file.delete(path)

删除文件，参数是文件路径，返回值是 `bool` 类型，代表是否删除成功。

```js
var success = $file.delete('$sandbox/demo.txt');
```

## $file.list(path)

获取某文件夹下的所有文件名，传入的路径必须是一个文件夹。

```js
var contents = $file.list('/');
```

## $file.copy(object)

拷贝文件，参数是 `object` 类型

* `src` 代表源路径
* `dst` 代表目标路径

返回值是 `bool` 类型，代表是否拷贝成功。

```js
var success = $file.copy({
    src: '$sandbox/demo.txt',
    dst: '$sandbox/caches/demo.txt'
});
```

## $file.move(object)

移动文件，参数是 `object` 类型

* `src` 代表源路径
* `dst` 代表目标路径

返回值是 `bool` 类型，代表是否拷贝成功。

```js
var success = $file.move({
    src: '$sandbox/demo.txt',
    dst: '$sandbox/caches/demo.txt'
});
```

## $file.mkdir(path)

创建文件夹，参数是目标路径，返回值是 `bool` 类型，代表是否创建成功。

```js
var success = $file.mkdir('$sandbox/caches');
```

## $file.exists(path)

判断文件或文件夹是否存在，参数是目标路径，返回值是 `bool` 类型。

```js
var exists = $file.exists('$sandbox/caches');
```

## $file.isDirectory(path)

判断某路径是否为文件夹，参数是目标路径，返回值是 `bool` 类型。

```js
var isDirectory = $file.isDirectory('$sandbox/caches');
```
