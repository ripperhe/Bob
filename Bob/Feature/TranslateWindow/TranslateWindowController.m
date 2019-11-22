//
//  TranslateWindowController.m
//  Bob
//
//  Created by ripper on 2019/11/17.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "TranslateWindowController.h"
#import "TranslateViewController.h"
#import "TranslateWindow.h"

@interface TranslateWindowController ()

@end

@implementation TranslateWindowController

static TranslateWindowController *_instance;
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

- (instancetype)init {
    if (self = [super init]) {
        NSWindow *window = [[TranslateWindow alloc] initWithContentRect:CGRectZero styleMask: NSWindowStyleMaskClosable | NSWindowStyleMaskResizable backing:NSBackingStoreBuffered defer:YES];
        window.contentViewController = [TranslateViewController new];
        window.movableByWindowBackground = YES;
        window.level = NSModalPanelWindowLevel;
        [self setWindow:window];
    }
    return self;
}

- (void)showAtCenter {
    self.hadShow = YES;
    [self.window orderFrontRegardless];
//    [self.window makeKeyWindow];
    [self.window makeMainWindow];
//    [self.window becomeFirstResponder];
    [self.window center];
}

- (void)showAtMouseLocation {
    self.hadShow = YES;
    [self.window orderFrontRegardless];
    [self.window makeMainWindow];
    [self.window setFrameTopLeftPoint:[NSEvent mouseLocation]];
}

@end
