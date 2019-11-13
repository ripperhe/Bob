//
//  MMMake.m
//  ifanyi
//
//  Created by ripper on 2019/11/12.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "MMMake.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"


@implementation NSObject (MMMake)

+ (instancetype)mm_make:(void (^)(id _Nonnull))block {
    NSObject *obj = [self new];
    block(obj);
    return obj;
}

+ (instancetype)mm_anyMake:(void (^)(id _Nonnull))block {
    NSObject *obj = [self new];
    block(obj);
    return obj;
}

- (id)mm_put:(void (^)(id _Nonnull))block {
    block(self);
    return self;
}

- (id)mm_anyPut:(void (^)(id _Nonnull))block {
    block(self);
    return self;
}

@end

@implementation NSView (MMMake)

@end

@implementation NSButton (MMMake)

@end

@implementation NSTextField (MMMake)

@end

@implementation NSTextView (MMMake)

@end

@implementation NSScrollView (MMMake)

@end

@implementation NSImageView (MMMake)

@end

#pragma clang diagnostic pop
