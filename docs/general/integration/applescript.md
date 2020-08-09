Bob 可以通过 AppleScript 调用，目前仅支持翻译文本，代码如下：

```applescript
tell application "Bob"
	launch
	translate "需要翻译的文本"
end tell
```