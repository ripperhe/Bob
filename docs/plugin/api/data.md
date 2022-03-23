最开始我并不打算提供这个数据类的接口，由于文本识别插件需要用到图片数据，考虑之后我觉得 [NSData](https://developer.apple.com/documentation/foundation/nsdata) 的形式最为合适，但这是 `Objective-C` 的数据类型，于是我将其包装了一下，为插件环境提供了一个 `$data` 类。

这个类和其他 `$` 开头的 API 略有不同，其他的 API 更像是一个单例类，拿来就用，但是 `$data` 不一样，它所代表的是一个类，所以我们会使用到它的类方法、对象属性和对象方法。

## $data.fromUTF8(string)

这是一个类方法，通过 UTF-8 字符串生成 `$data` 对象。例如：

```js
var data = $data.fromUTF8('Hello world!');
```

## $data.fromHex(string)

这是一个类方法，通过十六进制字符串生成对应的 `$data` 对象。例如：

```js
var data = $data.fromHex('0ABBAFBD');
```

每两个十六进制字符组成 1 `byte` 的数据，所以请务必传入偶数个字符，不区分大小写。

## $data.fromBase64(string)

这是一个类方法，通过 Base64 字符串生成对应的 `$data` 对象。例如：

```js
var data = $data.fromBase64('SGVsbG8gV29ybGQ=');
```

## $data.fromByteArray(array)

这个是一个类方法，通过字节数组来生秤对应的 `$data` 对象。例如：

```js
var data = $data.fromByteArray([0x0A, 0x0B, 0x0C, 0xFF]);
```

## $data.fromData(data)

这是一个类方法，通过一个 `$data` 类型的对象初始化一个新的 `$data` 类型对象，新生成的对象和之前的对象操作的内存区域不同，数据互不影响。

```js
var data1 = $data.fromUTF8('Hello world!');
var data2 = $data.fromData(data1);
```

## $data.isData(object)

这是一个类方法，用于判断一个对象是否为 `$data` 类型

```js
var data = $data.fromUTF8('Hello world!');
$data.isData(data); // true

var string = 'Hello world!';
$data.isData(string); // false
```

## data.length

这是一个对象属性，用于获取当前对象的字节数。例如：

```js
var data = $data.fromByteArray([0x0A, 0x0B, 0x0C, 0xFF]);
data.length; // 4
```

## data.toUTF8()

这是一个对象方法，将当前对象转换为 UTF-8 字符串。例如：

```js
var data = $data.fromUTF8('Hello world!');
data.toUTF8(); // Hello world!
```

注意，如果该数据本身并不是 UTF-8 格式的，那么将会返回 `undefine`。

## data.toHex([useUpper])

这是一个对象方法，将当前对象转换为二进制字符串。有一个 `bool` 类型的可选参数，用于判断是否使用大写字母，如果不传，默认使用小写。

例如：

```js
var data = $data.fromHex('0ABBAFBD');
data.toHex(true); // 0ABBAFBD
```

## data.toBase64()

这是一个对象方法，将当前对象转换为 Base64 字符串。例如：

```js
var data = $data.fromBase64('SGVsbG8gV29ybGQ=');
data.toBase64(); // SGVsbG8gV29ybGQ=
```

## data.toByteArray()

这是一个对象方法，将当前数据转换为字节数组。例如：

```js
var data = $data.fromByteArray([0x0A, 0x0B, 0x0C, 0xFF]);
data.toByteArray(); // [10, 11, 12, 255]
```

注意，如果数据量大的时候非常占用内存，如非必要，请勿使用。

## data.readUInt8(index)

这是一个对象方法，用于读取某个字节的数据。

参数是一个数字类型，用于指定需要读取的字节下标，范围是 [0, length - 1]，如果超出范围会返回 0。

例如：

```js
var data = $data.fromByteArray([0x0A, 0x0B, 0x0C, 0xFF]);
data.readUInt8(2); // 12
```

## data.writeUInt8(value, index)

这是一个对象方法，用于重写某个字节的数据。

第一个参数是需要写入的值，范围是 [0, 255]。

第二个参数是需要写入的字节下标，范围是 [0, length - 1]，如果超出范围则无效。

例如：

```js
var data = $data.fromByteArray([0x0A, 0x0B, 0x0C, 0xFF]);
data.writeUInt8(0xFF, 0);
data; // [0xFF, 0x0B, 0x0C, 0xFF]
```

## data.subData(start, end)

这是一个对象方法，用于截取一段数据生成一个新的 `$data` 对象，**不会改变当前对象**。

第一个参数是开始下标，会包括在内，范围 [0, length - 1]。

第二个参数是末尾下标，不会包括在内，范围 [0, length]。

其中末尾下标必须大于开始下标。

例如：

```js
var data = $data.fromByteArray([0x0A, 0x0B, 0x0C, 0xFF]);
var subData = data.subData(0, 2);
data; // [0x0A, 0x0B, 0x0C, 0xFF]
subData; // [0x0A, 0x0B]
```

## data.appendData(data)

这是一个对象方法，拼接一个 `$data` 对象的数据到当前对象的末尾，**会改变当前对象**。例如：

```js
var data = $data.fromByteArray([0x0A, 0x0B, 0x0C, 0xFF]);
var data2 = $data.fromByteArray([0xBB, 0xCC]);
data.appendData(data2);
data; // [0x0A, 0x0B, 0x0C, 0xFF, 0xBB, 0xCC]
```

