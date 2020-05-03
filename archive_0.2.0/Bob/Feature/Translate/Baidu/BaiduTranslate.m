//
//  BaiduTranslate.m
//  Bob
//
//  Created by ripper on 2019/10/19.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "BaiduTranslate.h"

@implementation BaiduTranslate

#pragma mark - 重写父类方法

- (NSString *)identifier {
    return @"baidu";
}

- (NSString *)name {
    return @"百度翻译";
}

- (NSString *)link {
    return @"https://fanyi.baidu.com";
}

- (MMOrderedDictionary *)supportLanguagesDictionary {
    return [[MMOrderedDictionary alloc] initWithKeysAndObjects:
            @(Language_auto), @"auto",
            @(Language_zh_Hans), @"zh",
            @(Language_zh_Hant), @"cht",
            @(Language_en), @"en",
            @(Language_yue), @"yue",
            @(Language_wyw), @"wyw",
            @(Language_ja), @"jp",
            @(Language_ko), @"kor",
            @(Language_fr), @"fra",
            @(Language_es), @"spa",
            @(Language_th), @"th",
            @(Language_ar), @"ara",
            @(Language_ru), @"ru",
            @(Language_pt), @"pt",
            @(Language_de), @"de",
            @(Language_it), @"it",
            @(Language_el), @"el",
            @(Language_nl), @"nl",
            @(Language_pl), @"pl",
            @(Language_bg), @"bul",
            @(Language_et), @"est",
            @(Language_da), @"dan",
            @(Language_fi), @"fin",
            @(Language_cs), @"cs",
            @(Language_ro), @"rom",
            @(Language_sl), @"slo",
            @(Language_sv), @"swe",
            @(Language_hu), @"hu",
            @(Language_vi), @"vie",
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
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
    NSData *data = [image mm_PNGData];
    NSString *fromLang = (from == Language_auto) ? [self languageStringFromEnum:Language_en] : [self languageStringFromEnum:from];
    NSString *toLang = nil;
    if (to == Language_auto) {
        toLang = (from == Language_zh_Hans || from == Language_zh_Hant) ? [self languageStringFromEnum:Language_en] : [self languageStringFromEnum:Language_zh_Hans];
    }else {
        toLang = [self languageStringFromEnum:to];
    }
#pragma clang diagnostic pop
    
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
