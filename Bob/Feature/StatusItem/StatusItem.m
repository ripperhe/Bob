//
//  StatusItem.m
//  Bob
//
//  Created by ripper on 2019/11/17.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "StatusItem.h"
#import "TranslateWindowController.h"
#import "Snip.h"

@interface StatusItem ()<NSMenuDelegate>

@end

@implementation StatusItem

static StatusItem *_instance;
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

- (void)setup {
    if (self.statusItem) {
        return;
    }
    
    NSMenuItem *translateItem = [[NSMenuItem alloc] initWithTitle:@"翻译" action:@selector(translateAction:) keyEquivalent:@"d"];
    translateItem.keyEquivalentModifierMask = NSEventModifierFlagOption;
    translateItem.target = self;
    NSMenuItem *snipItem = [[NSMenuItem alloc] initWithTitle:@"截图翻译" action:@selector(snipAction:) keyEquivalent:@"s"];
    snipItem.keyEquivalentModifierMask = NSEventModifierFlagOption;
    snipItem.target = self;
    NSMenuItem *preferenceItem = [[NSMenuItem alloc] initWithTitle:@"偏好设置" action:@selector(preferenceAction:) keyEquivalent:@","];
    preferenceItem.target = self;
    NSMenuItem *quitItem = [[NSMenuItem alloc] initWithTitle:@"退出" action:@selector(quitAction:) keyEquivalent:@"q"];
    quitItem.target = self;
    
    NSMenu *menu = [NSMenu new];
    menu.delegate = self;
    [menu setItemArray:@[translateItem, snipItem, [NSMenuItem separatorItem], quitItem]];

    NSStatusItem *item = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    [item.button setToolTip:@"Bob"];
    [item.button setImage:[NSImage imageNamed:@"icon_status"]];
    [item.button setImageScaling:NSImageScaleProportionallyUpOrDown];
    [item setMenu:menu];
    
    self.statusItem = item;
}

- (void)remove {
    if (self.statusItem) {
        [[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];
        self.statusItem = nil;
    }
}

#pragma mark -
- (void)translateAction:(NSMenuItem *)sender {
    NSLog(@"翻译");
    [TranslateWindowController.shared showAtCenter];
}

- (void)snipAction:(NSMenuItem *)sender {
    NSLog(@"截图翻译");
    [TranslateWindowController.shared snipTranslate];
}

- (void)preferenceAction:(NSMenuItem *)sender {
    NSLog(@"偏好设置");
}

- (void)quitAction:(NSMenuItem *)sender {
    NSLog(@"退出应用");
    [NSApplication.sharedApplication terminate:nil];
}

@end
