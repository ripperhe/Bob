//
//  GoogleTranslate.m
//  Bob
//
//  Created by ripper on 2019/12/18.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "GoogleTranslate.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "YoudaoTranslate.h"

#define kGoogleRootPage(isCN) (isCN ? @"https://translate.google.cn" : @"https://translate.google.com")

@interface GoogleTranslate ()

@property (nonatomic, strong) YoudaoTranslate *youdao;

@end

@implementation GoogleTranslate

- (YoudaoTranslate *)youdao {
    if (!_youdao) {
        _youdao = [YoudaoTranslate new];
    }
    return _youdao;
}

#pragma mark - 重写父类方法

- (NSString *)identifier {
    return self.isCN ? @"google_cn" : @"google";
}

- (NSString *)name {
    return self.isCN ? @"谷歌翻译(国内)" : @"谷歌翻译";
}

- (NSString *)link {
    return kGoogleRootPage(self.isCN);
}

- (MMOrderedDictionary *)supportLanguagesDictionary {
    return [[MMOrderedDictionary alloc] initWithKeysAndObjects:
            @(Language_auto), @"auto",
            @(Language_zh_Hans), @"zh-CN", // zh ?
            @(Language_zh_Hant), @"zh-TW",
            @(Language_en), @"en",
            @(Language_af), @"af",
            @(Language_sq), @"sq",
            @(Language_am), @"am",
            @(Language_ar), @"ar",
            @(Language_hy), @"hy",
            @(Language_az), @"az",
            @(Language_eu), @"eu",
            @(Language_be), @"be",
            @(Language_bn), @"bn",
            @(Language_bs), @"bs",
            @(Language_bg), @"bg",
            @(Language_ca), @"ca",
            @(Language_ceb), @"ceb",
            @(Language_ny), @"ny",
            @(Language_co), @"co",
            @(Language_hr), @"hr",
            @(Language_cs), @"cs",
            @(Language_da), @"da",
            @(Language_nl), @"nl",
            @(Language_eo), @"eo",
            @(Language_et), @"et",
            @(Language_tl), @"tl",
            @(Language_fi), @"fi",
            @(Language_fr), @"fr",
            @(Language_fy), @"fy",
            @(Language_gl), @"gl",
            @(Language_ka), @"ka",
            @(Language_de), @"de",
            @(Language_el), @"el",
            @(Language_gu), @"gu",
            @(Language_ht), @"ht",
            @(Language_ha), @"ha",
            @(Language_haw), @"haw",
            @(Language_he), @"iw", // google 这个 code 码有点特别
            @(Language_hi), @"hi",
            @(Language_hmn), @"hmn",
            @(Language_hu), @"hu",
            @(Language_is), @"is",
            @(Language_ig), @"ig",
            @(Language_id), @"id",
            @(Language_ga), @"ga",
            @(Language_it), @"it",
            @(Language_ja), @"ja",
            @(Language_jw), @"jw",
            @(Language_kn), @"kn",
            @(Language_kk), @"kk",
            @(Language_km), @"km",
            @(Language_ko), @"ko",
            @(Language_ku), @"ku",
            @(Language_ky), @"ky",
            @(Language_lo), @"lo",
            @(Language_la), @"la",
            @(Language_lv), @"lv",
            @(Language_lt), @"lt",
            @(Language_lb), @"lb",
            @(Language_mk), @"mk",
            @(Language_mg), @"mg",
            @(Language_ms), @"ms",
            @(Language_ml), @"ml",
            @(Language_mt), @"mt",
            @(Language_mi), @"mi",
            @(Language_mr), @"mr",
            @(Language_mn), @"mn",
            @(Language_my), @"my",
            @(Language_ne), @"ne",
            @(Language_no), @"no",
            @(Language_ps), @"ps",
            @(Language_fa), @"fa",
            @(Language_pl), @"pl",
            @(Language_pt), @"pt",
            @(Language_pa), @"pa",
            @(Language_ro), @"ro",
            @(Language_ru), @"ru",
            @(Language_sm), @"sm",
            @(Language_gd), @"gd",
            @(Language_sr), @"sr",
            @(Language_st), @"st",
            @(Language_sn), @"sn",
            @(Language_sd), @"sd",
            @(Language_si), @"si",
            @(Language_sk), @"sk",
            @(Language_sl), @"sl",
            @(Language_so), @"so",
            @(Language_es), @"es",
            @(Language_su), @"su",
            @(Language_sw), @"sw",
            @(Language_sv), @"sv",
            @(Language_tg), @"tg",
            @(Language_ta), @"ta",
            @(Language_te), @"te",
            @(Language_th), @"th",
            @(Language_tr), @"tr",
            @(Language_uk), @"uk",
            @(Language_ur), @"ur",
            @(Language_uz), @"uz",
            @(Language_vi), @"vi",
            @(Language_cy), @"cy",
            @(Language_xh), @"xh",
            @(Language_yi), @"yi",
            @(Language_yo), @"yo",
            @(Language_zu), @"zu",
            nil];
}

- (void)translate:(NSString *)text from:(Language)from to:(Language)to completion:(nonnull void (^)(TranslateResult * _Nullable, NSError * _Nullable))completion {
    if (!text.length) {
        completion(nil, TranslateError(TranslateErrorTypeParam, @"翻译的文本为空", nil));
        return;
    }
    
    // 请自行根据各大服务商开发平台的API文档实现
    completion(nil, TranslateError(TranslateErrorTypeDeleted, nil, nil));
}

- (void)detect:(NSString *)text completion:(nonnull void (^)(Language, NSError * _Nullable))completion {
    if (!text.length) {
        completion(Language_auto, TranslateError(TranslateErrorTypeParam, @"识别语言的文本为空", nil));
        return;
    }

    // 请自行根据各大服务商开发平台的API文档实现
    completion(Language_auto, TranslateError(TranslateErrorTypeDeleted, nil, nil));
}

- (void)audio:(NSString *)text from:(Language)from completion:(void (^)(NSString * _Nullable, NSError * _Nullable))completion {
    if (!text.length) {
        completion(nil, TranslateError(TranslateErrorTypeParam, @"获取音频的文本为空", nil));
        return;
    }
    
    // 请自行根据各大服务商开发平台的API文档实现
    completion(nil, TranslateError(TranslateErrorTypeDeleted, nil, nil));
}

- (void)ocr:(NSImage *)image from:(Language)from to:(Language)to completion:(void (^)(OCRResult * _Nullable, NSError * _Nullable))completion {
    if (!image) {
        completion(nil, TranslateError(TranslateErrorTypeParam, @"图片为空", nil));
        return;
    }
    
    // 暂未找到谷歌OCR接口，暂时用有道OCR代替
    // TODO: 考虑一下有没有语言问题
    [self.youdao ocr:image from:from to:to completion:completion];
}

- (void)ocrAndTranslate:(NSImage *)image from:(Language)from to:(Language)to ocrSuccess:(void (^)(OCRResult * _Nonnull, BOOL))ocrSuccess completion:(void (^)(OCRResult * _Nullable, TranslateResult * _Nullable, NSError * _Nullable))completion {
    if (!image) {
        completion(nil, nil, TranslateError(TranslateErrorTypeParam, @"图片为空", nil));
        return;
    }

    mm_weakify(self);
    [self ocr:image from:from to:to completion:^(OCRResult * _Nullable ocrResult, NSError * _Nullable error) {
        mm_strongify(self);
        if (ocrResult) {
            ocrSuccess(ocrResult, YES);
            [self translate:ocrResult.mergedText from:from to:to completion:^(TranslateResult * _Nullable result, NSError * _Nullable error) {
                completion(ocrResult, result, error);
            }];
        }else {
            completion(nil, nil, error);
        }
    }];
}

@end
