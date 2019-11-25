//
//  BaiduTranslate.m
//  Bob
//
//  Created by ripper on 2019/10/19.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "BaiduTranslate.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <AFNetworking/AFNetworking.h>
#import "BaiduTranslateResponse.h"

#define kRootPage @"https://fanyi.baidu.com"
#define kError(type, msg) [TranslateError errorWithType:type message:msg]

@interface BaiduTranslate ()

@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, strong) JSValue *jsFunction;
@property (nonatomic, strong) AFHTTPSessionManager *htmlSession;
@property (nonatomic, strong) AFHTTPSessionManager *jsonSession;

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *gtk;

@end

@implementation BaiduTranslate

- (JSContext *)jsContext {
    if (!_jsContext) {
        JSContext *jsContext = [JSContext new];
        NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"baidu-sign" ofType:@"js"];
        NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
        // 加载方法
        [jsContext evaluateScript:jsString];
        _jsContext = jsContext;
    }
    return _jsContext;
}

- (JSValue *)jsFunction {
    if (!_jsFunction) {
        _jsFunction = [self.jsContext objectForKeyedSubscript:@"token"];
    }
    return _jsFunction;
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

- (void)sendGetTokenAndGtkRequestWithCompletion:(void (^)(NSString *token, NSString *gtk, NSError *error))completion {
    [self.htmlSession GET:kRootPage parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __block NSString *tokenResult = nil;
        __block NSString *gtkResult = nil;
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        // token: '6d55d690ce5ade4a1fae243892f83ca6',
        NSRegularExpression *tokenRegex = [NSRegularExpression regularExpressionWithPattern:@"token: '[A-Za-z0-9]*'," options:NSRegularExpressionCaseInsensitive error:nil];
        [tokenRegex enumerateMatchesInString:string options:NSMatchingReportCompletion range:NSMakeRange(0, string.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString *token = [string substringWithRange:result.range];
                if (token.length > 10) {
                    token = [token substringWithRange:NSMakeRange(8, token.length - 10)];
                    tokenResult = token;
                }
                // NSLog(@"token 匹配结果: %@", token);
                *stop = YES;
            }
        }];
        
        // window.gtk = '320305.131321201';
        NSRegularExpression *gtkRegex = [NSRegularExpression regularExpressionWithPattern:@"window.gtk = '.*';" options:NSRegularExpressionCaseInsensitive error:nil];
        [gtkRegex enumerateMatchesInString:string options:NSMatchingReportCompletion range:NSMakeRange(0, string.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString *gtk = [string substringWithRange:result.range];
                if (gtk.length > 16) {
                    gtk = [gtk substringWithRange:NSMakeRange(14, gtk.length - 16)];
                    gtkResult = gtk;
                }
                // NSLog(@"gtk 匹配结果: %@", gtk);
                *stop = YES;
            }
        }];
        
        if (tokenResult.length && gtkResult.length) {
            completion(tokenResult, gtkResult, nil);
        }else {
            completion(nil, nil, kError(TranslateErrorTypeAPIError, @"获取 token 失败"));
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, nil, kError(TranslateErrorTypeNetworkError, @"获取 token 失败"));
    } ];
}

- (void)sendTranslateRequest:(NSString *)text from:(Language)from to:(Language)to completion:(nonnull void (^)(TranslateResult * _Nullable, NSError * _Nullable))completion {
    // 获取sign
    JSValue *value = [self.jsFunction callWithArguments:@[text, self.gtk]];
    NSString *sign = [value toString];

    NSDictionary *params = @{
        @"from": BaiduLanguageStringFromEnum(from),
        @"to": BaiduLanguageStringFromEnum(to),
        @"query": text,
        @"simple_means_flag": @3,
        @"sign": sign,
        @"token": self.token,
    };
    
    mm_weakify(self)
    [self.jsonSession POST:[kRootPage stringByAppendingString:@"/v2transapi"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        mm_strongify(self)
        if (responseObject) {
            BaiduTranslateResponse *response = [BaiduTranslateResponse mj_objectWithKeyValues:responseObject];
            if (response) {
                if (response.error == 0) {
                    TranslateResult *result = [TranslateResult new];
                    result.text = text;
                    result.link = [NSString stringWithFormat:@"%@/#%@/%@/%@", kRootPage, response.trans_result.from, response.trans_result.to, text.mm_urlencode];
                    result.from = BaiduLanguageEnumFromString(response.trans_result.from);
                    result.to = BaiduLanguageEnumFromString(response.trans_result.to);
                    
                    // 解析单词释义
                    [response.dict_result.simple_means mm_anyPut:^(BaiduTranslateResponseSimpleMean *  _Nonnull simple_means) {
                        TranslateWordResult *wordResult = [TranslateWordResult new];
                        
                        [simple_means.symbols.firstObject mm_anyPut:^(BaiduTranslateResponseSymbol *  _Nonnull symbol) {
                            // 解析音标
                            NSMutableArray *phonetics = [NSMutableArray array];
                            if (symbol.ph_am.length) {
                                [phonetics addObject:[TranslatePhonetic mm_anyMake:^(TranslatePhonetic *  _Nonnull obj) {
                                    obj.name = @"美";
                                    obj.value = symbol.ph_am;
                                    obj.ttsURI = [self getAudioURLWithText:result.text language:@"en"];
                                }]];
                            }
                            if (symbol.ph_en.length) {
                                [phonetics addObject:[TranslatePhonetic mm_anyMake:^(TranslatePhonetic *  _Nonnull obj) {
                                    obj.name = @"英";
                                    obj.value = symbol.ph_en;
                                    obj.ttsURI = [self getAudioURLWithText:result.text language:@"uk"];
                                }]];
                            }
                            wordResult.phonetics = phonetics.count ? phonetics.copy : nil;
                            
                            // 解析词性词义
                            NSMutableArray *parts = [NSMutableArray array];
                            [symbol.parts enumerateObjectsUsingBlock:^(BaiduTranslateResponsePart * _Nonnull resultPart, NSUInteger idx, BOOL * _Nonnull stop) {
                                TranslatePart *part = [TranslatePart mm_anyMake:^(TranslatePart *  _Nonnull obj) {
                                    obj.part = resultPart.part.length ? resultPart.part : nil;
                                    obj.means = [resultPart.means mm_map:^id _Nullable(NSString * _Nonnull mean, NSUInteger idx, BOOL * _Nonnull stop) {
                                        return [mean isKindOfClass:NSString.class] ? mean : nil;
                                    }];
                                }];
                                if (part.means.count) {
                                    [parts addObject:part];
                                }
                            }];
                            wordResult.parts = parts.count ? parts.copy : nil;
                        }];
                        
                        // 解析其他形式
                        [simple_means.exchange mm_anyPut:^(BaiduTranslateResponseExchange*  _Nonnull exchange) {
                            NSMutableArray *exchanges = [NSMutableArray array];
                            if (exchange.word_third.count) {
                                [exchanges addObject:[TranslateExchange mm_anyMake:^(TranslateExchange *  _Nonnull obj) {
                                    obj.name = @"第三人称单数";
                                    obj.words = exchange.word_third;
                                }]];
                            }
                            if (exchange.word_pl.count) {
                                [exchanges addObject:[TranslateExchange mm_anyMake:^(TranslateExchange *  _Nonnull obj) {
                                    obj.name = @"复数";
                                    obj.words = exchange.word_pl;
                                }]];
                            }
                            if (exchange.word_er.count) {
                                [exchanges addObject:[TranslateExchange mm_anyMake:^(TranslateExchange *  _Nonnull obj) {
                                    obj.name = @"比较级";
                                    obj.words = exchange.word_er;
                                }]];
                            }
                            if (exchange.word_est.count) {
                                [exchanges addObject:[TranslateExchange mm_anyMake:^(TranslateExchange *  _Nonnull obj) {
                                    obj.name = @"最高级";
                                    obj.words = exchange.word_est;
                                }]];
                            }
                            if (exchange.word_past.count) {
                                [exchanges addObject:[TranslateExchange mm_anyMake:^(TranslateExchange *  _Nonnull obj) {
                                    obj.name = @"过去式";
                                    obj.words = exchange.word_past;
                                }]];
                            }
                            if (exchange.word_done.count) {
                                [exchanges addObject:[TranslateExchange mm_anyMake:^(TranslateExchange *  _Nonnull obj) {
                                    obj.name = @"过去分词";
                                    obj.words = exchange.word_done;
                                }]];
                            }
                            if (exchange.word_ing.count) {
                                [exchanges addObject:[TranslateExchange mm_anyMake:^(TranslateExchange *  _Nonnull obj) {
                                    obj.name = @"现在分词";
                                    obj.words = exchange.word_ing;
                                }]];
                            }
                            if (exchange.word_proto.count) {
                                [exchanges addObject:[TranslateExchange mm_anyMake:^(TranslateExchange *  _Nonnull obj) {
                                    obj.name = @"词根";
                                    obj.words = exchange.word_proto;
                                }]];
                            }
                            wordResult.exchanges = exchanges.count ? exchanges.copy : nil;
                        }];
                        
                        // 至少要有词义才认为有单词翻译结果
                        if (wordResult.parts) {
                            result.wordResult = wordResult;
                        }
                    }];
                    
                    // 解析普通释义
                    NSMutableArray *normalResults = [NSMutableArray array];
                    [response.trans_result.data enumerateObjectsUsingBlock:^(BaiduTranslateResponseData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [normalResults addObject:obj.dst];
                    }];
                    result.normalResults = normalResults.count ? normalResults.copy : nil;
                    
                    // 原始数据
                    result.raw = responseObject;
                    
                    if (result.wordResult || result.normalResults) {
                        completion(result, nil);
                        return;
                    }
                }else if (response.error == 997) {
                    // token 失效，重新获取
                    // 如果一直是 997 就会循环调用，后续优化一下
                    self.token = nil;
                    self.gtk = nil;
                    [self translate:text from:from to:to completion:completion];
                    return;
                }
            }
        }
        completion(nil, kError(TranslateErrorTypeAPIError, @"翻译失败"));
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, kError(TranslateErrorTypeNetworkError, @"翻译失败"));
    }];
}

#pragma mark -

- (void)translate:(NSString *)text from:(Language)from to:(Language)to completion:(nonnull void (^)(TranslateResult * _Nullable, NSError * _Nullable))completion {
    if (!text.length) {
        completion(nil, kError(TranslateErrorTypeParamError, @"翻译的文本为空"));
        return;
    }
    
    void(^request)(void) = ^(void) {
        
        void(^translate)(Language f) = ^(Language f) {
            Language toLang = to;
            if (toLang == Language_auto) {
                toLang = (f == Language_zh || f == Language_cht) ? Language_en : Language_zh;
            }

            [self sendTranslateRequest:text from:f to:toLang completion:completion];
        };
        
        if (from == Language_auto) {
            [self detect:text completion:^(Language lang, NSError * _Nullable error) {
                if (error) {
                    completion(nil, error);
                    return;
                }
                translate(lang);
            }];
        }else {
            translate(from);
        }
    };
    
    if (!self.token || !self.gtk) {
        // 获取 token
        mm_weakify(self)
        [self sendGetTokenAndGtkRequestWithCompletion:^(NSString *token, NSString *gtk, NSError *error) {
            mm_strongify(self)
            if (error) {
                completion(nil, error);
                return;
            }
            self.token = token;
            self.gtk = gtk;
            request();
        }];
    }else {
        // 直接请求
        request();
    }
}

- (void)detect:(NSString *)text completion:(nonnull void (^)(Language, NSError * _Nullable))completion {
    if (!text.length) {
        completion(Language_auto, kError(TranslateErrorTypeParamError, @"判断语言的文本为空"));
        return;
    }
    
    NSString *queryString = text;
    if (queryString.length >= 73) {
        queryString = [queryString substringToIndex:73];
    }
    [self.jsonSession POST:[kRootPage stringByAppendingString:@"/langdetect"] parameters:@{@"query":queryString} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *jsonResult = responseObject;
            NSString *from = [jsonResult objectForKey:@"lan"];
            if ([from isKindOfClass:NSString.class] && from.length) {
                completion(BaiduLanguageEnumFromString(from), nil);
            }else {
                completion(Language_auto, kError(TranslateErrorTypeUnsupportLanguage, nil));
            }
            return;
        }
        completion(Language_auto, kError(TranslateErrorTypeAPIError, @"判断语言失败"));
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(Language_auto, kError(TranslateErrorTypeNetworkError, @"判断语言失败"));
    }];
}

- (void)audio:(NSString *)text from:(Language)from completion:(void (^)(NSString * _Nullable, NSError * _Nullable))completion {
    if (!text.length) {
        completion(nil, kError(TranslateErrorTypeParamError, @"获取音频的文本为空"));
        return;
    }
    
    if (from == Language_auto) {
        [self detect:text completion:^(Language lang, NSError * _Nullable error) {
            if (!error) {
                completion([self getAudioURLWithText:text language:BaiduLanguageStringFromEnum(lang)], nil);
            }else {
                completion(nil, error);
            }
        }];
    }else {
        completion([self getAudioURLWithText:text language:BaiduLanguageStringFromEnum(from)], nil);
    }
}

- (NSString *)getAudioURLWithText:(NSString *)text language:(NSString *)language {
    return [NSString stringWithFormat:@"%@/gettts?lan=%@&text=%@&spd=3&source=web", kRootPage, language, text.mm_urlencode];
}

- (void)ocr:(NSImage *)image type:(NSBitmapImageFileType)type from:(Language)from to:(Language)to completion:(void (^)(OCRResult * _Nullable, NSError * _Nullable))completion {
    if (!image) {
        completion(nil, kError(TranslateErrorTypeParamError, @"图片为空"));
        return;
    }
    
    NSData *tiffData = [image TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:tiffData];
    NSData *data = [imageRep representationUsingType:type properties:@{}];
    NSString *fromLang = BaiduLanguageStringFromEnum(from);
    NSString *toLang = BaiduLanguageStringFromEnum(to);
    
    NSDictionary *para = @{
        @"image": data,
        @"from": fromLang,
        @"to": toLang
    };
    
    [self.jsonSession POST:@"https://fanyi.baidu.com/getocr" parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"image" fileName:@"blob" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // NSLog(@"%@", uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // NSLog(@"%@", responseObject);
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *jsonResult = responseObject;
            NSDictionary *data = [jsonResult objectForKey:@"data"];
            if (data && [data isKindOfClass:[NSDictionary class]]) {
                OCRResult *result = [OCRResult mj_objectWithKeyValues:data];
                if (result.src.count) {
                    completion(result, nil);
                    return;
                }
            }
            completion(nil, kError(TranslateErrorTypeAPIError, @"图片文本识别失败"));
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // NSLog(@"%@", error);
        completion(nil, kError(TranslateErrorTypeNetworkError, @"图片文本识别失败"));
    }];
}

@end
