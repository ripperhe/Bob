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
#import "Selection.h"
#import "Snip.h"
#import "Configuration.h"
#import <QuartzCore/QuartzCore.h>

@interface TranslateWindowController ()

@property (nonatomic, weak) TranslateViewController *viewController;
@property (nonatomic, assign) BOOL hadShow;

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
        TranslateViewController *viewController = [TranslateViewController new];
        viewController.window = window;
        window.contentViewController = viewController;
        window.movableByWindowBackground = YES;
        window.level = NSModalPanelWindowLevel;
        [self setWindow:window];
        self.viewController = viewController;
    }
    return self;
}

- (void)showAtCenter {
    self.hadShow = YES;
    [self.window orderFrontRegardless];
    [self.window makeMainWindow];
    [self.window makeKeyWindow];
    [self.window center];
}

- (void)showAtMouseLocation {
    self.hadShow = YES;
    NSPoint mouseLocation = [NSEvent mouseLocation];
    NSScreen *screen = [NSScreen.screens mm_find:^BOOL(NSScreen * _Nonnull obj, NSUInteger idx) {
        // 找到鼠标所在屏幕
        return NSPointInRect(mouseLocation, obj.frame);
    }];
    if (!screen) return;
    
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
    [self.window makeKeyWindow];
    [self.window setFrameTopLeftPoint:mouseLocation];
}

- (void)selectionTranslate {
    if (Snip.shared.isSnapshotting) {
        return;
    }
    [self.viewController resetWithState:@"正在取词..."];
    if (!self.hadShow) {
        [self showAtMouseLocation];
    }
    if (!self.window.visible || !Configuration.shared.isPin) {
        [self showAtMouseLocation];
    }
    [Selection getText:^(NSString * _Nullable text) {
        if (text.length) {
            [self.viewController translateText:text];
        }else {
            [self.viewController resetWithState:@"没有获取到文本"];
        }
    }];
}

- (void)snipTranslate {
    if (Snip.shared.isSnapshotting) {
        return;
    }
    if (!Configuration.shared.isPin && self.window.visible) {
        [self close];
        [CATransaction flush];
    }
    [self.viewController resetWithState:@"正在截图..."];
    [Snip.shared startWithCompletion:^(NSImage * _Nullable image) {
        NSLog(@"获取到图片 %@", image);
        if (image) {
            if (!self.hadShow) {
                [self showAtMouseLocation];
            }
            if (!self.window.visible || !Configuration.shared.isPin) {
                [self showAtMouseLocation];
            }
            [self.viewController translateImage:image];
        }
    }];
}

@end
