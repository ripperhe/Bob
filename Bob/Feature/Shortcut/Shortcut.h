//
//  Shortcut.h
//  Bob
//
//  Created by ripper on 2019/12/9.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MASShortcut/Shortcut.h>

static NSString *const SelectionShortcutKey = @"SelectionShortcutKey";
static NSString *const SnipShortcutKey = @"SnipShortcutKey";

NS_ASSUME_NONNULL_BEGIN

@interface Shortcut : NSObject

+ (void)setup;

@end

NS_ASSUME_NONNULL_END
