//
//  ZYMake.m
//  ifanyi
//
//  Created by ripper on 2019/11/12.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "ZYMake.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"


@implementation NSObject (ZYMake)

+ (instancetype)zy_make:(void (^)(id _Nonnull))block {
    NSObject *obj = [self new];
    block(obj);
    return obj;
}

+ (instancetype)zy_anyMake:(void (^)(id _Nonnull))block {
    NSObject *obj = [self new];
    block(obj);
    return obj;
}

- (id)zy_put:(void (^)(id _Nonnull))block {
    block(self);
    return self;
}

- (id)zy_anyPut:(void (^)(id _Nonnull))block {
    block(self);
    return self;
}

@end

@implementation NSView (ZYMake)

@end

@implementation NSButton (ZYMake)

@end

@implementation NSTextField (ZYMake)

@end

@implementation NSTextView (ZYMake)

@end

@implementation NSScrollView (ZYMake)

@end

@implementation NSImageView (ZYMake)

@end

#pragma clang diagnostic pop
