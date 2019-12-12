//
//  TranslateLanguage.h
//  Bob
//
//  Created by ripper on 2019/11/14.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 语言代码
 * https://zh.wikipedia.org/wiki/ISO_639-1
 * http://www.lingoes.cn/zh/translator/langcode.htm
 * https://www.iana.org/assignments/language-tags/language-tags.xhtml
 */


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, Language) {
    /// 自动检测/自动选择/未知
    Language_auto,
    /// 中文简体
    Language_zh_Hans,
    /// 中文繁体
    Language_zh_Hant,
    /// 中文粤语
    Language_yue,
    /// 中文文言文
    Language_wyw,
    /// 英语
    Language_en,
    /// 日语
    Language_ja,
    /// 韩语
    Language_ko,
    /// 法语
    Language_fr,
    /// 西班牙语
    Language_es,
    /// 泰语
    Language_th,
    /// 阿拉伯语
    Language_ar,
    /// 俄语
    Language_ru,
    /// 葡萄牙语
    Language_pt,
    /// 德语
    Language_de,
    /// 意大利语
    Language_it,
    /// 希腊语
    Language_el,
    /// 荷兰语
    Language_nl,
    /// 波兰语
    Language_pl,
    /// 保加利亚语
    Language_bg,
    /// 爱沙尼亚语
    Language_et,
    /// 丹麦语
    Language_da,
    /// 芬兰语
    Language_fi,
    /// 捷克语
    Language_cs,
    /// 罗马尼亚语
    Language_ro,
    /// 斯洛文尼亚语
    Language_sl,
    /// 瑞典语
    Language_sv,
    /// 匈牙利语
    Language_hu,
    /// 越南语
    Language_vi,
};

/// 根据枚举获取语言描述
NSString * _Nullable LanguageDescFromEnum(Language lang);

/// 根据枚举获取百度翻译字符串
NSString * _Nullable BaiduLanguageStringFromEnum(Language lang);
/// 根据百度翻译字符串获取枚举
Language BaiduLanguageEnumFromString(NSString *lang);

NS_ASSUME_NONNULL_END
