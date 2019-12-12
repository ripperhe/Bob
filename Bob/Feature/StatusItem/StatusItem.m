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
#import "Configuration.h"

@interface StatusItem ()<NSMenuDelegate>

@property (weak) IBOutlet NSMenu *menu;
@property (nonatomic, weak) IBOutlet NSMenuItem *selectionItem;
@property (nonatomic, weak) IBOutlet NSMenuItem *snipItem;

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
    if (self.statusItem) return;

    NSStatusItem *item = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    [item.button setToolTip:@"Bob"];
    [item.button setImage:[NSImage imageNamed:@"logo_status"]];
    [item.button setImageScaling:NSImageScaleProportionallyUpOrDown];
    [item setMenu:self.menu];
    
    self.statusItem = item;
}

- (void)remove {
    if (self.statusItem) {
        [[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];
        self.statusItem = nil;
    }
}

#pragma mark -
- (IBAction)translateAction:(NSMenuItem *)sender {
    NSLog(@"划词翻译");
    [TranslateWindowController.shared selectionTranslate];
}

- (IBAction)snipAction:(NSMenuItem *)sender {
    NSLog(@"截图翻译");
    [TranslateWindowController.shared snipTranslate];
}

- (IBAction)baiduTranslationWebsite:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://fanyi.baidu.com/"]];
}

- (IBAction)youdaoTranslationWebsite:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://fanyi.youdao.com/"]];
}

- (IBAction)googleCNTranslationWebsite:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://translate.google.cn/"]];
}

- (IBAction)googleTranslationWebsite:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"https://translate.google.com/"]];
}

- (IBAction)preferenceAction:(NSMenuItem *)sender {
    NSLog(@"偏好设置");
    if (Snip.shared.isSnapshotting) {
        [Snip.shared stop];
    }
    if (!Configuration.shared.isPin) {
        [TranslateWindowController.shared close];
    }
    [PreferencesWindowController.shared showWindow:nil];
}

- (IBAction)documentationAction:(NSMenuItem *)sender {
    NSLog(@"使用教程");
}

- (IBAction)exportLogAction:(id)sender {
    NSLog(@"导出日志");
}

- (IBAction)quitAction:(NSMenuItem *)sender {
    NSLog(@"退出应用");
    [NSApplication.sharedApplication terminate:nil];
}

- (IBAction)closeWindowAction:(NSMenuItem *)sender {
    NSLog(@"关闭 Window");
    if (Snip.shared.isSnapshotting) {
        [Snip.shared stop];
    }else {
        [[[NSApplication sharedApplication] keyWindow] close];
    }
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
