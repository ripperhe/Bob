考虑到方便使用，Bob 内置了一些模块：

* `crypto-js` <https://github.com/brix/crypto-js>
* `$util`

## crypto-js

该模块主要用于加密，加载内置模块时直接写模块名字即可，如下所示：

```js
var CryptoJS = require("crypto-js");

$log.info(CryptoJS.HmacSHA1("Message", "Key"));
```

## $util

该模块是我写的一些简便方法，方便自己开发

```js
var util = require("$util");

var foo = util.type(null); // null
```

具体代码如下所示：

[$util.js](./_media/$util.js ':include :type=code')
