//
//  TranslateError.h
//  Bob
//
//  Created by ripper on 2019/11/13.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TranslateErrorType) {
    /// 参数异常
    TranslateErrorTypeParamError,
    /// 网络请求异常
    TranslateErrorTypeNetworkError,
    /// 接口异常
    TranslateErrorTypeAPIError,
    /// 不支持的语言
    TranslateErrorTypeUnsupportLanguage,
};

@interface TranslateError : NSObject

+ (NSError *)errorWithType:(TranslateErrorType)type message:(NSString * _Nullable)message;

@end

NS_ASSUME_NONNULL_END
