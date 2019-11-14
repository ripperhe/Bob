//
//  QueryView.m
//  ifanyi
//
//  Created by ripper on 2019/11/13.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "QueryView.h"

@interface QueryView ()<NSTextViewDelegate>

@end

@implementation QueryView

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.wantsLayer = YES;
    self.layer.backgroundColor = NSColor.whiteColor.CGColor;
    self.layer.borderColor = [NSColor mm_colorWithHexString:@"#EEEEEE"].CGColor;
    self.layer.borderWidth = 1;

    self.scrollView = [NSScrollView mm_make:^(NSScrollView *  _Nonnull scrollView) {
        [self addSubview:scrollView];
        scrollView.wantsLayer = YES;
        scrollView.backgroundColor = NSColor.mm_randomColor;
        scrollView.hasVerticalScroller = YES;
        scrollView.hasHorizontalScroller = NO;
        scrollView.autohidesScrollers = YES;
        self.textView = [NSTextView mm_make:^(NSTextView * _Nonnull textView) {
            // https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Rulers/Concepts/AboutParaStyles.html#//apple_ref/doc/uid/20000879-CJBBEHJA
            [textView setDefaultParagraphStyle:[NSMutableParagraphStyle mm_anyMake:^(NSMutableParagraphStyle *  _Nonnull style) {
                //                    style.lineSpacing = 3;
                style.lineHeightMultiple = 1.2;
                style.paragraphSpacing = 5;
            }]];
            textView.string = @"I believe that in this world, some people have some things and some love. The first time they see it, they are destined to be fettered for a lifetime. They are destined to grow like a tree in their hearts and live for generations.";
            textView.font = [NSFont systemFontOfSize:14];
            textView.textColor = [NSColor mm_colorWithHexString:@"#333333"];
            textView.alignment = NSTextAlignmentJustified;
            textView.textContainerInset  = CGSizeMake(16, 12);
            textView.backgroundColor = NSColor.whiteColor;
            [textView setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
            textView.delegate = self;
        }];
        scrollView.documentView = self.textView;
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.inset(0);
            make.bottom.inset(26);
        }];
    }];
    
    self.audioButton = [NSButton mm_make:^(NSButton * _Nonnull button) {
        [self addSubview:button];
        button.bordered = NO;
        button.imageScaling = NSImageScaleProportionallyDown;
        button.bezelStyle = NSBezelStyleRegularSquare;
        [button setButtonType:NSButtonTypeToggle];
        button.image = [NSImage imageNamed:@"audio"];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(9.5);
            make.bottom.inset(3);
            make.width.height.equalTo(@26);
        }];
        mm_weakify(self)
        [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            mm_strongify(self)
            if (self.audioActionBlock) {
                self.audioActionBlock(self);
            }
            return RACSignal.empty;
        }]];
    }];
    
    self.textCopyButton = [NSButton mm_make:^(NSButton * _Nonnull button) {
        [self addSubview:button];
        button.bordered = NO;
        button.imageScaling = NSImageScaleProportionallyDown;
        button.bezelStyle = NSBezelStyleRegularSquare;
        [button setButtonType:NSButtonTypeToggle];
        button.image = [NSImage imageNamed:@"copy"];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.audioButton.mas_right).offset(1.5);
            make.bottom.equalTo(self.audioButton);
            make.width.height.equalTo(@26);
        }];
        mm_weakify(self)
        [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            mm_strongify(self)
            if (self.copyActionBlock) {
                self.copyActionBlock(self);
            }
            return RACSignal.empty;
        }]];
    }];
    
    // 将scrollview放到最上层
    [self addSubview:self.scrollView];
}

#pragma mark - NSTextViewDelegate

- (BOOL)textView:(NSTextView *)textView doCommandBySelector:(SEL)commandSelector {
    if (commandSelector == @selector(insertNewline:)) {
        NSEventModifierFlags flags = NSApplication.sharedApplication.currentEvent.modifierFlags;
        if(flags & NSEventModifierFlagShift) {
            return NO;
        }else {
            if (self.enterActionBlock) {
                self.enterActionBlock(self);
            }
            return YES;
        }
    }
    return NO;
}

@end
