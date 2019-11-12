//
//  ZYMake.h
//  ifanyi
//
//  Created by ripper on 2019/11/12.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZYMake)

/// 初始化一个对象，并在block中作为参数传入
+ (instancetype)zy_make:(void (^)(id obj))block;
/// 同上，用于自定义类型手动修改类型（防止警告）
+ (instancetype)zy_anyMake:(void (^)(id obj))block;

/// 用于传入self到block中进行操作
- (id)zy_put:(void (^)(id obj))block;
/// 同上，用于自定义类型手动修改类型（防止警告）
- (id)zy_anyPut:(void (^)(id obj))block;


@end

@interface NSView (ZYMake)

+ (instancetype)zy_make:(void (^)(NSView *view))block;
+ (instancetype)zy_anyMake:(void (^)(id view))block;

- (id)zy_put:(void (^)(NSView *view))block;
- (id)zy_anyPut:(void (^)(id view))block;

@end

@interface NSButton (ZYMake)

+ (instancetype)zy_make:(void (^)(NSButton *button))block;
- (id)zy_put:(void (^)(NSButton *button))block;

@end

@interface NSTextField (ZYMake)

+ (instancetype)zy_make:(void (^)(NSTextField *textField))block;
- (id)zy_put:(void (^)(NSTextField *textField))block;

@end

@interface NSTextView (ZYMake)

+ (instancetype)zy_make:(void (^)(NSTextView *textView))block;
- (id)zy_put:(void (^)(NSTextView *textView))block;

@end

@interface NSScrollView (ZYMake)

+ (instancetype)zy_make:(void (^)(NSScrollView *scrollView))block;
- (id)zy_put:(void (^)(NSScrollView *scrollView))block;

@end

@interface NSImageView (ZYMake)

+ (instancetype)zy_make:(void (^)(NSImageView *imageView))block;
- (id)zy_put:(void (^)(NSImageView *imageView))block;

@end

NS_ASSUME_NONNULL_END
