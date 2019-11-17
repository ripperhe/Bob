//
//  MMEventMonitor.h
//  ifanyi
//
//  Created by ripper on 2019/11/17.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMEventMonitor : NSObject

@property (nonatomic, assign) NSEventMask mask;
@property (nonatomic, copy) void(^handler)(NSEvent *event);

+ (instancetype)monitorWithEvent:(NSEventMask)mask handler:(void (^)(NSEvent *event))handler;

- (void)start;

- (void)stop;

@end

NS_ASSUME_NONNULL_END
