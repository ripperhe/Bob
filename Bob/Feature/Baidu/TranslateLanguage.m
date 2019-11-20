//
//  TranslateLanguage.m
//  Bob
//
//  Created by ripper on 2019/11/14.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "TranslateLanguage.h"

NSString * _Nullable BaiduLanguageStringFromEnum(Language lang) {
    static NSDictionary *_stringDict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _stringDict = @{
            @(Language_zh): @"zh",
            @(Language_cht): @"cht",
            @(Language_en): @"en",
            @(Language_yue): @"yue",
            @(Language_wyw): @"wyw",
            @(Language_jp): @"jp",
            @(Language_kor): @"kor",
            @(Language_fra): @"fra",
            @(Language_spa): @"spa",
            @(Language_th): @"th",
            @(Language_ara): @"ara",
            @(Language_ru): @"ru",
            @(Language_pt): @"pt",
            @(Language_de): @"de",
            @(Language_it): @"it",
            @(Language_el): @"el",
            @(Language_nl): @"nl",
            @(Language_pl): @"pl",
            @(Language_bul): @"bul",
            @(Language_est): @"est",
            @(Language_dan): @"dan",
            @(Language_fin): @"fin",
            @(Language_cs): @"cs",
            @(Language_rom): @"rom",
            @(Language_slo): @"slo",
            @(Language_swe): @"swe",
            @(Language_hu): @"hu",
            @(Language_vie): @"vie",
        };
    });
    return [_stringDict objectForKey:@(lang)];
}

Language BaiduLanguageEnumFromString(NSString *lang) {
    static NSDictionary *_stringDict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _stringDict = @{
            @"zh": @(Language_zh),
            @"cht": @(Language_cht),
            @"en": @(Language_en),
            @"yue": @(Language_yue),
            @"wyw": @(Language_wyw),
            @"jp": @(Language_jp),
            @"kor": @(Language_kor),
            @"fra": @(Language_fra),
            @"spa": @(Language_spa),
            @"th": @(Language_th),
            @"ara": @(Language_ara),
            @"ru": @(Language_ru),
            @"pt": @(Language_pt),
            @"de": @(Language_de),
            @"it": @(Language_it),
            @"el": @(Language_el),
            @"nl": @(Language_nl),
            @"pl": @(Language_pl),
            @"bul": @(Language_bul),
            @"est": @(Language_est),
            @"dan": @(Language_dan),
            @"fin": @(Language_fin),
            @"cs": @(Language_cs),
            @"rom": @(Language_rom),
            @"slo": @(Language_slo),
            @"swe": @(Language_swe),
            @"hu": @(Language_hu),
            @"vie": @(Language_vie),
        };
    });
    return [[_stringDict objectForKey:lang] integerValue];
}

NSString * _Nullable LanguageDescFromEnum(Language lang) {
    static NSDictionary *_descDict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _descDict = @{
            @(Language_auto): @"自动",
            @(Language_zh): @"中文简体",
            @(Language_cht): @"中文繁体",
            @(Language_en): @"英语",
            @(Language_yue): @"粤语",
            @(Language_wyw): @"文言文",
            @(Language_jp): @"日语",
            @(Language_kor): @"韩语",
            @(Language_fra): @"法语",
            @(Language_spa): @"西班牙语",
            @(Language_th): @"泰语",
            @(Language_ara): @"阿拉伯语",
            @(Language_ru): @"俄语",
            @(Language_pt): @"葡萄牙语",
            @(Language_de): @"德语",
            @(Language_it): @"意大利语",
            @(Language_el): @"希腊语",
            @(Language_nl): @"荷兰语",
            @(Language_pl): @"波兰语",
            @(Language_bul): @"保加利亚语",
            @(Language_est): @"爱沙尼亚语",
            @(Language_dan): @"丹麦语",
            @(Language_fin): @"芬兰语",
            @(Language_cs): @"捷克语",
            @(Language_rom): @"罗马尼亚语",
            @(Language_slo): @"斯洛文尼亚语",
            @(Language_swe): @"瑞典语",
            @(Language_hu): @"匈牙利语",
            @(Language_vie): @"越南语",
        };
    });
    return [_descDict objectForKey:@(lang)];
}
