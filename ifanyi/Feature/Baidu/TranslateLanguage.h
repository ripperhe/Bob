//
//  TranslateLanguage.h
//  ifanyi
//
//  Created by ripper on 2019/11/14.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, Language) {
    /// 自动检测/自动选择/未知
    Language_auto,
    /// 中文简体
    Language_zh,
    /// 中文繁体
    Language_cht,
    /// 英语
    Language_en,
    /// 粤语
    Language_yue,
    /// 文言文
    Language_wyw,
    /// 日语
    Language_jp,
    /// 韩语
    Language_kor,
    /// 法语
    Language_fra,
    /// 西班牙语
    Language_spa,
    /// 泰语
    Language_th,
    /// 阿拉伯语
    Language_ara,
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
    Language_bul,
    /// 爱沙尼亚语
    Language_est,
    /// 丹麦语
    Language_dan,
    /// 芬兰语
    Language_fin,
    /// 捷克语
    Language_cs,
    /// 罗马尼亚语
    Language_rom,
    /// 斯洛文尼亚语
    Language_slo,
    /// 瑞典语
    Language_swe,
    /// 匈牙利语
    Language_hu,
    /// 越南语
    Language_vie,
};

/// 根据枚举获取百度翻译字符串
NSString * _Nullable BaiduLanguageStringFromEnum(Language lang);
/// 根据百度翻译字符串获取枚举
Language LanguageEnumFromBaiduString(NSString *lang);
/// 根据枚举获取描述
NSString * _Nullable LanguageDescFromEnum(Language lang);

NS_ASSUME_NONNULL_END
