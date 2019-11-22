//
//  NormalResultView.m
//  Bob
//
//  Created by ripper on 2019/11/13.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "NormalResultView.h"
#import "ImageButton.h"
#import "TranslateWindowController.h"

@implementation NormalResultView

DefineMethodMMMake_m(NormalResultView)

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.wantsLayer = YES;
    self.layer.backgroundColor = [NSColor mm_colorWithHexString:@"#EEEEEE"].CGColor;
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
            [textView setDefaultParagraphStyle:[NSMutableParagraphStyle mm_make:^(NSMutableParagraphStyle *  _Nonnull style) {
                style.lineHeightMultiple = 1.2;
                style.paragraphSpacing = 5;
            }]];
            textView.editable = NO;
            textView.font = [NSFont systemFontOfSize:14];
            textView.textColor = [NSColor mm_colorWithHexString:@"#333333"];
//            textView.alignment = NSTextAlignmentJustified;
            textView.alignment = NSTextAlignmentLeft;
            textView.textContainerInset = CGSizeMake(16, 12);
            textView.backgroundColor = [NSColor mm_colorWithHexString:@"#EEEEEE"];
            [textView setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
        }];
        scrollView.documentView = self.textView;
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.inset(0);
            make.bottom.inset(26);
        }];
    }];
    
    self.audioButton = [ImageButton mm_make:^(ImageButton * _Nonnull button) {
        [self addSubview:button];
        button.bordered = NO;
        button.imageScaling = NSImageScaleProportionallyDown;
        button.bezelStyle = NSBezelStyleRegularSquare;
        [button setButtonType:NSButtonTypeMomentaryChange];
        button.image = [NSImage imageNamed:@"audio"];
        button.toolTip = @"播放音频";
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
    
    self.textCopyButton = [ImageButton mm_make:^(ImageButton * _Nonnull button) {
        [self addSubview:button];
        button.bordered = NO;
        button.imageScaling = NSImageScaleProportionallyDown;
        button.bezelStyle = NSBezelStyleRegularSquare;
        [button setButtonType:NSButtonTypeMomentaryChange];
        button.image = [NSImage imageNamed:@"copy"];
        button.toolTip = @"复制";
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

- (void)refreshWithString:(NSString *)string {
    self.textView.string = string;
    CGFloat width = self.frame.size.width - 16 * 2;
    if (width <= 0) {
        width = 100;
    }
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:self.textView.font, NSFontAttributeName, [NSMutableParagraphStyle mm_make:^(NSMutableParagraphStyle *  _Nonnull style) {
        style.lineHeightMultiple = 1.2;
        style.paragraphSpacing = 5;
    }], NSParagraphStyleAttributeName, nil];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    CGFloat height = [attributedString boundingRectWithSize:CGSizeMake(width, 300) options:NSStringDrawingUsesLineFragmentOrigin].size.height;
    height = height + 2 * 12 + 10;
    if (height < 100 - 26) {
        height = 100 - 26;
    }
    [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.inset(0);
        make.height.equalTo(@(height));
    }];
}

@end
