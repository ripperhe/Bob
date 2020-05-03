//
//  YoudaoTranslate.m
//  Bob
//
//  Created by ripper on 2019/12/12.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "YoudaoTranslate.h"

@implementation YoudaoTranslate

#pragma mark - 重写父类方法

- (NSString *)identifier {
    return @"youdao";
}

- (NSString *)name {
    return @"有道翻译";
}

- (NSString *)link {
    return @"http://fanyi.youdao.com";
}

- (MMOrderedDictionary *)supportLanguagesDictionary {
    return [[MMOrderedDictionary alloc] initWithKeysAndObjects:
            @(Language_auto), @"auto",
            @(Language_zh_Hans), @"zh-CHS",
            @(Language_en), @"en",
            @(Language_yue), @"yue",
            @(Language_ja), @"ja",
            @(Language_ko), @"ko",
            @(Language_fr), @"fr",
            @(Language_es), @"es",
            @(Language_pt), @"pt",
            @(Language_it), @"it",
            @(Language_ru), @"ru",
            @(Language_vi), @"vi",
            @(Language_de), @"de",
            @(Language_ar), @"ar",
            @(Language_id), @"id",
            @(Language_af), @"af",
            @(Language_bs), @"bs",
            @(Language_bg), @"bg",
            @(Language_ca), @"ca",
            @(Language_hr), @"hr",
            @(Language_cs), @"cs",
            @(Language_da), @"da",
            @(Language_nl), @"nl",
            @(Language_et), @"et",
            @(Language_fj), @"fj",
            @(Language_fi), @"fi",
            @(Language_el), @"el",
            @(Language_ht), @"ht",
            @(Language_he), @"he",
            @(Language_hi), @"hi",
            @(Language_mww), @"mww",
            @(Language_hu), @"hu",
            @(Language_sw), @"sw",
            @(Language_tlh), @"tlh",
            @(Language_lv), @"lv",
            @(Language_lt), @"lt",
            @(Language_ms), @"ms",
            @(Language_mt), @"mt",
            @(Language_no), @"no",
            @(Language_fa), @"fa",
            @(Language_pl), @"pl",
            @(Language_otq), @"otq",
            @(Language_ro), @"ro",
            @(Language_sr_Cyrl), @"sr-Cyrl",
            @(Language_sr_Latn), @"sr-Latn",
            @(Language_sk), @"sk",
            @(Language_sv), @"sv",
            @(Language_ty), @"ty",
            @(Language_th), @"th",
            @(Language_to), @"to",
            @(Language_tr), @"tr",
            @(Language_uk), @"uk",
            @(Language_ur), @"ur",
            @(Language_cy), @"cy",
            @(Language_yua), @"yua",
            @(Language_sq), @"sq",
            @(Language_am), @"am",
            @(Language_hy), @"hy",
            @(Language_az), @"az",
            @(Language_bn), @"bn",
            @(Language_eu), @"eu",
            @(Language_be), @"be",
            @(Language_ceb), @"ceb",
            @(Language_co), @"co",
            @(Language_eo), @"eo",
            @(Language_tl), @"tl",
            @(Language_fy), @"fy",
            @(Language_gl), @"gl",
            @(Language_ka), @"ka",
            @(Language_gu), @"gu",
            @(Language_ha), @"ha",
            @(Language_haw), @"haw",
            @(Language_is), @"is",
            @(Language_ig), @"ig",
            @(Language_ga), @"ga",
            @(Language_jw), @"jw",
            @(Language_kn), @"kn",
            @(Language_kk), @"kk",
            @(Language_km), @"km",
            @(Language_ku), @"ku",
            @(Language_ky), @"ky",
            @(Language_lo), @"lo",
            @(Language_la), @"la",
            @(Language_lb), @"lb",
            @(Language_mk), @"mk",
            @(Language_mg), @"mg",
            @(Language_mi), @"mi",
            @(Language_ml), @"ml",
            @(Language_mr), @"mr",
            @(Language_mn), @"mn",
            @(Language_my), @"my",
            @(Language_ne), @"ne",
            @(Language_ny), @"ny",
            @(Language_ps), @"ps",
            @(Language_pa), @"pa",
            @(Language_sm), @"sm",
            @(Language_gd), @"gd",
            @(Language_st), @"st",
            @(Language_sn), @"sn",
            @(Language_sd), @"sd",
            @(Language_si), @"si",
            @(Language_so), @"so",
            @(Language_su), @"su",
            @(Language_tg), @"tg",
            @(Language_ta), @"ta",
            @(Language_te), @"te",
            @(Language_uz), @"uz",
            @(Language_xh), @"xh",
            @(Language_yi), @"yi",
            @(Language_yo), @"yo",
            @(Language_zu), @"zu",
            nil];
}

- (void)translate:(NSString *)text from:(Language)from to:(Language)to completion:(void (^)(TranslateResult * _Nullable result, NSError * _Nullable error))completion {
    if (!text.length) {
        completion(nil, TranslateError(TranslateErrorTypeParam, @"翻译的文本为空", nil));
        return;
    }
    
    // 请自行根据各大服务商开发平台的API文档实现
    completion(nil, TranslateError(TranslateErrorTypeDeleted, nil, nil));
}

- (void)detect:(NSString *)text completion:(void (^)(Language, NSError * _Nullable))completion {
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
    completion(nil, TranslateError(TranslateErrorTypeUnsupportLanguage, @"有道翻译不支持获取该语言音频", nil));
}

- (void)ocr:(NSImage *)image from:(Language)from to:(Language)to completion:(void (^)(OCRResult * _Nullable result, NSError * _Nullable error))completion {
    if (!image) {
        completion(nil, TranslateError(TranslateErrorTypeParam, @"图片为空", nil));
        return;
    }
    
    NSData *data = [image mm_PNGData];
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    encodedImageStr = [NSString stringWithFormat:@"data:image/png;base64,%@", encodedImageStr];

    // 请自行根据各大服务商开发平台的API文档实现
    completion(nil, TranslateError(TranslateErrorTypeDeleted, nil, nil));
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
            // 如果翻译结果的语种匹配，不是中文查词或者英文查词时，不调用翻译接口
            if (to == Language_auto || to == ocrResult.to) {
                if (!((ocrResult.to == Language_zh_Hans ||  ocrResult.to == Language_en) &&
                ![ocrResult.mergedText containsString:@" "])) {
                    // 直接回调翻译结果
                    NSLog(@"直接输出翻译结果");
                    ocrSuccess(ocrResult, NO);
                    TranslateResult *result = [TranslateResult new];
                    result.text = ocrResult.mergedText;
                    result.link = [NSString stringWithFormat:@"http://fanyi.youdao.com/translate?i=%@", ocrResult.mergedText.mm_urlencode];
                    result.from = ocrResult.from;
                    result.to = ocrResult.to;
                    result.normalResults = [ocrResult.texts mm_map:^id _Nullable(OCRText * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        return obj.translatedText;
                    }];
                    result.raw = ocrResult.raw;
                    completion(ocrResult, result, nil);
                    return;
                }
            }
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
