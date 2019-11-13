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
#import "ZYPopUpButton.h"
#import "ZYQueryView.h"

@interface TranslateViewController ()

@property (nonatomic, strong) BaiduTranslate *baiduTranslate;

@property (nonatomic, strong) NSButton *pinButton;
@property (nonatomic, strong) NSButton *foldButton;

@property (nonatomic, strong) ZYQueryView *queryView;

@property (nonatomic, strong) NSButton *fromLanguageButton;
@property (nonatomic, strong) NSButton *transformButton;
@property (nonatomic, strong) ZYPopUpButton *toLanguageButton;

@property (nonatomic, strong) NSView *resultContainerView;
@property (nonatomic, strong) NSScrollView *resultScrollView;
@property (nonatomic, strong) NSTextView *resultTextView;
@property (nonatomic, strong) NSButton *resultAudioButton;
@property (nonatomic, strong) NSButton *resultCopyButton;

@end

@implementation TranslateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    [self setupTranslate];
    
//    [self.baiduTranslate queryString:@"love" completion:^(id  _Nonnull result) {
//        NSLog(@"result %@", result);
//    }];
    
//    [self.baiduTranslate translate:@"If you tell them this shocking news, I believe that will put the cat among the pigeons. \n\nIf you tell them this shocking news, I believe that will put the cat among the pigeons. " from:@"en" to:@"zh" completion:^(TranslateResult * _Nullable result, NSError * _Nullable error) {
//        NSLog(@"翻译结果 %@", result);
//    }];
}

- (void)setupViews {
    // 可整体拖拽，后期修改
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.view.window.movableByWindowBackground = YES;
    });
    
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = NSColor.whiteColor.CGColor;
    
    self.pinButton = [NSButton zy_make:^(NSButton * button) {
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
        zy_weakify(button)
        [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            zy_strongify(button)
            NSLog(@"点击按钮 %@", button.state == NSControlStateValueOn ? @"ON" : @"OFF");
            return RACSignal.empty;
        }]];
    }];
    
    self.foldButton = [NSButton zy_make:^(NSButton * _Nonnull button) {
        [self.view addSubview:button];
        button.bordered = NO;
        button.imageScaling = NSImageScaleProportionallyDown;
        button.bezelStyle = NSBezelStyleRegularSquare;
        [button setButtonType:NSButtonTypeToggle];
        button.attributedTitle = [NSAttributedString zy_attributedStringWithString:@"展开" font:[NSFont systemFontOfSize:13] color:[NSColor zy_colorWithHexString:@"#007AFF"]];
        button.attributedAlternateTitle = [NSAttributedString zy_attributedStringWithString:@"折叠" font:[NSFont systemFontOfSize:13] color:[NSColor zy_colorWithHexString:@"#007AFF"]];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(6);
            make.right.inset(6);
            make.height.mas_equalTo(32);
            make.width.mas_equalTo(38);
        }];
        zy_weakify(button)
        [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            zy_strongify(button)
            NSLog(@"点击按钮 %@", button.state == NSControlStateValueOn ? @"ON" : @"OFF");
            return RACSignal.empty;
        }]];
    }];
    
    self.queryView = [ZYQueryView zy_anyMake:^(ZYQueryView * _Nonnull view) {
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.inset(12);
            make.top.equalTo(self.pinButton.mas_bottom).offset(2);
            make.height.equalTo(@176);
        }];
        [view setCopyActionBlock:^(ZYQueryView * _Nonnull view) {
            NSLog(@"点击拷贝");
        }];
        [view setAudioActionBlock:^(ZYQueryView * _Nonnull view) {
            NSLog(@"点击音频");
        }];
    }];
    
    self.fromLanguageButton = [ZYPopUpButton zy_anyMake:^(ZYPopUpButton *  _Nonnull button) {
        [self.view addSubview:button];
        button.textField.stringValue = @"英语";
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.queryView.mas_bottom).offset(12);
            make.left.offset(12);
            make.width.mas_equalTo(94);
            make.height.mas_equalTo(25);
        }];
        [button setActionBlock:^(ZYPopUpButton * _Nonnull button) {
            NSLog(@"点击 from");
        }];
    }];
    
    self.transformButton = [NSButton zy_make:^(NSButton * _Nonnull button) {
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
    
    self.toLanguageButton = [ZYPopUpButton zy_anyMake:^(ZYPopUpButton *  _Nonnull button) {
        [self.view addSubview:button];
        button.textField.stringValue = @"中文";
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.queryView.mas_bottom).offset(12);
            make.right.inset(12);
            make.width.height.equalTo(self.fromLanguageButton);
        }];
        [button setActionBlock:^(ZYPopUpButton * _Nonnull button) {
            NSLog(@"点击 to");
        }];
    }];
        
    self.resultContainerView = [NSView zy_make:^(NSView * _Nonnull view) {
        [self.view addSubview:view];
        view.wantsLayer = YES;
        view.layer.backgroundColor = [NSColor zy_colorWithHexString:@"#EEEEEE"].CGColor;
        view.layer.borderColor = [NSColor zy_colorWithHexString:@"#EEEEEE"].CGColor;
        view.layer.borderWidth = 1;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.fromLanguageButton.mas_bottom).offset(12);
            make.left.right.equalTo(self.queryView);
            make.height.equalTo(@176);
        }];
        
        self.resultContainerView = [NSScrollView zy_make:^(NSScrollView *  _Nonnull scrollView) {
            [view addSubview:scrollView];
            scrollView.wantsLayer = YES;
            scrollView.backgroundColor = NSColor.zy_randomColor;
            scrollView.hasVerticalScroller = YES;
            scrollView.hasHorizontalScroller = NO;
            scrollView.autohidesScrollers = YES;
            self.resultTextView = [NSTextView zy_make:^(NSTextView * _Nonnull textView) {
                [textView setDefaultParagraphStyle:[NSMutableParagraphStyle zy_anyMake:^(NSMutableParagraphStyle *  _Nonnull style) {
                    style.lineHeightMultiple = 1.2;
                    style.paragraphSpacing = 5;
                }]];
                textView.string = @"我相信这世界上，有些人有些事有些爱，在见到的第一次，就注定要羁绊一生，就注定像一棵树一样，生长在心里，生生世世。我相信这世界上，有些人有些事有些爱，在见到的第一次，就注定要羁绊一生，就注定像一棵树一样，生长在心里，生生世世。";

                textView.editable = NO;
                textView.font = [NSFont systemFontOfSize:14];
                textView.textColor = [NSColor zy_colorWithHexString:@"#333333"];
                textView.alignment = NSTextAlignmentJustified;
                textView.textContainerInset = CGSizeMake(16, 12);
                textView.backgroundColor = [NSColor zy_colorWithHexString:@"#EEEEEE"];
                [textView setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
            }];
            scrollView.documentView = self.resultTextView;
            [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.inset(0);
                make.bottom.inset(26);
            }];
        }];
        
        self.resultAudioButton = [NSButton zy_make:^(NSButton * _Nonnull button) {
            [view addSubview:button];
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
            [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                NSLog(@"点击音频按钮");
                return RACSignal.empty;
            }]];
        }];
        
        self.resultCopyButton = [NSButton zy_make:^(NSButton * _Nonnull button) {
            [view addSubview:button];
            button.bordered = NO;
            button.imageScaling = NSImageScaleProportionallyDown;
            button.bezelStyle = NSBezelStyleRegularSquare;
            [button setButtonType:NSButtonTypeToggle];
            button.image = [NSImage imageNamed:@"copy"];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.resultAudioButton.mas_right).offset(1.5);
                make.bottom.equalTo(self.resultAudioButton);
                make.width.height.equalTo(@26);
            }];
            [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                NSLog(@"点击拷贝按钮");
                return RACSignal.empty;
            }]];
        }];
        
        // 将scrollview放到最上层
        [view addSubview:self.resultContainerView];
    }];

}


- (void)setupTranslate {
    self.baiduTranslate = [BaiduTranslate new];
    
//    [[NSNotificationCenter defaultCenter] addObserverForName:@"translate" object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
//        [Selection getText:^(NSString * _Nullable text) {
//            if (text.length) {
//                self.queryTextView.string = text;
//                self.resultTextView.string = @"查询中...";
//                [self.baiduTranslate queryString:text completion:^(id  _Nonnull result) {
//                    NSLog(@"翻译结果\n %@", result);
//                    if (result) {
//                        self.resultTextView.string = result;
//                    }else {
//                        self.resultTextView.string = @"查询失败";
//                    }
//                }];
//            }else {
//                self.queryTextView.string = @"";
//                self.resultTextView.string = @"";
//            }
//        }];
//    }];
}

- (void)updateHeight:(id)sender {
    
    //    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[textView font], NSFontAttributeName, nil];
    //    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:[textView string] attributes:attributes];
    //    CGFloat height = [attributedString boundingRectWithSize:CGSizeMake(self.queryTextView.frame.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin].size.height;
    //    self.queryTextViewHeight.constant = height + 40;
    //    [self.view setNeedsLayout:YES];
}



@end
