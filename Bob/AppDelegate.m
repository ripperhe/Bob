//
//  AppDelegate.m
//  Bob
//
//  Created by ripper on 2019/11/20.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "AppDelegate.h"
#import "StatusItem.h"
#import "Shortcut.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [StatusItem.shared setup];
    [Shortcut setup];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    [StatusItem.shared remove];
}
@end
