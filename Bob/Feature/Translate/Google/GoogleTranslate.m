//
//  GoogleTranslate.m
//  Bob
//
//  Created by ripper on 2019/12/18.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "GoogleTranslate.h"
#import <JavaScriptCore/JavaScriptCore.h>

#define kGoogleRootPage(isCN) (isCN ? @"https://translate.google.cn" : @"https://translate.google.com")

@interface GoogleTranslate ()

@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, strong) JSValue *signFunction;
@property (nonatomic, strong) JSValue *window;
@property (nonatomic, strong) AFHTTPSessionManager *htmlSession;
@property (nonatomic, strong) AFHTTPSessionManager *jsonSession;

@end

@implementation GoogleTranslate

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isCN = YES;
    }
    return self;
}

- (JSContext *)jsContext {
    if (!_jsContext) {
        JSContext *jsContext = [JSContext new];
        NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"google-translate-sign" ofType:@"js"];
        NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
        // 加载方法
        [jsContext evaluateScript:jsString];
        _jsContext = jsContext;
    }
    return _jsContext;
}

- (JSValue *)signFunction {
    if (!_signFunction) {
        _signFunction = [self.jsContext objectForKeyedSubscript:@"sign"];
    }
    return _signFunction;
}

- (JSValue *)window {
    if (!_window) {
        _window = [self.jsContext objectForKeyedSubscript:@"window"];
    }
    return _window;
}

- (AFHTTPSessionManager *)htmlSession {
    if (!_htmlSession) {
        AFHTTPSessionManager *htmlSession = [AFHTTPSessionManager manager];

        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        [requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36" forHTTPHeaderField:@"User-Agent"];
        htmlSession.requestSerializer = requestSerializer;
        
        AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
        htmlSession.responseSerializer = responseSerializer;
        
        _htmlSession = htmlSession;
    }
    return _htmlSession;
}

- (AFHTTPSessionManager *)jsonSession {
    if (!_jsonSession) {
        AFHTTPSessionManager *jsonSession = [AFHTTPSessionManager manager];

        AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
        [requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36" forHTTPHeaderField:@"User-Agent"];
        jsonSession.requestSerializer = requestSerializer;
        
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
        jsonSession.responseSerializer = responseSerializer;
        
        _jsonSession = jsonSession;
    }
    return _jsonSession;
}

#pragma mark -

- (void)sendGetTKKRequestWithCompletion:(void (^)(NSString * _Nullable TKK, NSError * _Nullable error))completion {
    NSString *url = kGoogleRootPage(self.isCN);
    NSMutableDictionary *reqDict = [NSMutableDictionary dictionaryWithObject:url forKey:TranslateErrorRequestURLKey];

    [self.htmlSession GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        __block NSString *tkkResult = nil;
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        // tkk:'437961.2280157552'
        NSRegularExpression *tkkRegex = [NSRegularExpression regularExpressionWithPattern:@"tkk:'\\d+\\.\\d+'," options:NSRegularExpressionCaseInsensitive error:nil];
        NSArray<NSTextCheckingResult *> *tkkMatchResults = [tkkRegex matchesInString:string options:NSMatchingReportCompletion range:NSMakeRange(0, string.length)];
        [tkkMatchResults enumerateObjectsUsingBlock:^(NSTextCheckingResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *tkk = [string substringWithRange:obj.range];
            if (tkk.length > 7) {
                tkkResult = [tkk substringWithRange:NSMakeRange(5, tkk.length - 7)];
            }
            *stop = YES;
        }];
        
        if (tkkResult.length) {
            completion(tkkResult, nil);
        }else {
            [reqDict setObject:responseObject ?: [NSNull null] forKey:TranslateErrorRequestResponseKey];
            completion(nil, TranslateError(TranslateErrorTypeAPI, @"谷歌翻译获取 tkk 失败", reqDict));
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [reqDict setObject:error forKey:TranslateErrorRequestErrorKey];
        completion(nil, TranslateError(TranslateErrorTypeAPI, @"谷歌翻译获取 tkk 失败", reqDict));
    }];
}

- (void)updateTKKWithCompletion:(void (^)(NSError * _Nullable error))completion {
    long long now = floor(NSDate.date.timeIntervalSince1970 / 3600);
    NSString *TKK = [[self.window objectForKeyedSubscript:@"TKK"] toString];
    NSArray<NSString *> *TKKComponents = [TKK componentsSeparatedByString:@"."];
    if (TKKComponents.firstObject.longLongValue == now) {
        completion(nil);
        return;
    }
    
    mm_weakify(self)
    [self sendGetTKKRequestWithCompletion:^(NSString * _Nullable TKK, NSError * _Nullable error) {
        mm_strongify(self)
        if (TKK) {
            [self.window setObject:TKK forKeyedSubscript:@"TKK"];
            completion(nil);
        }else {
            completion(error);
        }
    }];
    
    
//    if (Number(window.TKK.split('.')[0]) === now) {
//      return
//    }
//
//    const html = await request({
//      url: getRoot(com),
//      responseType: 'text'
//    })
//    const code = html.match(/tkk:'(\d+\.\d+)'/)
//    if (code) {
//      window.TKK = code[1]
//    }
}


#pragma mark - 重写父类方法

- (NSString *)identifier {
    return @"google";
}

- (NSString *)name {
    return self.isCN ? @"国内谷歌翻译" : @"谷歌翻译";
}

- (NSString *)link {
    return kGoogleRootPage(self.isCN);
}

- (MMOrderedDictionary *)supportLanguagesDictionary {
    return [[MMOrderedDictionary alloc] initWithKeysAndObjects:
            @(Language_auto), @"auto",
            @(Language_zh_Hans), @"zh", // zh-CN ?
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
            @(Language_he), @"iw", // TODO: goole 这个 code 码有点特别
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
    
    
    [self updateTKKWithCompletion:^(NSError * _Nullable error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        NSString *sign = [[self.signFunction callWithArguments:@[text]] toString];
        
        NSString *url = [kGoogleRootPage(self.isCN) stringByAppendingPathComponent:@"/translate_a/single"];
        url = [url stringByAppendingString:@"?dt=at&dt=bd&dt=ex&dt=ld&dt=md&dt=qca&dt=rw&dt=rm&dt=ss&dt=t"];
        NSDictionary *params = @{
            @"client": @"webapp",
            @"sl": [self languageStringFromEnum:from],
            @"tl": [self languageStringFromEnum:to],
            @"hl": @"zh-CN",
            @"otf": @"2",
            @"ssel": @"3",
            @"tsel": @"0",
            @"kc": @"6",
            @"tk": sign,
            @"q": text,
        };
        
        [self.jsonSession GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            MMLogVerbose(@"请求成功\n%@", responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            MMLogVerbose(@"请求失败\n%@", error);
        }];
    }];
}

- (void)detect:(NSString *)text completion:(nonnull void (^)(Language, NSError * _Nullable))completion {
    if (!text.length) {
        completion(Language_auto, TranslateError(TranslateErrorTypeParam, @"识别语言的文本为空", nil));
        return;
    }
    
    // 字符串太长会导致获取语言的接口报错
    NSString *queryString = text;
    if (queryString.length >= 73) {
        queryString = [queryString substringToIndex:73];
    }
    
}

- (void)audio:(NSString *)text from:(Language)from completion:(void (^)(NSString * _Nullable, NSError * _Nullable))completion {
    if (!text.length) {
        completion(nil, TranslateError(TranslateErrorTypeParam, @"获取音频的文本为空", nil));
        return;
    }

}

- (void)ocr:(NSImage *)image from:(Language)from to:(Language)to completion:(void (^)(OCRResult * _Nullable, NSError * _Nullable))completion {
    if (!image) {
        completion(nil, TranslateError(TranslateErrorTypeParam, @"图片为空", nil));
        return;
    }
    
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
