//
//  PopUpButton.h
//  ifanyi
//
//  Created by ripper on 2019/11/13.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <AppKit/AppKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PopUpButton : NSButton

@property (nonatomic, strong) NSTextField *textField;
@property (nonatomic, strong) NSImageView *imageView;
@property (nonatomic, copy) void(^actionBlock)(PopUpButton *button);

@end

NS_ASSUME_NONNULL_END
