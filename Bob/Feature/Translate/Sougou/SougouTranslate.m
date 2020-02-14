//
//  SougouTranslate.m
//  Bob
//
//  Created by Joey on 2019/12/28.
//  Copyright © 2019 Joey All rights reserved.
//

#import "SougouTranslate.h"
#import <AFNetworking/AFNetworking.h>
#import "NSString+Additional.h"

@implementation SougouTranslate


//MARK: - overwrite

- (NSString *)identifier {
    return @"sougou";
}

- (NSString *)name {
    return @"搜狗翻译";
}

- (NSString *)link {
    return @"https://fanyi.sogou.com/";
}

- (MMOrderedDictionary *)supportLanguagesDictionary {
    return [[MMOrderedDictionary alloc] initWithKeysAndObjects:
            @(Language_auto), @"auto",
            @(Language_zh_Hans), @"zh-CHS",
            @(Language_zh_Hant), @"zh-CHT",
            @(Language_en), @"en",
            @(Language_yue), @"yue",
//            @(Language_wyw), @"wyw",
            @(Language_ja), @"ja",
            @(Language_ko), @"ko",
            @(Language_fr), @"fr",
            @(Language_es), @"es",
            @(Language_th), @"th",
            @(Language_ar), @"ar",
            @(Language_ru), @"ru",
            @(Language_pt), @"pt",
            @(Language_de), @"de",
            @(Language_it), @"it",
            @(Language_el), @"el",
            @(Language_nl), @"nl",
            @(Language_pl), @"pl",
            @(Language_bg), @"bg",
            @(Language_et), @"et",
            @(Language_da), @"da",
            @(Language_fi), @"fi",
            @(Language_cs), @"cs",
            @(Language_ro), @"ro",
            @(Language_sl), @"sl",
            @(Language_sv), @"sv",
            @(Language_hu), @"hu",
            @(Language_vi), @"vi",
            nil];
}

/*
 文档HTTP地址：http://fanyi.sogou.com/reventondc/api/sogouTranslate
*/
- (void)translate:(NSString *)text from:(Language)from to:(Language)to completion:(nonnull void (^)(TranslateResult * _Nullable, NSError * _Nullable))completion {
    text = [[text componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@" "];
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (text.length == 0) {
        completion(nil, TranslateError(TranslateErrorTypeParam, @"翻译的文本为空", nil));
        return;
    }
#error 请在下方输入你的pid和key，可以去https://deepi.sogou.com/?from=translatepc申请
    NSString *pid = @"";
    NSString *key = @"";
    NSString *salt = [@([[NSDate date] timeIntervalSince1970]) stringValue];
    NSString *sign = [[NSString stringWithFormat:@"%@%@%@%@", pid, text, salt, key] MD5];
    
    NSString *toLanguage = [self languageStringFromEnum:to];
    if (toLanguage == nil || [toLanguage isEqualToString:@"auto"]) { //搜狗不支持to为auto
        toLanguage = [self languageStringFromEnum:Language_zh_Hans];
    }
    
    NSDictionary *bodyParameters = @{
        @"q": text,
        @"from": [self languageStringFromEnum:from] ?: @"auto",
        @"to": toLanguage,
        @"pid": pid,
        @"salt": salt,
        @"sign": sign,
        @"dict": @""
    };
    

    // Request (POST https://fanyi.sogou.com/reventondc/api/sogouTranslate)

    // Create manager
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];

//    // Form URL-Encoded Body
//    NSDictionary* bodyParameters = @{
//        @"q":@"this is my world",
//        @"from":@"auto",
//        @"to":@"zh-CHS",
//        @"pid":@"d984d27cd30223c61ab6080599571176",
//        @"salt":@"123412352",
//        @"sign":@"28acc264be6584f0d436a51ec202c1b6",
//        @"dict":@"false",
//    };
    
    NSString *URL = @"https://fanyi.sogou.com/reventondc/api/sogouTranslate";
    NSMutableURLRequest* request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URL parameters:bodyParameters error:NULL];

    // Add Headers
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"ABTEST=6|1577549489|v17; IPLOC=CN1100; SUID=FFE72D718D6B900A000000005E077EB1" forHTTPHeaderField:@"Cookie"];

    // Fetch Request
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                   uploadProgress:nil
                                                 downloadProgress:nil
                                                completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            completion(nil, TranslateError(TranslateErrorTypeNetwork, @"翻译失败", nil));
        } else {
            NSString *errorMessage = nil;
            NSDictionary *resp = (NSDictionary *)responseObject;
            if ([resp isKindOfClass:[NSDictionary class]] && [resp[@"errorCode"] integerValue] == 0) {
                TranslateResult *result = [TranslateResult new];
                result.text = text;
                result.normalResults = @[resp[@"translation"] ?: @""];
                completion(result, nil);
                return;
            } else {
                if ([resp isKindOfClass:[NSDictionary class]]) {
                    errorMessage = [self errorMeesageWithCode:[resp[@"errorCode"] integerValue]];
                }
            }
            
            NSDictionary *reqDict = @{
                TranslateErrorRequestURLKey: URL,
                TranslateErrorRequestParamKey: bodyParameters
            };
            completion(nil, TranslateError(TranslateErrorTypeAPI, errorMessage ?: @"Unknown", reqDict));
        }
    }];
    [dataTask resume];
}

//ref: https://deepi.sogou.com/doccenter/texttranslatedoc
- (NSString *)errorMeesageWithCode:(NSInteger)code {
    static NSDictionary<NSNumber *, NSString *> *errorCodeMessageMapping;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        errorCodeMessageMapping = @{
            @(1001):    @"Translate API: Unsupported language type",
            @(1002):    @"Translate API: Text too long",
            @(1003):    @"Translate API: Invalid PID",
            @(1004):    @"Translate API: Trial PID limit reached",
            @(10041):   @"Translate API: PID small Language limit reached.",
            @(1005):    @"Translate API: PID traffic too high",
            @(1007):    @"Translate API: Random number does not exist",
            @(1008):    @"Translate API: Signature does not exist",
            @(1009):    @"Translate API: The signature is incorrect",
            @(10010):   @"Translate API: Text does not exist",
            @(1050):    @"Translate API: Internal server error",
            @(1101):    @"Translate API: Account money is not enough",
            @(1102):    @"Translate API: Interface access is limited",
        };
    });
    
    return [NSString stringWithFormat:@"Error code: %@\nmessage: %@", @(code), errorCodeMessageMapping[@(code)]];
}

- (void)detect:(NSString *)text completion:(nonnull void (^)(Language, NSError * _Nullable))completion {
}

- (void)audio:(NSString *)text from:(Language)from completion:(void (^)(NSString * _Nullable, NSError * _Nullable))completion {
}

- (NSString *)getAudioURLWithText:(NSString *)text language:(NSString *)language {
//    return [NSString stringWithFormat:@"%@/gettts?lan=%@&text=%@&spd=3&source=web", kBaiduRootPage, language, text.mm_urlencode];
    return nil;
}

- (void)ocr:(NSImage *)image from:(Language)from to:(Language)to completion:(void (^)(OCRResult * _Nullable, NSError * _Nullable))completion {
    
}

- (void)ocrAndTranslate:(NSImage *)image from:(Language)from to:(Language)to ocrSuccess:(void (^)(OCRResult * _Nonnull, BOOL))ocrSuccess completion:(void (^)(OCRResult * _Nullable, TranslateResult * _Nullable, NSError * _Nullable))completion {
    
}

@end
