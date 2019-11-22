//
//  OCRResult.h
//  Bob
//
//  Created by ripper on 2019/11/22.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCRResult : NSObject

/// 图片方向
@property (nonatomic, assign) NSInteger direction;
/// 源语言
@property (nonatomic, copy) NSString *from;
/// 目标语言
@property (nonatomic, copy) NSString *to;
/// 翻译结果
@property (nonatomic, strong) NSArray<NSString *> *src;

@end

NS_ASSUME_NONNULL_END
