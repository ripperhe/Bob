//
//  OCRResult.h
//  Bob
//
//  Created by ripper on 2019/11/22.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TranslateLanguage.h"

NS_ASSUME_NONNULL_BEGIN

@interface OCRResult : NSObject

/// 源语言
@property (nonatomic, assign) Language from;
/// 目标语言
@property (nonatomic, assign) Language to;
/// 文本识别结果
@property (nonatomic, strong) NSArray<NSString *> *texts;

@end

NS_ASSUME_NONNULL_END
