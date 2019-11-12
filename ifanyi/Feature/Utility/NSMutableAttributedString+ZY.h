//
//  NSMutableAttributedString+ZY.h
//  ifanyi
//
//  Created by ripper on 2019/11/12.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (ZY)

+ (NSMutableAttributedString *)zy_mutableAttributedStringWithString:(NSString *)text font:(NSFont *)font color:(NSColor *)color;

- (void)zy_updateWithFont:(nullable NSFont *)font color:(nullable NSColor *)color;
- (void)zy_updateWithFont:(nullable NSFont *)font color:(nullable NSColor *)color range:(NSRange)range;
/** 根据正则表达式更新字符串 e.g. pattern - @"[0-9]+" 设置所有数字 */
- (void)zy_updateWithFont:(nullable NSFont *)font color:(nullable NSColor *)color pattern:(NSString *)pattern;

@end

NS_ASSUME_NONNULL_END
