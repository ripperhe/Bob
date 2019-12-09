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

- (void)windowDidLoad {
    [super windowDidLoad];
}

#pragma mark -

- (void)showWindow:(id)sender {
    [NSApp activateIgnoringOtherApps:YES];
    [super showWindow:nil];
    [self.window orderFrontRegardless];
}

@end
