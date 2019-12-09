//
//  Shortcut.m
//  Bob
//
//  Created by ripper on 2019/12/9.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "Shortcut.h"
#import "TranslateWindowController.h"

@implementation Shortcut

+ (void)setup {
    // Most apps need default shortcut, delete these lines if this is not your case
    MASShortcut *selectionShortcut = [MASShortcut shortcutWithKeyCode:kVK_ANSI_D modifierFlags:NSEventModifierFlagOption];
    NSData *selectionShortcutData = [NSKeyedArchiver archivedDataWithRootObject:selectionShortcut];
    MASShortcut *snipShortcut = [MASShortcut shortcutWithKeyCode:kVK_ANSI_S modifierFlags:NSEventModifierFlagOption];
    NSData *snipShortcutData = [NSKeyedArchiver archivedDataWithRootObject:snipShortcut];


    // Register default values to be used for the first app start
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{
        SelectionShortcutKey : selectionShortcutData,
        SnipShortcutKey : snipShortcutData,
    }];
    
    [[MASShortcutBinder sharedBinder] bindShortcutWithDefaultsKey:SelectionShortcutKey toAction:^{
        [TranslateWindowController.shared selectionTranslate];
    }];
    
    [[MASShortcutBinder sharedBinder] bindShortcutWithDefaultsKey:SnipShortcutKey toAction:^{
        [TranslateWindowController.shared snipTranslate];
    }];
    
    [[MASShortcutValidator sharedValidator] setAllowAnyShortcutWithOptionModifier:YES];
}

@end
