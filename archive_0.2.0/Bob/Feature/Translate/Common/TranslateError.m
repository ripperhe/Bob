//
//  TranslateError.m
//  Bob
//
//  Created by ripper on 2019/11/13.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "TranslateError.h"

NSString * const TranslateErrorRequestKey = @"TranslateErrorRequestKey";
NSString * const TranslateErrorRequestURLKey = @"URL";
NSString * const TranslateErrorRequestParamKey = @"Param";
NSString * const TranslateErrorRequestResponseKey = @"Response";
NSString * const TranslateErrorRequestErrorKey = @"Error";

@implementation TranslateError

+ (NSError *)errorWithType:(TranslateErrorType)type
                   message:(NSString * _Nullable)message
                   request:(id _Nullable)request {
    NSString *errorString = nil;
    switch (type) {
        case TranslateErrorTypeParam:
            errorString = @"参数异常";
            break;
        case TranslateErrorTypeNetwork:
            errorString = @"请求异常";
            break;
        case TranslateErrorTypeAPI:
            errorString = @"接口异常";
            break;
        case TranslateErrorTypeUnsupportLanguage:
            errorString = @"不支持的语言";
            break;
        case TranslateErrorTypeDeleted:
            errorString = @"实现接口请求相关代码已删除，如需使用，请自行根据各大服务商开发平台的API文档实现。\n\n实现取词、截图、自动更新、开机自启动、全局快捷键、窗口悬浮、菜单栏图标等等功能的代码都是正常保留的，可在工程中查阅。";
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
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:errorString forKey:NSLocalizedDescriptionKey];
    if (request) {
        [userInfo setObject:request forKey:TranslateErrorRequestKey];
    }
    return [NSError errorWithDomain:@"com.ripperhe.Bob" code:type userInfo:userInfo.copy];
}

@end
