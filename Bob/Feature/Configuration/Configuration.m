//
//  Configuration.m
//  Bob
//
//  Created by ripper on 2019/11/14.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "Configuration.h"
#import <ServiceManagement/ServiceManagement.h>

#define kLaunchAtStartupKey @"configuration_launch_at_startup"
#define kTranslateIdentifierKey @"configuration_translate_identifier"
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
    NSString *translateIdentifier = [NSUserDefaults mm_read:kTranslateIdentifierKey];
    if (![translateIdentifier isKindOfClass:NSString.class]) {
        translateIdentifier = nil;
        [NSUserDefaults mm_write:nil forKey:kTranslateIdentifierKey];
    }
    self.translateIdentifier = translateIdentifier;
    
    NSNumber *from = [NSUserDefaults mm_read:kFromKey];
    if (![from isKindOfClass:[NSNumber class]]) {
        from = @(Language_auto);
        [NSUserDefaults mm_write:from forKey:kFromKey];
    }
    self.from = [from integerValue];
    
    NSNumber *to = [NSUserDefaults mm_read:kToKey];
    if (![to isKindOfClass:[NSNumber class]]) {
        to = @(Language_auto);
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
        fold = @NO;
        [NSUserDefaults mm_write:fold forKey:kFoldKey];
    }
    self.isFold = [fold boolValue];
}

#pragma mark -

- (BOOL)launchAtStartup {
    BOOL launchAtStartup = [[NSUserDefaults mm_read:kLaunchAtStartupKey] boolValue];
    [self updateLoginItemWithLaunchAtStartup:launchAtStartup];
    return launchAtStartup;
}

- (void)setLaunchAtStartup:(BOOL)launchAtStartup {
    [NSUserDefaults mm_write:@(launchAtStartup) forKey:kLaunchAtStartupKey];
    [self updateLoginItemWithLaunchAtStartup:launchAtStartup];
}

- (void)setTranslateIdentifier:(NSString *)translateIdentifier {
    _translateIdentifier = translateIdentifier;
    [NSUserDefaults mm_write:translateIdentifier forKey:kTranslateIdentifierKey];
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

#pragma mark -

- (void)updateLoginItemWithLaunchAtStartup:(BOOL)launchAtStartup {
    // 注册启动项
    // https://nyrra33.com/2019/09/03/cocoa-launch-at-startup-best-practice/
#if DEBUG
    NSString *helper = [NSString stringWithFormat:@"com.ripperhe.BobHelper-debug"];
#else
    NSString *helper = [NSString stringWithFormat:@"com.ripperhe.BobHelper"];
#endif
    SMLoginItemSetEnabled((__bridge CFStringRef)helper, launchAtStartup);
}

@end
