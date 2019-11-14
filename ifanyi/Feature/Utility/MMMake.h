//
//  MMMake.h
//  ifanyi
//
//  Created by ripper on 2019/11/12.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <AppKit/AppKit.h>

/// 定义make方法
#define DefineMethodMMMake_h(class, obj) \
+ (instancetype)mm_make:(void (^)(class *obj))block; \
- (id)mm_put:(void (^)(class *obj))block;

/// 实现make方法
#define DefineMethodMMMake_m(class) \
+ (instancetype)mm_make:(void (^)(class * _Nonnull))block { \
id obj = [self new]; \
block(obj); \
return obj; \
} \
- (id)mm_put:(void (^)(class * _Nonnull))block { \
block(self); \
return self; \
}

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (MMMake)

/// 初始化一个对象，并在block中作为参数传入
+ (instancetype)mm_make:(void (^)(id obj))block;
/// 同上，用于自定义类型手动修改类型（防止警告）
+ (instancetype)mm_anyMake:(void (^)(id obj))block;

/// 用于传入self到block中进行操作
- (id)mm_put:(void (^)(id obj))block;
/// 同上，用于自定义类型手动修改类型（防止警告）
- (id)mm_anyPut:(void (^)(id obj))block;

@end

@interface NSView (MMMake)

+ (instancetype)mm_make:(void (^)(NSView *view))block;
+ (instancetype)mm_anyMake:(void (^)(id view))block;

- (id)mm_put:(void (^)(NSView *view))block;
- (id)mm_anyPut:(void (^)(id view))block;

@end

@interface NSButton (MMMake)

+ (instancetype)mm_make:(void (^)(NSButton *button))block;
- (id)mm_put:(void (^)(NSButton *button))block;

@end

@interface NSTextField (MMMake)

+ (instancetype)mm_make:(void (^)(NSTextField *textField))block;
- (id)mm_put:(void (^)(NSTextField *textField))block;

@end

@interface NSTextView (MMMake)

+ (instancetype)mm_make:(void (^)(NSTextView *textView))block;
- (id)mm_put:(void (^)(NSTextView *textView))block;

@end

@interface NSScrollView (MMMake)

+ (instancetype)mm_make:(void (^)(NSScrollView *scrollView))block;
- (id)mm_put:(void (^)(NSScrollView *scrollView))block;

@end

@interface NSImageView (MMMake)

+ (instancetype)mm_make:(void (^)(NSImageView *imageView))block;
- (id)mm_put:(void (^)(NSImageView *imageView))block;

@end

NS_ASSUME_NONNULL_END
