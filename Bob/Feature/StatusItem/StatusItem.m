//
//  StatusItem.m
//  Bob
//
//  Created by ripper on 2019/11/17.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "StatusItem.h"
#import "PreferencesWindowController.h"
#import "TranslateWindowController.h"
#import "Snip.h"
#import "Shortcut.h"

@interface StatusItem ()<NSMenuDelegate>

@property (nonatomic, weak) NSMenuItem *selectionItem;
@property (nonatomic, weak) NSMenuItem *snipItem;

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
    
    NSMenuItem *selectionItem = [[NSMenuItem alloc] initWithTitle:@"划词翻译" action:@selector(translateAction:) keyEquivalent:@""];
    selectionItem.keyEquivalentModifierMask = 0;
    selectionItem.target = self;
    selectionItem.enabled = NO;
    self.selectionItem = selectionItem;
    NSMenuItem *snipItem = [[NSMenuItem alloc] initWithTitle:@"截图翻译" action:@selector(snipAction:) keyEquivalent:@""];
    snipItem.keyEquivalentModifierMask = 0;
    snipItem.target = self;
    self.snipItem = snipItem;
    NSMenuItem *preferenceItem = [[NSMenuItem alloc] initWithTitle:@"偏好设置" action:@selector(preferenceAction:) keyEquivalent:@","];
    preferenceItem.target = self;
    NSMenuItem *quitItem = [[NSMenuItem alloc] initWithTitle:@"退出" action:@selector(quitAction:) keyEquivalent:@"q"];
    quitItem.target = self;
    
    NSMenu *menu = [NSMenu new];
    menu.autoenablesItems = NO;
    menu.delegate = self;
    [menu setItemArray:@[
        selectionItem,
        snipItem,
        [NSMenuItem separatorItem],
        preferenceItem,
        [NSMenuItem separatorItem],
        quitItem]
     ];

    NSStatusItem *item = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    [item.button setToolTip:@"Bob"];
    [item.button setImage:[NSImage imageNamed:@"logo_status"]];
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
    NSLog(@"划词翻译");
    [TranslateWindowController.shared selectionTranslate];
}

- (void)snipAction:(NSMenuItem *)sender {
    NSLog(@"截图翻译");
    [TranslateWindowController.shared snipTranslate];
}

- (void)preferenceAction:(NSMenuItem *)sender {
    NSLog(@"偏好设置");
    [PreferencesWindowController.shared showWindow:nil];
}

- (void)quitAction:(NSMenuItem *)sender {
    NSLog(@"退出应用");
    [NSApplication.sharedApplication terminate:nil];
}

#pragma mark -

- (void)menuWillOpen:(NSMenu *)menu {
    void(^resetItemShortcut)(NSMenuItem *item) = ^(NSMenuItem *item) {
        item.keyEquivalent = @"";
        item.keyEquivalentModifierMask = 0;
    };
    
    @try {
        [Shortcut readShortcutForKey:SelectionShortcutKey completion:^(MASShortcut * _Nullable shorcut) {
            if (shorcut) {
                self.selectionItem.keyEquivalent = shorcut.keyCodeStringForKeyEquivalent;
                self.selectionItem.keyEquivalentModifierMask = shorcut.modifierFlags;
            }else {
                resetItemShortcut(self.selectionItem);
            }
        }];
        [Shortcut readShortcutForKey:SnipShortcutKey completion:^(MASShortcut * _Nullable shorcut) {
            if (shorcut) {
                self.snipItem.keyEquivalent = shorcut.keyCodeStringForKeyEquivalent;
                self.snipItem.keyEquivalentModifierMask = shorcut.modifierFlags;
            }else {
                resetItemShortcut(self.snipItem);
            }
        }];
    } @catch (NSException *exception) {
        resetItemShortcut(self.selectionItem);
        resetItemShortcut(self.snipItem);
    }
}

@end
