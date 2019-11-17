//
//  ResultView.m
//  ifanyi
//
//  Created by ripper on 2019/11/17.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "ResultView.h"

@implementation ResultView

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.wantsLayer = YES;
        self.layer.backgroundColor = [NSColor mm_colorWithHexString:@"#EEEEEE"].CGColor;
        self.normalResultView = [NormalResultView new];
        self.wordResultView = [WordResultView new];
        self.stateTextField = [[NSTextField wrappingLabelWithString:@""] mm_put:^(NSTextField * _Nonnull textField) {
            [self addSubview:textField];
            textField.font = [NSFont systemFontOfSize:14];
            textField.textColor = [NSColor mm_colorWithHexString:@"#333333"];
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.offset(12);
                make.left.offset(16);
            }];
        }];
    }
    return self;
}

- (void)refreshWithResult:(TranslateResult *)result {
    if (result.wordResult) {
        // 显示word
        self.stateTextField.hidden = YES;
        [self.normalResultView removeFromSuperview];
        self.normalResultView.hidden = YES;
        [self addSubview:self.wordResultView];
        self.wordResultView.hidden = NO;
        [self.wordResultView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.inset(0);
        }];
        [self.wordResultView refreshWithWordResult:result.wordResult];
    }else {
        // 显示普通的
        self.stateTextField.hidden = YES;
        [self.wordResultView removeFromSuperview];
        self.wordResultView.hidden = YES;
        [self addSubview:self.normalResultView];
        self.normalResultView.hidden = NO;
        [self.normalResultView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.inset(0);
        }];
        self.normalResultView.textView.string = [NSString mm_stringByCombineComponents:result.normalResults separatedString:@"\n"];
    }
}

- (void)refreshWithStateString:(NSString *)string {
    [self.normalResultView removeFromSuperview];
    self.normalResultView.hidden = YES;
    [self.wordResultView removeFromSuperview];
    self.wordResultView.hidden = YES;
    self.stateTextField.hidden = NO;
    self.stateTextField.stringValue = string;
}

@end
