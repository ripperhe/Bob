//
//  TranslateError.m
//  Bob
//
//  Created by ripper on 2019/11/13.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "TranslateError.h"

@implementation TranslateError

+ (NSError *)errorWithType:(TranslateErrorType)type message:(NSString * _Nullable)message {
    NSString *errorString = nil;
    switch (type) {
        case TranslateErrorTypeParamError:
            errorString = @"参数异常";
            break;
        case TranslateErrorTypeNetworkError:
            errorString = @"网络请求异常";
            break;
        case TranslateErrorTypeAPIError:
            errorString = @"翻译接口异常";
            break;
        case TranslateErrorTypeUnsupportLanguage:
            errorString = @"不支持的语言";
            break;
        default:
            break;
    }
    if (message.length) {
        if (errorString.length) {
            errorString = [NSString stringWithFormat:@"%@: %@", errorString, message];
        }else {
            errorString = message;
        }
    }
    if (!errorString.length) {
        errorString = @"未知错误";
    }
    return [NSError errorWithDomain:@"com.ripperhe.Bob" code:type userInfo:@{NSLocalizedDescriptionKey:errorString}];
}

@end
