//
//  ViewController.h
//  Bob
//
//  Created by ripper on 2019/10/19.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TranslateViewController : NSViewController

@property (nonatomic, weak) NSWindow *window;

- (void)resetWithState:(NSString *)stateString;
- (void)translateText:(NSString *)text;
- (void)translateImage:(NSImage *)image;

@end

