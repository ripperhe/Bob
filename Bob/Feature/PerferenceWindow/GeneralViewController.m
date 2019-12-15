//
//  GeneralViewController.m
//  Bob
//
//  Created by ripper on 2019/12/9.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "GeneralViewController.h"
#import "Shortcut.h"
#import "Configuration.h"

@interface GeneralViewController ()

@property (weak) IBOutlet MASShortcutView *selectionShortcutView;
@property (weak) IBOutlet MASShortcutView *snipShortcutView;
@property (weak) IBOutlet MASShortcutView *inputShortcutView;
@property (weak) IBOutlet NSButton *launchAtStartupButton;

@end

@implementation GeneralViewController

- (instancetype)init {
    return [super initWithNibName:[self className] bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    self.selectionShortcutView.style = MASShortcutViewStyleTexturedRect;
    [self.selectionShortcutView setAssociatedUserDefaultsKey:SelectionShortcutKey];
    
    self.snipShortcutView.style = MASShortcutViewStyleTexturedRect;
    [self.snipShortcutView setAssociatedUserDefaultsKey:SnipShortcutKey];
    
    self.inputShortcutView.style = MASShortcutViewStyleTexturedRect;
    [self.inputShortcutView setAssociatedUserDefaultsKey:InputShortcutKey];

    self.launchAtStartupButton.mm_isOn = Configuration.shared.launchAtStartup;
}

#pragma mark - event

- (IBAction)launchAtStartupButtonClicked:(NSButton *)sender {
    Configuration.shared.launchAtStartup = sender.mm_isOn;
}

#pragma mark - MASPreferencesViewController

- (NSString *)viewIdentifier {
    return self.className;
}

- (NSString *)toolbarItemLabel {
    return @"通用";
}

- (NSImage *)toolbarItemImage {
    return [NSImage imageNamed:@"toolbar_general"];
}

- (BOOL)hasResizableWidth {
    return NO;
}

- (BOOL)hasResizableHeight {
    return NO;
}

@end
