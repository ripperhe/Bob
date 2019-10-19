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

@interface BaiduTranslate ()

@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, strong) AFHTTPSessionManager *htmlSession;
@property (nonatomic, strong) AFHTTPSessionManager *jsonSession;

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *gtk;

@end

@implementation BaiduTranslate

- (JSContext *)jsContext {
    if (!_jsContext) {
        _jsContext = [JSContext new];
        NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"baidu-sign" ofType:@"js"];
        NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
        // 加载方法
        [_jsContext evaluateScript:jsString];
    }
    return _jsContext;
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

- (void)getTokenAndGtkCompletion:(void (^)(BOOL result))completion {
    [self.htmlSession GET:@"https://fanyi.baidu.com" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                    self.token = token;
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
                    self.gtk = gtk;
                }
                NSLog(@"gtk 匹配结果: %@", gtk);
                *stop = YES;
            }
        }];
        
        completion(YES);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(NO);
    } ];
}

- (void)getLanguageForString:(NSString *)string completion:(void (^)(NSString * _Nullable language))completion {
    NSString *queryString = string;
    if (queryString.length >= 100) {
        queryString = [queryString substringToIndex:100];
    }
    [self.jsonSession POST:@"https://fanyi.baidu.com/langdetect" parameters:@{@"query":queryString} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject && [responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *jsonResult = responseObject;
            NSString *from = [jsonResult objectForKey:@"lan"];
            if ([from isKindOfClass:NSString.class] && from.length) {
                NSLog(@"语种成功: %@", from);
                completion(from);
                return;
            }
        }
        
        completion(nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"语种失败 %@", error);
        completion(nil);
    }];
}

- (void)queryString:(NSString *)queryString completion:(void (^)(id result))completion {
    [self getTokenAndGtkCompletion:^(BOOL result) {
        if (!result) {
            NSLog(@"获取 token 失败");
            completion(nil);
            return;
        }
        
        [self getLanguageForString:queryString completion:^(NSString * _Nullable language) {
            if (!language.length) {
                NSLog(@"获取语种失败");
                completion(nil);
                return;
            }
            
            JSValue *value = [self.jsContext evaluateScript:[NSString stringWithFormat:@"token('%@', '%@')", queryString, self.gtk]];
            NSString *sign = [value toString];
            NSLog(@"sign: %@", sign);

            NSDictionary *params = @{
                @"from": language,
                @"to": @"zh",
                @"query": queryString,
                @"simple_means_flag": @3,
                @"sign": sign,
                @"token": self.token,
            };
            
            [self.jsonSession POST:@"https://fanyi.baidu.com/v2transapi" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *fanyiResult = responseObject;
                NSString *resultString = [[[[fanyiResult objectForKey:@"trans_result"] objectForKey:@"data"] firstObject] objectForKey:@"dst"];
                NSLog(@"翻译成功: %@", resultString);
                completion(resultString);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"翻译失败 %@", error);
                completion(nil);
            }];
        }];
    }];
}


@end
