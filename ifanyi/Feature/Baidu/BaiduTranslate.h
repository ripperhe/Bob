//
//  BaiduTranslate.h
//  ifanyi
//
//  Created by ripper on 2019/10/19.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TranslateLanguage.h"
#import "TranslateResult.h"
#import "TranslateError.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaiduTranslate : NSObject


/// 翻译
/// @param text 查询文本
/// @param from 文本语言，可以为空，会自动检测
/// @param to 目标语言
/// @param completion 回调
/// http://api.fanyi.baidu.com/api/trans/product/apidoc#languageList
- (void)translate:(NSString *)text from:(NSString * _Nullable)from to:(NSString * _Nullable)to completion:(void (^)(TranslateResult * _Nullable result, NSError * _Nullable error))completion;


/// 获取文本的语言
/// @param text 文本
/// @param completion 回调
- (void)detect:(NSString *)text completion:(void (^)(NSString * _Nullable language, NSError * _Nullable error))completion;


/// 获取文本的音频的URL地址
/// @param text 文本
/// @param from 文本语言，可以为空，会自动检测
/// @param completion 回调
- (void)audio:(NSString *)text from:(NSString * _Nullable)from completion:(void (^)(NSString * _Nullable url, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
