//
//  MMEventMonitor.m
//  Bob
//
//  Created by ripper on 2019/11/17.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "MMEventMonitor.h"

@interface MMEventMonitor ()

@property (nonatomic, strong) id monitor;

@end

@implementation MMEventMonitor

+ (instancetype)monitorWithEvent:(NSEventMask)mask handler:(void (^)(NSEvent * _Nonnull))handler {
    MMEventMonitor *monitor = [self new];
    monitor.mask = mask;
    monitor.handler = handler;
    return monitor;
}

- (void)start {
    [self stop];
    self.monitor = [NSEvent addGlobalMonitorForEventsMatchingMask:self.mask handler:self.handler];
}

- (void)stop {
    if (self.monitor) {
        [NSEvent removeMonitor:self.monitor];
        self.monitor = nil;
    }
}

@end
