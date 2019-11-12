//
//  NSColor+ZY.h
//  ifanyi
//
//  Created by ripper on 2019/11/12.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSColor (ZY)

+ (NSColor *)zy_randomColor;

/** 16进制字符串 e.g. #666666 */
+ (NSColor *)zy_colorWithHexString:(NSString *)hexStr;
+ (NSColor *)zy_colorWithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;

+ (NSColor *)zy_colorWithIntR:(int)r g:(int)g b:(int)b;
+ (NSColor *)zy_colorWithIntR:(int)r g:(int)g b:(int)b alhpa:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
