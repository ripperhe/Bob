//
//  TranslateWindow.m
//  Bob
//
//  Created by ripper on 2019/11/17.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "TranslateWindow.h"

@implementation TranslateWindow

// https://stackoverflow.com/questions/8115811/xcode-4-cocoa-title-bar-removing-from-interface-builders-disables-textview-from
// https://stackoverflow.com/questions/17779603/subviews-become-disabled-when-title-bar-is-hidden?rq=1

- (BOOL)canBecomeKeyWindow {
    return YES;
}

- (BOOL)canBecomeMainWindow {
    return YES;
}

@end
