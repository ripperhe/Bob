//
//  BaiduTranslate.h
//  Bob
//
//  Created by ripper on 2019/10/19.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TranslateLanguage.h"
#import "TranslateResult.h"
#import "TranslateError.h"
#import "OCRResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaiduTranslate : NSObject

/// 翻译
/// @param text 查询文本
/// @param from 文本语言
/// @param to 目标语言
/// @param completion 回调
/// http://api.fanyi.baidu.com/api/trans/product/apidoc#languageList
- (void)translate:(NSString *)text from:(Language)from to:(Language)to completion:(void (^)(TranslateResult * _Nullable result, NSError * _Nullable error))completion;


/// 获取文本的语言
/// @param text 文本
/// @param completion 回调
- (void)detect:(NSString *)text completion:(void (^)(Language lang, NSError * _Nullable error))completion;


/// 获取文本的音频的URL地址
/// @param text 文本
/// @param from 文本语言
/// @param completion 回调
- (void)audio:(NSString *)text from:(Language)from completion:(void (^)(NSString * _Nullable url, NSError * _Nullable error))completion;


/// 图片识别文本
/// @param image image对象
/// @param type 图片类型
/// @param from 文本语言
/// @param to 目标语言
/// @param completion 回调
- (void)ocr:(NSImage *)image type:(NSBitmapImageFileType)type from:(Language)from to:(Language)to completion:(void (^)(OCRResult * _Nullable result, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
