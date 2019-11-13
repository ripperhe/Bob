//
//  ViewController.m
//  ifanyi
//
//  Created by ripper on 2019/10/19.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "TranslateViewController.h"
#import "BaiduTranslate.h"
#import "Selection.h"
#import "PopUpButton.h"
#import "QueryView.h"
#import "ResultView.h"

@interface TranslateViewController ()

@property (nonatomic, strong) BaiduTranslate *baiduTranslate;

@property (nonatomic, strong) NSButton *pinButton;
@property (nonatomic, strong) NSButton *foldButton;
@property (nonatomic, strong) QueryView *queryView;
@property (nonatomic, strong) PopUpButton *fromLanguageButton;
@property (nonatomic, strong) NSButton *transformButton;
@property (nonatomic, strong) PopUpButton *toLanguageButton;
@property (nonatomic, strong) ResultView *resultView;

@end

@implementation TranslateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    [self setupTranslate];
}

- (void)setupViews {
    // 可整体拖拽，后期修改
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.view.window.movableByWindowBackground = YES;
    });
    
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = NSColor.whiteColor.CGColor;
    
    self.pinButton = [NSButton mm_make:^(NSButton * button) {
        [self.view addSubview:button];
        button.bordered = NO;
        button.imageScaling = NSImageScaleProportionallyDown;
        button.bezelStyle = NSBezelStyleRegularSquare;
        [button setButtonType:NSButtonTypeToggle];
        button.image = [NSImage imageNamed:@"pin_normal"];
        button.alternateImage = [NSImage imageNamed:@"pin_selected"];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.offset(6);
            make.width.height.mas_equalTo(32);
        }];
        mm_weakify(button)
        [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            mm_strongify(button)
            NSLog(@"点击按钮 %@", button.state == NSControlStateValueOn ? @"ON" : @"OFF");
            return RACSignal.empty;
        }]];
    }];
    
    self.foldButton = [NSButton mm_make:^(NSButton * _Nonnull button) {
        [self.view addSubview:button];
        button.bordered = NO;
        button.imageScaling = NSImageScaleProportionallyDown;
        button.bezelStyle = NSBezelStyleRegularSquare;
        [button setButtonType:NSButtonTypeToggle];
        button.attributedTitle = [NSAttributedString mm_attributedStringWithString:@"展开" font:[NSFont systemFontOfSize:13] color:[NSColor mm_colorWithHexString:@"#007AFF"]];
        button.attributedAlternateTitle = [NSAttributedString mm_attributedStringWithString:@"折叠" font:[NSFont systemFontOfSize:13] color:[NSColor mm_colorWithHexString:@"#007AFF"]];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(6);
            make.right.inset(6);
            make.height.mas_equalTo(32);
            make.width.mas_equalTo(38);
        }];
        mm_weakify(button)
        [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            mm_strongify(button)
            NSLog(@"点击按钮 %@", button.state == NSControlStateValueOn ? @"ON" : @"OFF");
            return RACSignal.empty;
        }]];
    }];
    
    self.queryView = [QueryView mm_anyMake:^(QueryView * _Nonnull view) {
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.inset(12);
            make.top.equalTo(self.pinButton.mas_bottom).offset(2);
            make.height.equalTo(@176);
        }];
        [view setCopyActionBlock:^(QueryView * _Nonnull view) {
            NSLog(@"点击拷贝");
        }];
        [view setAudioActionBlock:^(QueryView * _Nonnull view) {
            NSLog(@"点击音频");
        }];
    }];
    
    self.fromLanguageButton = [PopUpButton mm_anyMake:^(PopUpButton *  _Nonnull button) {
        [self.view addSubview:button];
        button.textField.stringValue = @"英语";
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.queryView.mas_bottom).offset(12);
            make.left.offset(12);
            make.width.mas_equalTo(94);
            make.height.mas_equalTo(25);
        }];
        [button setActionBlock:^(PopUpButton * _Nonnull button) {
            NSLog(@"点击 from");
        }];
    }];
    
    self.transformButton = [NSButton mm_make:^(NSButton * _Nonnull button) {
        [self.view addSubview:button];
        button.bordered = NO;
        button.imageScaling = NSImageScaleProportionallyDown;
        button.bezelStyle = NSBezelStyleRegularSquare;
        [button setButtonType:NSButtonTypeToggle];
        button.image = [NSImage imageNamed:@"transform"];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.fromLanguageButton);
            make.centerX.equalTo(self.queryView);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
        }];
        [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            NSLog(@"点击转换按钮");
            return RACSignal.empty;
        }]];
    }];
    
    self.toLanguageButton = [PopUpButton mm_anyMake:^(PopUpButton *  _Nonnull button) {
        [self.view addSubview:button];
        button.textField.stringValue = @"中文";
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.queryView.mas_bottom).offset(12);
            make.right.inset(12);
            make.width.height.equalTo(self.fromLanguageButton);
        }];
        [button setActionBlock:^(PopUpButton * _Nonnull button) {
            NSLog(@"点击 to");
        }];
    }];
    
    self.resultView = [ResultView mm_anyMake:^(ResultView *  _Nonnull view) {
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fromLanguageButton.mas_bottom).offset(12);
            make.left.right.equalTo(self.queryView);
            make.height.equalTo(@176);
        }];
        [view setAudioActionBlock:^(ResultView * _Nonnull view) {
            NSLog(@"点击音频按钮");
        }];
        [view setCopyActionBlock:^(ResultView * _Nonnull view) {
            NSLog(@"点击复制按钮");
        }];
    }];
}

- (void)setupTranslate {
    self.baiduTranslate = [BaiduTranslate new];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"translate" object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        [Selection getText:^(NSString * _Nullable text) {
            if (text.length) {
                self.queryView.textView.string = text;
                self.resultView.textView.string = @"查询中...";
                [self.baiduTranslate translate:text from:@"en" to:@"zh" completion:^(TranslateResult * _Nullable result, NSError * _Nullable error) {
                    if (error) {
                        self.resultView.textView.string = @"查询失败";
                    }else {
                        self.resultView.textView.string = [NSString mm_stringByCombineComponents:result.normalResults separatedString:@"\n"];
                    }
                }];
            }else {
                self.queryView.textView.string = @"";
                self.queryView.textView.string = @"";
            }
        }];
    }];
}

- (IBAction)xx:(id)sender {
    NSString *text = self.queryView.textView.string;
    self.resultView.textView.string = @"查询中...";
    [self.baiduTranslate translate:text from:@"en" to:@"zh" completion:^(TranslateResult * _Nullable result, NSError * _Nullable error) {
        if (error) {
            self.resultView.textView.string = @"查询失败";
        }else {
            self.resultView.textView.string = [NSString mm_stringByCombineComponents:result.normalResults separatedString:@"\n"];
        }
    }];
}

- (void)updateHeight:(id)sender {
    
    //    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[textView font], NSFontAttributeName, nil];
    //    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:[textView string] attributes:attributes];
    //    CGFloat height = [attributedString boundingRectWithSize:CGSizeMake(self.queryTextView.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin].size.height;
    //    self.queryTextViewHeight.constant = height + 40;
    //    [self.view setNeedsLayout:YES];
}



@end
