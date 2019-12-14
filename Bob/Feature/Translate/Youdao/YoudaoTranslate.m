//
//  YoudaoTranslate.m
//  Bob
//
//  Created by ripper on 2019/12/12.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "YoudaoTranslate.h"
#import "YoudaoTranslateResponse.h"
#import "YoudaoOCRResponse.h"

#define kError(type, msg) [TranslateError errorWithType:type message:msg]

@interface YoudaoTranslate ()

@property (nonatomic, strong) AFHTTPSessionManager *jsonSession;

@end

@implementation YoudaoTranslate

- (AFHTTPSessionManager *)jsonSession {
    if (!_jsonSession) {
        AFHTTPSessionManager *jsonSession = [AFHTTPSessionManager manager];

        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        [requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36" forHTTPHeaderField:@"User-Agent"];
        jsonSession.requestSerializer = requestSerializer;
        
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", nil];
        jsonSession.responseSerializer = responseSerializer;
        
        _jsonSession = jsonSession;
    }
    return _jsonSession;
}

#pragma mark - 重写父类方法

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

- (NSString *)link {
    return @"http://fanyi.youdao.com";
}

- (void)translate:(NSString *)text from:(Language)from to:(Language)to completion:(void (^)(TranslateResult * _Nullable result, NSError * _Nullable error))completion {
    if (!text.length) {
        completion(nil, kError(TranslateErrorTypeParamError, @"翻译的文本为空"));
        return;
    }
    
    NSString *url = @"https://aidemo.youdao.com/trans";
    NSDictionary *params = @{
        @"from": [self languageStringFromEnum:from],
        @"to": [self languageStringFromEnum:to],
        @"q": text,
    };
    mm_weakify(self);
    [self.jsonSession POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        mm_strongify(self);
        if (responseObject) {
            YoudaoTranslateResponse *response = [YoudaoTranslateResponse mj_objectWithKeyValues:responseObject];
            if (response && response.errorCode.integerValue == 0) {
                TranslateResult *result = [TranslateResult new];
                result.text = text;
                result.fromSpeakURL = response.speakUrl;
                result.toSpeakURL = response.tSpeakUrl;
                
                // 解析语言
                NSArray *languageComponents = [response.l componentsSeparatedByString:@"2"];
                if (languageComponents.count == 2) {
                    result.from = [self languageEnumFromString:languageComponents.firstObject];
                    result.to = [self languageEnumFromString:languageComponents.lastObject];
                }
                
                [response.basic mm_anyPut:^(YoudaoTranslateResponseBasic *  _Nonnull basic) {
                    TranslateWordResult *wordResult = [TranslateWordResult new];

                    if (result.from == Language_en && result.to == Language_zh_Hans) {
                        // 英文查词
                        
                        // 解析音频
                        NSMutableArray *phoneticArray = [NSMutableArray array];
                        if (basic.us_phonetic && basic.us_speech) {
                            TranslatePhonetic *phonetic = [TranslatePhonetic new];
                            phonetic.name = @"美";
                            phonetic.value = basic.us_phonetic;
                            phonetic.speakURL = basic.us_speech;
                            [phoneticArray addObject:phonetic];
                        }
                        if (basic.uk_phonetic && basic.uk_speech) {
                            TranslatePhonetic *phonetic = [TranslatePhonetic new];
                            phonetic.name = @"英";
                            phonetic.value = basic.uk_phonetic;
                            phonetic.speakURL = basic.uk_speech;
                            [phoneticArray addObject:phonetic];
                        }
                        if (phoneticArray.count) {
                            wordResult.phonetics = phoneticArray.copy;
                        }
                        
                        // 解析词性词义
                        NSMutableArray *partArray = [NSMutableArray array];
                        [basic.explains enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            TranslatePart *part = [TranslatePart new];
                            part.means = @[obj];
                            [partArray addObject:part];
                        }];
                        if (partArray.count) {
                            wordResult.parts = partArray.copy;
                        }
                    }else if (result.from == Language_zh_Hans && result.to == Language_en) {
                        // 中文查词
                        
                        NSMutableArray *simpleWordArray = [NSMutableArray array];
                        [basic.explains enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            TranslateSimpleWord *word = [TranslateSimpleWord new];
                            word.word = obj;
                            // 这个没法获取到词性
                            word.part = @"misc.";
                            [simpleWordArray addObject:word];
                        }];
                        if (simpleWordArray.count) {
                            wordResult.simpleWords = simpleWordArray;
                        }
                    }
                    
                    // 至少要有词义或单词组才认为有单词翻译结果
                    if (wordResult.parts || wordResult.simpleWords) {
                        result.wordResult = wordResult;
                        // 如果是单词或短语，优先使用美式发音
                        if (result.from == Language_en &&
                            result.to == Language_zh_Hans &&
                            wordResult.phonetics.firstObject.speakURL.length) {
                            result.fromSpeakURL = wordResult.phonetics.firstObject.speakURL;
                        }
                    }
                }];
                
                // 解析普通释义
                NSMutableArray *normalResults = [NSMutableArray array];
                [response.translation enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [normalResults addObject:obj];
                }];
                result.normalResults = normalResults.count ? normalResults.copy : nil;
                
                // 生成网页链接
                if (result.wordResult) {
                    result.link = [NSString stringWithFormat:@"https://dict.youdao.com/search?q=%@&keyfrom=fanyi.smartResult", text.mm_urlencode];
                }else {
                    // TODO: 句子翻译跳转貌似不行了
                    result.link = [NSString stringWithFormat:@"http://fanyi.youdao.com/translate?i=%@", text.mm_urlencode];
                }

                // 原始数据
                result.raw = responseObject;
                
                if (result.wordResult || result.normalResults) {
                    completion(result, nil);
                    return;
                }
            }else {
                NSString *string = [NSString stringWithFormat:@"翻译失败，错误码 %@", response.errorCode];
                completion(nil, kError(TranslateErrorTypeAPIError, string));
                return;
            }
        }
        completion(nil, kError(TranslateErrorTypeAPIError, @"翻译失败"));
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, kError(TranslateErrorTypeNetworkError, @"翻译失败"));
    }];
}

- (void)detect:(NSString *)text completion:(void (^)(Language, NSError * _Nullable))completion {
    if (!text.length) {
        completion(Language_auto, kError(TranslateErrorTypeParamError, @"识别语言的文本为空"));
        return;
    }
    
    NSString *queryString = text;
    if (queryString.length >= 73) {
        queryString = [queryString substringToIndex:73];
    }

    [self translate:queryString from:Language_auto to:Language_auto completion:^(TranslateResult * _Nullable result, NSError * _Nullable error) {
        if (result) {
            completion(result.from, nil);
        }else {
            completion(Language_auto, error);
        }
    }];
}

- (void)audio:(NSString *)text from:(Language)from completion:(void (^)(NSString * _Nullable, NSError * _Nullable))completion {
    if (!text.length) {
        completion(nil, kError(TranslateErrorTypeParamError, @"获取音频的文本为空"));
        return;
    }

    [self translate:text from:from to:Language_auto completion:^(TranslateResult * _Nullable result, NSError * _Nullable error) {
        if (result) {
            completion(result.fromSpeakURL, nil);
        }else {
            completion(nil, error);
        }
    }];
}

- (void)ocr:(NSImage *)image from:(Language)from to:(Language)to completion:(void (^)(OCRResult * _Nullable result, NSError * _Nullable error))completion {
    if (!image) {
        completion(nil, kError(TranslateErrorTypeParamError, @"图片为空"));
        return;
    }

    NSData *tiffData = [image TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:tiffData];
    NSData *data = [imageRep representationUsingType:NSBitmapImageFileTypePNG properties:@{}];
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    encodedImageStr = [NSString stringWithFormat:@"data:image/png;base64,%@", encodedImageStr];
    
    // 目前没有指定图片翻译的目标语言
    NSString *url = @"https://aidemo.youdao.com/ocrtransapi1";
    NSDictionary *params = @{
        @"imgBase": encodedImageStr,
    };
    mm_weakify(self);
    [self.jsonSession POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        mm_strongify(self);
        if (responseObject) {
            YoudaoOCRResponse *response = [YoudaoOCRResponse mj_objectWithKeyValues:responseObject];
            if (response) {
                OCRResult *result = [OCRResult new];
                result.from = [self languageEnumFromString:response.lanFrom];
                result.to = [self languageEnumFromString:response.lanTo];
                result.texts = [response.lines mm_map:^id _Nullable(YoudaoOCRResponseLine * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    OCRText *text = [OCRText new];
                    text.text = obj.context;
                    text.translatedText = obj.tranContent;
                    return text;
                }];
                result.raw = responseObject;
                if (result.texts.count) {
                    // 有道翻译自动分段，会将分布在几行的句子合并，故用换行分割
                    result.mergedText = [NSString mm_stringByCombineComponents:[result.texts mm_map:^id _Nullable(OCRText * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        return obj.text;
                    }] separatedString:@"\n"];
                    completion(result, nil);
                    return;
                }
            }
        }
        completion(nil, kError(TranslateErrorTypeAPIError, @"图片翻译失败"));
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, kError(TranslateErrorTypeNetworkError, @"图片翻译失败"));
    }];
}

- (void)translateImage:(NSImage *)image from:(Language)from to:(Language)to ocrSuccess:(void (^)(OCRResult * _Nonnull, BOOL))ocrSuccess completion:(void (^)(OCRResult * _Nullable, TranslateResult * _Nullable, NSError * _Nullable))completion {
    if (!image) {
        completion(nil, nil, kError(TranslateErrorTypeParamError, @"图片为空"));
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
