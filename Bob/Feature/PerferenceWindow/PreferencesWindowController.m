//
//  PreferencesWindowController.m
//  Bob
//
//  Created by ripper on 2019/12/9.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "PreferencesWindowController.h"
#import "GeneralViewController.h"
#import "AboutViewController.h"

@interface PreferencesWindowController ()

@end

@implementation PreferencesWindowController

static PreferencesWindowController *_instance;
+ (instancetype)shared {
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSArray *viewControllers = @[
                [GeneralViewController new],
                [AboutViewController new],
            ];
            _instance = [[self alloc] initWithViewControllers:viewControllers];
        });
    }
    return _instance;
}

#pragma mark -

- (void)show {
    [self.window makeKeyAndOrderFront:nil];
    [self.window center];
    if (!self.window.isKeyWindow) {
        [NSApp activateIgnoringOtherApps:YES];
    }
    // https://stackoverflow.com/questions/5682712/center-programmatically-created-window
    // 设置 `[self.window center]` 无效，设置frame强制居中
    if (self.window.screen) {
        CGPoint center = CGPointMake(NSWidth(self.window.screen.frame) * 0.5, NSHeight(self.window.screen.frame) * 0.7);
        self.window.center = center;
    }
}

@end
