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
#define kPinKey @"configuration_pin"
#define kFoldKey @"configuration_fold"

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
    NSNumber *from = [NSUserDefaults mm_read:kFromKey];
    if (![from isKindOfClass:[NSNumber class]]) {
        from = @(Language_en);
        [NSUserDefaults mm_write:from forKey:kFromKey];
    }
    self.from = [from integerValue];
    
    NSNumber *to = [NSUserDefaults mm_read:kToKey];
    if (![to isKindOfClass:[NSNumber class]]) {
        to = @(Language_zh);
        [NSUserDefaults mm_write:to forKey:kToKey];
    }
    self.to = [to integerValue];
    
    NSNumber *pin = [NSUserDefaults mm_read:kPinKey];
    if (![pin isKindOfClass:[NSNumber class]]) {
        pin = @NO;
        [NSUserDefaults mm_write:pin forKey:kPinKey];
    }
    self.isPin = [pin boolValue];

    NSNumber *fold = [NSUserDefaults mm_read:kFoldKey];
    if (![fold isKindOfClass:[NSNumber class]]) {
        fold = @YES;
        [NSUserDefaults mm_write:fold forKey:kFoldKey];
    }
    self.isFold = [to boolValue];
}

- (void)setFrom:(Language)from {
    _from = from;
    [NSUserDefaults mm_write:@(from) forKey:kFromKey];
}

- (void)setTo:(Language)to {
    _to = to;
    [NSUserDefaults mm_write:@(to) forKey:kToKey];
}

- (void)setIsPin:(BOOL)isPin {
    _isPin = isPin;
    [NSUserDefaults mm_write:@(isPin) forKey:kPinKey];
}

- (void)setIsFold:(BOOL)isFold {
    _isFold = isFold;
    [NSUserDefaults mm_write:@(isFold) forKey:kFoldKey];
}

@end
