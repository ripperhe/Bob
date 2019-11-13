//
//  ZYPopUpButton.m
//  ifanyi
//
//  Created by ripper on 2019/11/13.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "ZYPopUpButton.h"

@implementation ZYPopUpButton

- (instancetype)initWithFrame:(NSRect)frameRect {
    if (self = [super initWithFrame:frameRect]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.wantsLayer = YES;
//    self.layer.backgroundColor = NSColor.zy_randomColor.CGColor;
    self.layer.borderColor = [NSColor zy_colorWithHexString:@"#EEEEEE"].CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 2;
    self.bordered = NO;
    self.imageScaling = NSImageScaleProportionallyDown;
    self.bezelStyle = NSBezelStyleRegularSquare;
    [self setButtonType:NSButtonTypeToggle];
    self.title = @"";
    zy_weakify(self)
    [self setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        zy_strongify(self)
        if (self.actionBlock) {
            self.actionBlock(self);
        }
        return RACSignal.empty;
    }]];
    
    [NSView zy_make:^(NSView * _Nonnull titleContainerView) {
        [self addSubview:titleContainerView];
        [titleContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.offset(0);
        }];
        
        self.textField = [NSTextField zy_make:^(NSTextField * _Nonnull textField) {
            [titleContainerView addSubview:textField];
            textField.stringValue = @"xx";
            textField.editable = NO;
            textField.bordered = NO;
            textField.backgroundColor = NSColor.clearColor;
            textField.font = [NSFont systemFontOfSize:12];
            textField.textColor = [NSColor zy_colorWithHexString:@"#333333"];
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.bottom.equalTo(titleContainerView);
            }];
        }];
        
        self.imageView = [NSImageView zy_make:^(NSImageView * _Nonnull imageView) {
            [titleContainerView addSubview:imageView];
            imageView.image = [NSImage imageNamed:@"arrow_down"];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.textField.mas_right).offset(6);
                make.centerY.equalTo(self.textField);
                make.right.equalTo(titleContainerView);
            }];
        }];
    }];
}

@end
