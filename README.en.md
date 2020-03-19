<p align="center">
  <img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2019/1222/bob-logo.png" width=240 />
</p>
<p align="center">
	<a href="https://github.com/ripperhe/Bob/releases/latest"><img src="https://img.shields.io/github/v/release/ripperhe/Bob?logo=github" alt="GitHub release" /></a>
	<a href="https://github.com/ripperhe/Bob/releases/latest"><img src="https://img.shields.io/github/downloads/ripperhe/Bob/total" alt="Downloads" /></a>
	<a href="https://github.com/ripperhe/Bob/releases/latest"><img src="https://img.shields.io/github/downloads/ripperhe/Bob/latest/total" alt="Downloads latest" /></a>
</p>
<p align="center">
  <a href="https://github.com/ripperhe/Bob">Chinese</a> | <strong>English</strong>
</p>

# Bob

Bob is a macOS translation application for text and pictures, and manual input.

## Install

### Prerequisites

macOS 10.12+

### Download

#### Homebrew Cask

```sh
brew cask install bob
```

#### Manual Install

Download the latest release from [GitHub release](https://github.com/ripperhe/Bob/releases) called `Bob.app.zip`, unzip and drag app to your Applications folder.

⚠️ Installation packages are distributed on GitHub. Other distributions may be dangerous. Please distinguish carefully.

### Permission Settings

<details>
<summary><strong>Enable accessibility permissions</strong></summary><br>
<p>
<p>The first you use <strong>word translation</strong> the following dialog will appear, click <code>Open System Preferences</code>, and enable Bob</p>
<p><img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0117/辅助功能弹窗.png" alt="Accessibility popup" width=500 /></p>
<p>If you accidentally decline it, open System Preferences > Security & Privacy > Privacy > Accessibility and make sure Bob is checked</p>
<p>If there is no pop-up box requesting permissions, click the <code>+</code> number on this page, enter the application folder and select Bob, click <code>Open</code>, and enable Bob</p>
<p><img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0117/辅助功能设置.png" alt="Accessibility settings" width=600 /></p>
</p>
</details>

<details>
<summary><strong>Enable screen recording permissions</strong> Required for macOS 10.15 and above</summary><br>
<p>
<p>When using <strong>Screenshot Translation</strong> for the first time, the following prompt will pop-up, click <code>Open system preferences</code>, and enable Bob</p>
<p><img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0117/屏幕录制弹窗.png" alt="Screen recording popup" width=500 /></p>
<p>If you accidentally decline it, open System Preferences > Security & Privacy > Privacy > Screen Recording and make sure Bob is checked</p>
<p>If there is no pop-up box requesting permissions, click the <code>+</code> number on this page, enter the application folder and select Bob, click <code>Open</code>, and enable Bob</p>
<p><img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0117/屏幕录制设置.png" alt="Screen recording settings" width=600 /></p>
</p>
</details>

<details>
<summary><strong>Enable Chrome-related permissions</strong> If you don't use Chrome, please ignore it</summary><br>
<p>
<p>If you use the Chrome browser, in order to make Bob’s word extraction experience in Chrome closer to the web plugin, please enable the following permissions:</p>
<p>1. Turn on <code>Allow JavaScript in Apple Events</code> in Chrome menu bar > View > Developer</p>
<p><img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0316/chrome设置.png" alt="Chrome settings" width=600 /></p>
<p>2. The first time you use <strong>Crossword Translation</strong> in Chrome, the following popup window should appear, click "OK" (the popup window will only appear once, unless you reset the automation permissions)</p>
<p><img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0316/自动化Chrome弹窗.png" alt="Automated Chrome popup" width=500 /></p>
<p>3. After processing the popup, go to System Preferences > Security & Privacy > Privacy > Automation You should see the following options, please make sure they are checked</p>
<p><img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0316/自动化Chrome设置.png" alt="Automated Chrome settings" width=600 /></p>
</p>
</details>

## Features

| Features | Description | Preview |
| :---: | :---: | :---: |
| Crossword translation | After selecting the text you want to translate, press the crossword translation shortcut (default: `⌥ + D`) | ![Crossword translation-sentence](https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0117/划词翻译-句子.gif) |
| Screenshot translation | Press the screenshot translation shortcut (default: `⌥ + S`), to intercept the area that needs to be translated | ![Screenshot Translation-Sentence](https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0117/截图翻译-句子.gif) |
| Enter translation | Press the Enter Translation Shortcut (default: `⌥ + A`), enter the text to be translated, `Enter` to translate | ![Enter translation-word](https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0117/输入翻译-单词.gif) |
| Plugin translation | `0.3.0` version is supported. After selecting the text to be translated, click the [PopClip](https://pilotmoon.com/popclip/) plugin icon.  See [Bob-PopClip](https://github.com/ripperhe/Bob-PopClip) for details | ![Plugin translation-sentence](https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0117/插件翻译-句子.gif) |

* Cross-word translation is used when **text can be selected and can be copied**
* Screenshot translation is recommended if it cannot be selected or copied
* Input translation is usually used when the text obtained by the above method is inaccurate

## Supported translation engines

Bob currently supports Youdao, Baidu, and Google Translate, as follows:

| Engine | English | English Phonetic | Chinese | Sentences | Supported Languages | Scientific Internet <sup>[1](#scientific-internet)</sup> |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| Youdao | ✅ | ✅ | ✅ | ✅ | 114 | - |
| Baidu | ✅ | ✅ | ✅ | ✅ | 28 | - |
| Google CN | ✅ | ❌ | ✅ | ✅ | 109 | - |
| Google | ✅ | ❌ | ✅ | ✅ | 109 | Required |

Regarding the OCR interface used by screenshot translation, Baidu's own interface currently used by Baidu Translation. Other translations use the proper OCR interface, which will be changed later.

Google Translate cn and Google Translate have exactly the same results, except that Google Translate needs to be used on the Internet, but Google Translate cn does not.

**Note: If you are already online on the Internet, Google Translate may not be available. In addition, if your scientific Internet connection is not configured properly, it will cause other translation interfaces such as Tao, Baidu translation speed to drop significantly, and even fail. Please use PAC mode instead of global mode.**

<a name="#scientific-internet"><sup>[1]</sup></a> _Scientific internet_ is
a term often used in China to express the need for a VPN to bypass government
blocked websites such as Google.

## Common Problems

<h6>Wording translation does not get text</h6>
<details>
<summary>Can't get the text for the wording translation?</summary><br>
<p>
<p>The wording translation is essentially issuing the <code>⌘ + C</code> key combination to copy the selected text, and then get the text from the clipboard for translation. Please ensure that the following conditions are met:</p>
<ol>
<li>Text selected</li>
<li>Accessibility permissions are enabled (there is an opening method in front of the article)</li>
<li>Selected text can be copied</li>
<li>The shortcut for copying text in current software is <code>⌘ + C</code> (Some software <code>⌘ + C</code> have different meanings)</li>
<li>Current software can copy text quickly after pressing <code>⌘ + C</code> (for example, the "Books" app that comes with the system will be stuck after pressing <code>⌘ + C</code> After a while, it is likely to lead to failure in word picking)</li>
</ol>
<p>Some software or websites will append some information after copying the text, so sometimes the obtained text and the selected one may be different.</p>
</p>
</details>

<details>
<summary>Nothing happens when I click the read button?</summary><br>
<p>After clicking the read button, a network request will be made for audio playback. If there is no response, the sentence may be too long and the loading will be slow. Of course, it may also be a BUG. Later, I will consider some UI tips after clicking.</p>
</details>

<details>
<summary>Incorrect translation?</summary><br>
<p>
<table>
<thead>
<tr>
<th style="text-align: center">Error description</th>
<th style="text-align: center">Possible reasons</th>
<th style="text-align: center">Suggestions</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: center">"Translating" is displayed for the first time</td>
<td style="text-align: center">After the software is used for the first time, it may be acquiring tokens, which will be relatively slower.</td>
<td style="text-align: center">It is recommended to wait or restart the software</td>
</tr>
<tr>
<td style="text-align: center">Always show "In Translation" or "Exception Request"</td>
<td style="text-align: center">It may be a network problem or caused by scientific Internet software</td>
<td style="text-align: center">It is recommended to check the network and scientific Internet software settings</td>
</tr>
<tr>
<td style="text-align: center">"Interface exception"</td>
<td style="text-align: center">The request may be too frequent, or the current translation source of the query text is not supported</td>
<td style="text-align: center">Suggest to try again or switch translation source</td>
</tr>
<tr>
<td style="text-align: center">"Data parsing error"</td>
<td style="text-align: center">It may be an API change of the corresponding translation source or the extreme case of the translation result is not covered by the software</td>
<td style="text-align: center">It is recommended to switch the translation source, report the bug and wait for the software update</td>
</tr>
</tbody>
</table>
<p>Of course, you can try <strong>switch translation source</strong> and <strong>restart Bob</strong> for all issues.</p>
</p>
</details>

<details>
<summary>How do I export logs?</summary><br>
<p>Click the menu bar icon and select <code>Help-Export Log</code></p>
</details>

## Developer

<a href="https://github.com/ripperhe/Bob/graphs/contributors"><img src="https://opencollective.com/bob_/contributors.svg?width=890&button=false" /></a>

## Thanks

The inspiration and part of the code for this repository comes from the following:

* [Selection-Translator/crx-selection-translate](https://github.com/Selection-Translator/crx-selection-translate)
* [isee15/Capture-Screen-For-Multi-Screens-On-Mac](https://github.com/isee15/Capture-Screen-For-Multi-Screens-On-Mac)

## Donate

**The last open source version is `0.2.0`. If you want to view it, you can clone the repository and view it in the `archive_0.2.0` folder**

Bob is still very young, and there may be various problems, big and small. If you have any questions or suggestions, you can directly raise issues, or join the QQ group **971584165** 反馈~

If you want to invite me for coffee, you can scan the praise code below on WeChat~ 😘

[Praise list](RewardList.md)

<p align="center">
	<img src="https://cdn.jsdelivr.net/gh/ripperhe/oss@master/2020/0105/ripper_wechat.JPG" width=250 />
</p>
