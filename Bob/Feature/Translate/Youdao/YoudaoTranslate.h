//
//  YoudaoTranslate.h
//  Bob
//
//  Created by ripper on 2019/12/12.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TranslateLanguage.h"
#import "TranslateResult.h"
#import "OCRResult.h"
#import "TranslateError.h"

/**
 * 有道翻译参考链接
 * http://fanyi.youdao.com/
 * http://ai.youdao.com/product-fanyi-text.s
 * http://ai.youdao.com/product-fanyi-picture.s
 * http://ai.youdao.com/DOCSIRMA/html/%E8%87%AA%E7%84%B6%E8%AF%AD%E8%A8%80%E7%BF%BB%E8%AF%91/API%E6%96%87%E6%A1%A3/%E6%96%87%E6%9C%AC%E7%BF%BB%E8%AF%91%E6%9C%8D%E5%8A%A1/%E6%96%87%E6%9C%AC%E7%BF%BB%E8%AF%91%E6%9C%8D%E5%8A%A1-API%E6%96%87%E6%A1%A3.html
 * http://ai.youdao.com/DOCSIRMA/html/%E8%87%AA%E7%84%B6%E8%AF%AD%E8%A8%80%E7%BF%BB%E8%AF%91/API%E6%96%87%E6%A1%A3/%E5%9B%BE%E7%89%87%E7%BF%BB%E8%AF%91%E6%9C%8D%E5%8A%A1/%E5%9B%BE%E7%89%87%E7%BF%BB%E8%AF%91%E6%9C%8D%E5%8A%A1-API%E6%96%87%E6%A1%A3.html
 */

NS_ASSUME_NONNULL_BEGIN

@interface YoudaoTranslate : NSObject

/// 百度翻译首页
- (NSString *)link;

/// 支持的语言
- (NSArray<NSNumber *> *)languages;

/// 翻译
/// @param text 查询文本
/// @param from 文本语言
/// @param to 目标语言
/// @param completion 回调
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


/// 识别图片文本
/// @param image image对象
/// @param from 文本语言
/// @param to 目标语言
/// @param completion 回调
- (void)ocr:(NSImage *)image from:(Language)from to:(Language)to completion:(void (^)(OCRResult * _Nullable result, NSError * _Nullable error))completion;

@end

NS_ASSUME_NONNULL_END
