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
#import "TextView.h"

@interface NormalResultView ()

@property (nonatomic, strong) MASConstraint *scrollViewHeightConstraint;

@end

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
    
    self.scrollView = [NSScrollView mm_make:^(NSScrollView *  _Nonnull scrollView) {
        [self addSubview:scrollView];
        scrollView.hasHorizontalScroller = NO;
        scrollView.hasVerticalScroller = YES;
        scrollView.autohidesScrollers = YES;
        self.textView = [TextView mm_make:^(TextView * _Nonnull textView) {
            textView.editable = NO;
            [textView setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
        }];
        scrollView.documentView = self.textView;
        [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.inset(0);
            make.bottom.inset(26);
            self.scrollViewHeightConstraint = make.height.equalTo(@(100 - 26));
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

- (void)refreshWithStrings:(NSArray<NSString *> *)strings {
    NSString *string = [NSString mm_stringByCombineComponents:strings separatedString:@"\n"];
    self.textView.string = string;
    
    CGFloat textViewWidth = 0;
    if (self.textView.width > 10) {
        textViewWidth = self.textView.width - 2 * self.textView.textContainerInset.width * 2;
    }else {
        CGFloat windowWidth = TranslateWindowController.shared.window.width;
        if (windowWidth <= 0) {
            // 目前 window 的宽度
            windowWidth = 304;
        }
        // 视图间距 + textContainerInset （纵向滚动条宽度15暂时不需要考虑）
        textViewWidth = TranslateWindowController.shared.window.width - 12 * 2 - self.textView.textContainerInset.width * 2;
    }
        
    CGFloat height = [self heightForString:self.textView.attributedString width:textViewWidth];
    height += self.textView.textContainerInset.height * 2;
    // TODO: 有时候高度计算会显示出滚动条，没解决之前先加个10吧
    height += 10;
    
    if (height < 100 - 26) {
        height = 100 - 26;
        // self.scrollView.hasVerticalScroller = NO;
    }else if (height > 500) {
        height = 500;
        // self.scrollView.hasVerticalScroller = YES;
    }else {
        // self.scrollView.hasVerticalScroller = NO;
    }
        
    self.scrollViewHeightConstraint.equalTo(@(height));
}

- (CGFloat)heightForString:(NSAttributedString *)string width:(CGFloat)width {
    // https://stackoverflow.com/questions/2654580/how-to-resize-nstextview-according-to-its-content
    // https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/TextLayout/Tasks/StringHeight.html
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:string];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithContainerSize:NSMakeSize(width, CGFLOAT_MAX)];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    [layoutManager glyphRangeForTextContainer:textContainer];
    return [layoutManager usedRectForTextContainer:textContainer].size.height;
}

@end
