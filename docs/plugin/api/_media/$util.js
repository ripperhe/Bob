var __tagMap = new Map([
    ['[object String]', 'string'],
    ['[object Number]', 'number'],
    ['[object Boolean]', 'boolean'],
    ['[object Symbol]', 'symbol'],
    ['[object Function]', 'function'],
    ['[object Array]', 'array'],
    ['[object Date]', 'date'],
    ['[object Set]', 'set'],
    ['[object Map]', 'map'],
    ['[object WeakSet]', 'weakset'],
    ['[object WeakMap]', 'weakmap'],
    ['[object RegExp]', 'regexp'],
    ['[object Error]', 'error'],
]);

/**
 * 获取对象类型，支持以下 
 * undefined null
 * string number boolean symbol function
 * array date set map weakset weakmap regexp error
 * 其余返回 object
 * 
 * @param {*} x
 * @returns 类型字符串
 */
function type(x) {
    // undefined
    if (x === undefined) {
        return 'undefined';
    }

    // null
    if (x === null) {
        return 'null';
    }

    var typeValue = typeof x;

    // string number boolean symbol function
    if (typeValue !== 'object') {
        return typeValue;
    }

    // other...
    var tagValue = Object.prototype.toString.call(x);
    var typeFromTag = __tagMap.get(tagValue);

    return typeFromTag === undefined ? 'object' : typeFromTag;
}

/**
 * 调用对象 Object.prototype.toString，兼容 undefined null
 *
 * @param {*} x
 * @returns Object.prototype.toString 方法返回值
 */
function tag(x) {
    // undefined
    if (x === undefined) {
        return '[object Undefined]';
    }

    // null
    if (x === null) {
        return '[object Null]';
    }

    return Object.prototype.toString.call(x);
}

/**
 * 获取一个可打印的对象描述，用于 debug
 *
 * @param {*} x
 * @returns 描述字符串
 */
function desc(x) {
    var descValue = '';
    try {
        var typeValue = type(x);
        if (typeValue === 'object' || typeValue === 'array') {
            descValue = JSON.stringify(x, null, 4);
        } else if (typeValue === 'map' || typeValue === 'set') {
            descValue = JSON.stringify(Array.from(x), null, 4);
        } else if (typeValue === 'symbol') {
            descValue = x.toString();
        } else {
            descValue = `${x}`;
        }
    } catch (error) {
        descValue = `Desc Error: ${error}`;
    }
    return descValue;
}

/**
 * 获取对象详细信息，用于 debug
 * 同时包括 type、tag、desc
 *
 * @param {*} x
 * @returns
 */
function detail(x) {
    var detailValue = `[type]: ${type(x)},\n[tag]: ${tag(x)},\n[desc]: ${desc(x)}`;
    return detailValue;
}

/**
 * 获取对象所有属性名字
 * 代码来源 https://docs.xteko.com/#/data/object?id=props
 *
 * @param {*} object
 * @returns 属性名数组
 */
function props(object) {
    var result = [];
    for (; object != null; object = Object.getPrototypeOf(object)) {
        var names = Object.getOwnPropertyNames(object);
        for (var idx = 0; idx < names.length; idx++) {
            var name = names[idx];
            if (result.indexOf(name) === -1) {
                result.push(name);
            }
        }
    }
    return result;
}

/**
 * 获取对象所有属性名字，过滤掉系统自带的属性
 *
 * @param {*} object
 * @returns 属性名数组
 */
function propsFiltered(object) {
    return props(object).filter(function (key) {
        return [
            "toString",
            "toLocaleString",
            "valueOf",
            "hasOwnProperty",
            "propertyIsEnumerable",
            "isPrototypeOf",
            "__defineGetter__",
            "__defineSetter__",
            "__lookupGetter__",
            "__lookupSetter__",
            "__proto__",
            "constructor"
        ].indexOf(key) === -1;
    });
}

/**
 * 是否为 undefined 或 null
 *
 * @param {*} x
 * @returns 判断结果
 */
function isNil(x) {
    if (x === undefined || x === null) {
        return true;
    }
    return false;
}

/**
 * 根据path获取对象的属性值
 *
 * @param {object} obj 对象
 * @param {string | array} path 对象key或key数组
 * @param {*} defaultValue 默认值
 * @returns 属性值或默认值
 */
function get(obj, path, defaultValue) {
    if (isNil(obj) || typeof obj !== 'object') {
        return defaultValue;
    }

    var pathArray = null;
    if (type(path) === 'string') {
        pathArray = [path];
    } else if (type(path) === 'array') {
        pathArray = path;
    } else {
        return defaultValue;
    }

    var value = obj;

    for (var i = 0; i < pathArray.length; i += 1) {
        if (typeof value !== 'object') {
            return defaultValue;
        }

        var key = pathArray[i]
        if (type(key) !== 'string') {
            return defaultValue;
        }

        value = value[key];
        if (isNil(value)) {
            return defaultValue;
        }
    }

    return value;
}

module.exports = {
    type,
    tag,
    desc,
    detail,
    props,
    propsFiltered,
    isNil,
    get,
};