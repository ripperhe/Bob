//
//  Configuration.m
//  ifanyi
//
//  Created by ripper on 2019/11/14.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "Configuration.h"

#define kFromKey @"configuration_from"
#define kToKey @"configuration_to"

@implementation Configuration

static Configuration *_instance;
+ (instancetype)shared {
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[self alloc] init];
        });
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
        [_instance setup];
    });
    return _instance;
}

- (void)setup {
    // from
    NSNumber *from = [NSUserDefaults mm_read:kFromKey];
    if (![from isKindOfClass:[NSNumber class]]) {
        from = @(Language_en);
        [NSUserDefaults mm_write:from forKey:kFromKey];
    }
    self.from = [from integerValue];
    // to
    NSNumber *to = [NSUserDefaults mm_read:kToKey];
    if (![to isKindOfClass:[NSNumber class]]) {
        to = @(Language_zh);
        [NSUserDefaults mm_write:to forKey:kToKey];
    }
    self.to = [to integerValue];
}

- (void)setFrom:(Language)from {
    _from = from;
    [NSUserDefaults mm_write:@(from) forKey:kFromKey];
}

- (void)setTo:(Language)to {
    _to = to;
    [NSUserDefaults mm_write:@(to) forKey:kToKey];
}



@end
