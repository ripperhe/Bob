//
//  Snip.m
//  Bob
//
//  Created by ripper on 2019/11/27.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "Snip.h"

@interface Snip ()

@property (nonatomic, strong) NSMutableArray<SnipWindowController *> *windowControllers;
@property (nonatomic, copy) void(^completion)(NSImage * _Nullable image);

@end

@implementation Snip

static Snip *_instance;
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
    });
    return _instance;
}

- (NSMutableArray *)windowControllers {
    if (!_windowControllers) {
        _windowControllers = [NSMutableArray array];
    }
    return _windowControllers;
}

- (void)startWithCompletion:(void (^)(NSImage * _Nullable))completion {
    if (self.isSnapshotting) {
        if (completion) {
            self.completion = completion;
        }
        return;
    }
    self.isSnapshotting = YES;
    self.completion = completion;
    
    [self.windowControllers enumerateObjectsUsingBlock:^(SnipWindowController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj close];
    }];
    [self.windowControllers removeAllObjects];

    [NSScreen.screens enumerateObjectsUsingBlock:^(NSScreen * _Nonnull screen, NSUInteger idx, BOOL * _Nonnull stop) {
        SnipWindowController *windowController = [SnipWindowController new];
        [windowController setStartBlock:^(SnipWindowController * _Nonnull windowController) {
            NSLog(@"截图开始");
        }];
        [windowController setEndBlock:^(SnipWindowController * _Nonnull windowController, NSImage * _Nullable image) {
            NSLog(@"截图结束：%@", image ? @"成功" : @"失败");
            // [Snip.shared stop];
            if (self.completion) {
                self.completion(image);
            }
        }];
        [windowController captureWithScreen:screen];
        [self.windowControllers addObject:windowController];
    }];
}

- (void)stop {
    if (!self.isSnapshotting) {
        return;
    }
    self.isSnapshotting = NO;
    self.completion = nil;
    
    [self.windowControllers enumerateObjectsUsingBlock:^(SnipWindowController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj close];
    }];
    [self.windowControllers removeAllObjects];
}

@end
