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
    NSPoint mouseLocation = [NSEvent mouseLocation];
    __block NSScreen *screen = nil;
    [[NSScreen screens] enumerateObjectsUsingBlock:^(NSScreen * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (NSPointInRect(mouseLocation, obj.frame)) {
            // 找到屏幕
            screen = obj;
            *stop = YES;
        }
    }];
    if (!screen) {
        return;
    }

    self.hadShow = YES;
    
    // 修正显示位置，用于保证window显示在鼠标所在的screen
    // 如果直接使用mouseLocation，可能会显示到其他screen（应该是由当前window在哪个屏幕的区域更多决定的）
    NSRect windowFrame = self.window.frame;
    NSRect visibleFrame = screen.visibleFrame;
    
    if (mouseLocation.x < visibleFrame.origin.x + 10) {
        mouseLocation.x = visibleFrame.origin.x + 10;
    }
    if (mouseLocation.y < visibleFrame.origin.y + windowFrame.size.height + 10) {
        mouseLocation.y = visibleFrame.origin.y + windowFrame.size.height + 10;
    }
    if (mouseLocation.x > visibleFrame.origin.x + visibleFrame.size.width - windowFrame.size.width - 10) {
        mouseLocation.x = visibleFrame.origin.x + visibleFrame.size.width - windowFrame.size.width - 10;
    }
    if (mouseLocation.y > visibleFrame.origin.y + visibleFrame.size.height - 10) {
        mouseLocation.y = visibleFrame.origin.y + visibleFrame.size.height - 10;
    }
    
    [self.window orderFrontRegardless];
    [self.window makeMainWindow];
    [self.window setFrameTopLeftPoint:mouseLocation];
}

@end
