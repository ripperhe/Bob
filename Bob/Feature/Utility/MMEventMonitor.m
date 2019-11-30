//
//  MMEventMonitor.m
//  Bob
//
//  Created by ripper on 2019/11/17.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "MMEventMonitor.h"

@interface MMEventMonitor ()

@property (nonatomic, assign) BOOL isGlobal;
@property (nonatomic, strong) id monitor;

@end

@implementation MMEventMonitor

+ (instancetype)globalMonitorWithEvent:(NSEventMask)mask handler:(void (^)(NSEvent * _Nonnull))handler {
    MMEventMonitor *monitor = [self new];
    monitor.isGlobal = YES;
    monitor.mask = mask;
    monitor.handler = handler;
    return monitor;
}

+ (instancetype)localMonitorWithEvent:(NSEventMask)mask handler:(void (^)(NSEvent * _Nonnull))handler {
    MMEventMonitor *monitor = [self new];
    monitor.mask = mask;
    monitor.handler = handler;
    return monitor;
}

- (void)start {
    [self stop];
    if (self.isGlobal) {
        self.monitor = [NSEvent addGlobalMonitorForEventsMatchingMask:self.mask handler:self.handler];
    }else {
        mm_weakify(self)
        self.monitor = [NSEvent addLocalMonitorForEventsMatchingMask:self.mask handler:^NSEvent * _Nullable(NSEvent * _Nonnull event) {
            mm_strongify(self);
            self.handler(event);
            return event;
        }];
    }
}

- (void)stop {
    if (self.monitor) {
        [NSEvent removeMonitor:self.monitor];
        self.monitor = nil;
    }
}

@end
