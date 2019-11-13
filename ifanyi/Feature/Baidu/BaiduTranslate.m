//
//  BaiduTranslate.m
//  ifanyi
//
//  Created by ripper on 2019/10/19.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "BaiduTranslate.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <AFNetworking/AFNetworking.h>
#import "BaiduTranslateResponse.h"

#define kRoot @"https://fanyi.baidu.com"
#define kError(type) [TranslateError errorWithType:type message:nil]

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
    [self.htmlSession GET:@"https://fanyi.baidu.com" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __block NSString *tokenResult = nil;
        __block NSString *gtkResult = nil;
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        // token: '6d55d690ce5ade4a1fae243892f83ca6',
        NSError *error;
        NSRegularExpression *tokenRegex = [NSRegularExpression regularExpressionWithPattern:@"token: '[A-Za-z0-9]*'," options:NSRegularExpressionCaseInsensitive error:&error];
        if (error) {
            NSLog(@"%@", error);
        }
        [tokenRegex enumerateMatchesInString:string options:NSMatchingReportCompletion range:NSMakeRange(0, string.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString *token = [string substringWithRange:result.range];
                //                NSLog(@"\n%@", token);
                if (token.length > 10) {
                    token = [token substringWithRange:NSMakeRange(8, token.length - 10)];
                    tokenResult = token;
                }
                NSLog(@"token 匹配结果: %@", token);
                *stop = YES;
            }
        }];
        
        
        // window.gtk = '320305.131321201';
        NSError *error2;
        NSRegularExpression *gtkRegex = [NSRegularExpression regularExpressionWithPattern:@"window.gtk = '.*';" options:NSRegularExpressionCaseInsensitive error:&error];
        if (error2) {
            NSLog(@"%@", error2);
        }
        [gtkRegex enumerateMatchesInString:string options:NSMatchingReportCompletion range:NSMakeRange(0, string.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            if (result) {
                NSString *gtk = [string substringWithRange:result.range];
                //                NSLog(@"\n%@", gtk);
                if (gtk.length > 16) {
                    gtk = [gtk substringWithRange:NSMakeRange(14, gtk.length - 16)];
                    gtkResult = gtk;
                }
                NSLog(@"gtk 匹配结果: %@", gtk);
                *stop = YES;
            }
        }];
        
        if (tokenResult.length && gtkResult.length) {
            completion(tokenResult, gtkResult, nil);
        }else {
            completion(nil, nil, kError(TranslateErrorTypeAPIError));
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, nil, kError(TranslateErrorTypeNetworkError));
    } ];
}

- (void)sendTranslateRequest:(NSString *)text from:(NSString *)from to:(NSString *)to completion:(nonnull void (^)(TranslateResult * _Nullable, NSError * _Nullable))completion {
    // 发送翻译请求
    JSValue *value = [self.jsFunction callWithArguments:@[text, self.gtk]];
    NSString *sign = [value toString];

    NSDictionary *params = @{
        @"from": from,
        @"to": to,
        @"query": text,
        @"simple_means_flag": @3,
        @"sign": sign,
        @"token": self.token,
    };
    
    zy_weakify(self)
    [self.jsonSession POST:@"https://fanyi.baidu.com/v2transapi" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        zy_strongify(self)
        if (responseObject) {
            BaiduTranslateResponse *response = [BaiduTranslateResponse mj_objectWithKeyValues:responseObject];
            if (response) {
                if (response.error == 0) {
                    TranslateResult *result = [TranslateResult new];
                    result.text = text;
                    result.link = [NSString stringWithFormat:@"%@/#%@/%@/%@", kRoot, response.trans_result.from, response.trans_result.to, text.zy_urlencode];
                    result.from = response.trans_result.from;
                    result.to = response.trans_result.to;
                    
                    // 解析单词释义
                    [response.dict_result.simple_means zy_anyPut:^(BaiduTranslateResponseSimpleMean *  _Nonnull simple_means) {
                        TranslateWordResult *wordResult = [TranslateWordResult new];
                        
                        [simple_means.symbols.firstObject zy_anyPut:^(BaiduTranslateResponseSymbol *  _Nonnull symbol) {
                            // 解析音标
                            NSMutableArray *phonetics = [NSMutableArray array];
                            if (symbol.ph_am.length) {
                                [phonetics addObject:[TranslatePhonetic zy_anyMake:^(TranslatePhonetic *  _Nonnull obj) {
                                    obj.name = @"美";
                                    obj.value = symbol.ph_am;
                                    obj.ttsURI = [self getAudioURLWithText:result.text language:@"en"];
                                }]];
                            }
                            if (symbol.ph_en.length) {
                                [phonetics addObject:[TranslatePhonetic zy_anyMake:^(TranslatePhonetic *  _Nonnull obj) {
                                    obj.name = @"英";
                                    obj.value = symbol.ph_en;
                                    obj.ttsURI = [self getAudioURLWithText:result.text language:@"uk"];
                                }]];
                            }
                            wordResult.phonetics = phonetics.count ? phonetics.copy : nil;
                            
                            // 解析词性词义
                            NSMutableArray *parts = [NSMutableArray array];
                            [symbol.parts enumerateObjectsUsingBlock:^(BaiduTranslateResponsePart * _Nonnull resultPart, NSUInteger idx, BOOL * _Nonnull stop) {
                                [parts addObject:[TranslatePart zy_anyMake:^(TranslatePart *  _Nonnull obj) {
                                    obj.part = resultPart.part.length ? resultPart.part : nil;
                                    obj.means = resultPart.means;
                                }]];
                            }];
                            wordResult.parts = parts.count ? parts.copy : nil;
                        }];
                        
                        // 解析其他形式
                        [simple_means.exchange zy_anyPut:^(BaiduTranslateResponseExchange*  _Nonnull exchange) {
                            NSMutableArray *exchanges = [NSMutableArray array];
                            if (exchange.word_third.count) {
                                [exchanges addObject:[TranslateExchange zy_anyMake:^(TranslateExchange *  _Nonnull obj) {
                                    obj.name = @"第三人称单数";
                                    obj.words = exchange.word_third;
                                }]];
                            }
                            if (exchange.word_pl.count) {
                                [exchanges addObject:[TranslateExchange zy_anyMake:^(TranslateExchange *  _Nonnull obj) {
                                    obj.name = @"复数";
                                    obj.words = exchange.word_pl;
                                }]];
                            }
                            if (exchange.word_er.count) {
                                [exchanges addObject:[TranslateExchange zy_anyMake:^(TranslateExchange *  _Nonnull obj) {
                                    obj.name = @"比较级";
                                    obj.words = exchange.word_er;
                                }]];
                            }
                            if (exchange.word_est.count) {
                                [exchanges addObject:[TranslateExchange zy_anyMake:^(TranslateExchange *  _Nonnull obj) {
                                    obj.name = @"最高级";
                                    obj.words = exchange.word_est;
                                }]];
                            }
                            if (exchange.word_past.count) {
                                [exchanges addObject:[TranslateExchange zy_anyMake:^(TranslateExchange *  _Nonnull obj) {
                                    obj.name = @"过去式";
                                    obj.words = exchange.word_past;
                                }]];
                            }
                            if (exchange.word_done.count) {
                                [exchanges addObject:[TranslateExchange zy_anyMake:^(TranslateExchange *  _Nonnull obj) {
                                    obj.name = @"过去分词";
                                    obj.words = exchange.word_done;
                                }]];
                            }
                            if (exchange.word_ing.count) {
                                [exchanges addObject:[TranslateExchange zy_anyMake:^(TranslateExchange *  _Nonnull obj) {
                                    obj.name = @"现在分词";
                                    obj.words = exchange.word_ing;
                                }]];
                            }
                            if (exchange.word_proto.count) {
                                [exchanges addObject:[TranslateExchange zy_anyMake:^(TranslateExchange *  _Nonnull obj) {
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
                    }
                    return;
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
        completion(nil, kError(TranslateErrorTypeAPIError));
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, kError(TranslateErrorTypeNetworkError));
    }];
}

#pragma mark -

- (void)translate:(NSString *)text from:(NSString *)from to:(NSString *)to completion:(nonnull void (^)(TranslateResult * _Nullable, NSError * _Nullable))completion {
    if (!text.length) {
        completion(nil, kError(TranslateErrorTypeParamError));
        return;
    }
    
    void(^request)(void) = ^(void) {
        if (!from) {
            zy_weakify(self)
            [self detect:text completion:^(NSString * _Nullable language, NSError * _Nullable error) {
                zy_strongify(self)
                if (error) {
                    completion(nil, error);
                    return;
                }
                
                NSString *toLanguage = to;
                if (!toLanguage) {
                    toLanguage = [language.lowercaseString hasPrefix:@"zh"] ? @"en" : @"zh";
                }

                [self sendTranslateRequest:text from:language to:toLanguage completion:completion];
            }];
        }else {
            NSString *toLanguage = to;
            if (!toLanguage) {
                toLanguage = [from.lowercaseString hasPrefix:@"zh"] ? @"en" : @"zh";
            }

            [self sendTranslateRequest:text from:from to:toLanguage completion:completion];
        }
    };
    
    if (!self.token || !self.gtk) {
        // 获取 token
        zy_weakify(self)
        [self sendGetTokenAndGtkRequestWithCompletion:^(NSString *token, NSString *gtk, NSError *error) {
            zy_strongify(self)
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

- (void)detect:(NSString *)text completion:(nonnull void (^)(NSString * _Nullable, NSError * _Nullable))completion {
    if (!text.length) {
        completion(nil, kError(TranslateErrorTypeParamError));
        return;
    }
    
    NSString *queryString = text;
    if (queryString.length >= 73) {
        queryString = [queryString substringToIndex:73];
    }
    [self.jsonSession POST:@"https://fanyi.baidu.com/langdetect" parameters:@{@"query":queryString} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *jsonResult = responseObject;
            NSString *from = [jsonResult objectForKey:@"lan"];
            if ([from isKindOfClass:NSString.class] && from.length) {
                completion(from, nil);
            }else {
                completion(nil, kError(TranslateErrorTypeUnsupportLanguage));
            }
            return;
        }
        completion(nil, kError(TranslateErrorTypeAPIError));
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, kError(TranslateErrorTypeNetworkError));
    }];
}

- (void)audio:(NSString *)text from:(NSString *)from completion:(void (^)(NSString * _Nullable, NSError * _Nullable))completion {
    if (!text.length) {
        completion(nil, kError(TranslateErrorTypeParamError));
        return;
    }
    
    if (from.length) {
        completion([self getAudioURLWithText:text language:from], nil);
    }else {
        [self detect:text completion:^(NSString * _Nullable language, NSError * _Nullable error) {
            if (!error) {
                completion([self getAudioURLWithText:text language:language], nil);
            }else {
                completion(nil, error);
            }
        }];
    }
}

- (NSString *)getAudioURLWithText:(NSString *)text language:(NSString *)language {
    return [NSString stringWithFormat:@"%@/gettts?lan=%@&text=%@&spd=3&source=web", kRoot, language, text.zy_urlencode];
}

@end
