//
//  TranslateLanguage.m
//  Bob
//
//  Created by ripper on 2019/11/14.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "TranslateLanguage.h"

NSString * _Nullable LanguageDescFromEnum(Language lang) {
    static NSDictionary *_descDict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _descDict = @{
            @(Language_auto): @"自动",
            @(Language_zh_Hans): @"中文简体",
            @(Language_zh_Hant): @"中文繁体",
            @(Language_yue): @"粤语",
            @(Language_wyw): @"文言文",
            @(Language_en): @"英语",
            @(Language_ja): @"日语",
            @(Language_ko): @"韩语",
            @(Language_fr): @"法语",
            @(Language_es): @"西班牙语",
            @(Language_th): @"泰语",
            @(Language_ar): @"阿拉伯语",
            @(Language_ru): @"俄语",
            @(Language_pt): @"葡萄牙语",
            @(Language_de): @"德语",
            @(Language_it): @"意大利语",
            @(Language_el): @"希腊语",
            @(Language_nl): @"荷兰语",
            @(Language_pl): @"波兰语",
            @(Language_bg): @"保加利亚语",
            @(Language_et): @"爱沙尼亚语",
            @(Language_da): @"丹麦语",
            @(Language_fi): @"芬兰语",
            @(Language_cs): @"捷克语",
            @(Language_ro): @"罗马尼亚语",
            @(Language_sl): @"斯洛文尼亚语",
            @(Language_sv): @"瑞典语",
            @(Language_hu): @"匈牙利语",
            @(Language_vi): @"越南语",
        };
    });
    return [_descDict objectForKey:@(lang)];
}

NSString * _Nullable BaiduLanguageStringFromEnum(Language lang) {
    static NSDictionary *_stringDict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _stringDict = @{
            @(Language_zh_Hans): @"zh",
            @(Language_zh_Hant): @"cht",
            @(Language_en): @"en",
            @(Language_yue): @"yue",
            @(Language_wyw): @"wyw",
            @(Language_ja): @"jp",
            @(Language_ko): @"kor",
            @(Language_fr): @"fra",
            @(Language_es): @"spa",
            @(Language_th): @"th",
            @(Language_ar): @"ara",
            @(Language_ru): @"ru",
            @(Language_pt): @"pt",
            @(Language_de): @"de",
            @(Language_it): @"it",
            @(Language_el): @"el",
            @(Language_nl): @"nl",
            @(Language_pl): @"pl",
            @(Language_bg): @"bul",
            @(Language_et): @"est",
            @(Language_da): @"dan",
            @(Language_fi): @"fin",
            @(Language_cs): @"cs",
            @(Language_ro): @"rom",
            @(Language_sl): @"slo",
            @(Language_sv): @"swe",
            @(Language_hu): @"hu",
            @(Language_vi): @"vie",
        };
    });
    return [_stringDict objectForKey:@(lang)];
}

Language BaiduLanguageEnumFromString(NSString *lang) {
    static NSDictionary *_stringDict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _stringDict = @{
            @"zh": @(Language_zh_Hans),
            @"cht": @(Language_zh_Hant),
            @"en": @(Language_en),
            @"yue": @(Language_yue),
            @"wyw": @(Language_wyw),
            @"jp": @(Language_ja),
            @"kor": @(Language_ko),
            @"fra": @(Language_fr),
            @"spa": @(Language_es),
            @"th": @(Language_th),
            @"ara": @(Language_ar),
            @"ru": @(Language_ru),
            @"pt": @(Language_pt),
            @"de": @(Language_de),
            @"it": @(Language_it),
            @"el": @(Language_el),
            @"nl": @(Language_nl),
            @"pl": @(Language_pl),
            @"bul": @(Language_bg),
            @"est": @(Language_et),
            @"dan": @(Language_da),
            @"fin": @(Language_fi),
            @"cs": @(Language_cs),
            @"rom": @(Language_ro),
            @"slo": @(Language_sl),
            @"swe": @(Language_sv),
            @"hu": @(Language_hu),
            @"vie": @(Language_vi),
        };
    });
    return [[_stringDict objectForKey:lang] integerValue];
}
