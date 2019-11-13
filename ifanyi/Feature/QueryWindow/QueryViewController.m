//
//  ViewController.m
//  ifanyi
//
//  Created by ripper on 2019/10/19.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "QueryViewController.h"
#import "BaiduTranslate.h"
#import "Selection.h"

@interface QueryViewController ()

@property (nonatomic, strong) BaiduTranslate *baiduTranslate;

@property (nonatomic, strong) NSButton *pinButton;
@property (nonatomic, strong) NSButton *foldButton;

@property (nonatomic, strong) NSView *queryContainerView;
@property (nonatomic, strong) NSScrollView *queryScrollView;
@property (nonatomic, strong) NSTextView *queryTextView;
@property (nonatomic, strong) NSButton *queryAudioButton;
@property (nonatomic, strong) NSButton *queryCopyButton;

@property (nonatomic, strong) NSButton *fromLanguageButton;
@property (nonatomic, strong) NSButton *transformButton;
@property (nonatomic, strong) NSButton *toLanguageButton;

@property (nonatomic, strong) NSView *resultContainerView;
@property (nonatomic, strong) NSScrollView *resultScrollView;
@property (nonatomic, strong) NSTextView *resultTextView;
@property (nonatomic, strong) NSButton *resultAudioButton;
@property (nonatomic, strong) NSButton *resultCopyButton;

@end

@implementation QueryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
    [self setupTranslate];
    
    [self.baiduTranslate queryString:@"love" completion:^(id  _Nonnull result) {
        NSLog(@"result %@", result);
    }];
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
    
    self.queryContainerView = [NSView zy_make:^(NSView * _Nonnull view) {
        [self.view addSubview:view];
        view.wantsLayer = YES;
        view.layer.backgroundColor = NSColor.whiteColor.CGColor;
        view.layer.borderColor = [NSColor zy_colorWithHexString:@"#EEEEEE"].CGColor;
        view.layer.borderWidth = 1;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.inset(12);
            make.top.equalTo(self.pinButton.mas_bottom).offset(2);
            make.height.equalTo(@176);
        }];
        
        self.queryScrollView = [NSScrollView zy_make:^(NSScrollView *  _Nonnull scrollView) {
            [view addSubview:scrollView];
            scrollView.wantsLayer = YES;
            scrollView.backgroundColor = NSColor.zy_randomColor;
            scrollView.hasVerticalScroller = YES;
            scrollView.hasHorizontalScroller = NO;
            scrollView.autohidesScrollers = YES;
            self.queryTextView = [NSTextView zy_make:^(NSTextView * _Nonnull textView) {
                // https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Rulers/Concepts/AboutParaStyles.html#//apple_ref/doc/uid/20000879-CJBBEHJA
                [textView setDefaultParagraphStyle:[NSMutableParagraphStyle zy_anyMake:^(NSMutableParagraphStyle *  _Nonnull style) {
//                    style.lineSpacing = 3;
                    style.lineHeightMultiple = 1.2;
                    style.paragraphSpacing = 5;
                }]];
                textView.string = @"I believe that in this world, some people have some things and some love. The first time they see it, they are destined to be fettered for a lifetime. They are destined to grow like a tree in their hearts and live for generations.";
                textView.font = [NSFont systemFontOfSize:14];
                textView.textColor = [NSColor zy_colorWithHexString:@"#333333"];
                textView.alignment = NSTextAlignmentJustified;
                textView.textContainerInset  = CGSizeMake(16, 12);
                textView.backgroundColor = NSColor.whiteColor;
                [textView setAutoresizingMask:NSViewHeightSizable | NSViewWidthSizable];
            }];
            scrollView.documentView = self.queryTextView;
            [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.inset(0);
                make.bottom.inset(26);
            }];
        }];
        
        self.queryAudioButton = [NSButton zy_make:^(NSButton * _Nonnull button) {
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
        
        self.queryCopyButton = [NSButton zy_make:^(NSButton * _Nonnull button) {
            [view addSubview:button];
            button.bordered = NO;
            button.imageScaling = NSImageScaleProportionallyDown;
            button.bezelStyle = NSBezelStyleRegularSquare;
            [button setButtonType:NSButtonTypeToggle];
            button.image = [NSImage imageNamed:@"copy"];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.queryAudioButton.mas_right).offset(1.5);
                make.bottom.equalTo(self.queryAudioButton);
                make.width.height.equalTo(@26);
            }];
            [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                NSLog(@"点击拷贝按钮");
                return RACSignal.empty;
            }]];
        }];
        
        // 将scrollview放到最上层
        [view addSubview:self.queryScrollView];
    }];
    
    self.fromLanguageButton = [NSButton zy_make:^(NSButton * _Nonnull button) {
        [self.view addSubview:button];
        button.wantsLayer = YES;
        button.layer.backgroundColor = NSColor.zy_randomColor.CGColor;
        button.layer.borderColor = [NSColor zy_colorWithHexString:@"#EEEEEE"].CGColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 2;
        button.bordered = NO;
        button.imageScaling = NSImageScaleProportionallyDown;
        button.bezelStyle = NSBezelStyleRegularSquare;
        [button setButtonType:NSButtonTypeMomentaryPushIn];
        button.title = @"";
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.queryContainerView.mas_bottom).offset(12);
            make.left.offset(12);
            make.width.mas_equalTo(94);
            make.height.mas_equalTo(25);
        }];
        [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            NSLog(@"from language");
            return RACSignal.empty;
        }]];
        
        [NSView zy_make:^(NSView * _Nonnull titleContainerView) {
            [button addSubview:titleContainerView];
            [titleContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.offset(0);
            }];
            
            NSTextField *titleTextField = [NSTextField zy_make:^(NSTextField * _Nonnull textField) {
                [titleContainerView addSubview:textField];
                textField.stringValue = @"英语";
                textField.editable = NO;
                textField.bordered = NO;
                textField.backgroundColor = NSColor.clearColor;
                textField.font = [NSFont systemFontOfSize:12];
                textField.textColor = [NSColor zy_colorWithHexString:@"#333333"];
                [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.bottom.equalTo(titleContainerView);
                }];
            }];
            
            NSImageView *imageView = [NSImageView zy_make:^(NSImageView * _Nonnull imageView) {
                [titleContainerView addSubview:imageView];
                imageView.image = [NSImage imageNamed:@"arrow_down"];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(titleTextField.mas_right).offset(6);
                    make.centerY.equalTo(titleTextField);
                    make.right.equalTo(titleContainerView);
                }];
            }];
            
            ignoreUnusedVariableWarning(imageView)
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
            make.centerX.equalTo(self.queryContainerView);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
        }];
        [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            NSLog(@"点击转换按钮");
            return RACSignal.empty;
        }]];
    }];
    
    self.toLanguageButton = [NSButton zy_make:^(NSButton * _Nonnull button) {
        [self.view addSubview:button];
        button.wantsLayer = YES;
        button.layer.backgroundColor = NSColor.zy_randomColor.CGColor;
        button.layer.borderColor = [NSColor zy_colorWithHexString:@"#EEEEEE"].CGColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 2;
        button.bordered = NO;
        button.imageScaling = NSImageScaleProportionallyDown;
        button.bezelStyle = NSBezelStyleRegularSquare;
        [button setButtonType:NSButtonTypeMomentaryPushIn];
        button.title = @"";
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.queryContainerView.mas_bottom).offset(12);
            make.right.inset(12);
            make.width.height.equalTo(self.fromLanguageButton);
        }];
        [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            NSLog(@"to language");
            return RACSignal.empty;
        }]];
        
        [NSView zy_make:^(NSView * _Nonnull titleContainerView) {
            [button addSubview:titleContainerView];
            [titleContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.offset(0);
            }];
            
            NSTextField *titleTextField = [NSTextField zy_make:^(NSTextField * _Nonnull textField) {
                [titleContainerView addSubview:textField];
                textField.stringValue = @"中文";
                textField.editable = NO;
                textField.bordered = NO;
                textField.backgroundColor = NSColor.clearColor;
                textField.font = [NSFont systemFontOfSize:12];
                textField.textColor = [NSColor zy_colorWithHexString:@"#333333"];
                [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.bottom.equalTo(titleContainerView);
                }];
            }];
            
            NSImageView *imageView = [NSImageView zy_make:^(NSImageView * _Nonnull imageView) {
                [titleContainerView addSubview:imageView];
                imageView.image = [NSImage imageNamed:@"arrow_down"];
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(titleTextField.mas_right).offset(6);
                    make.centerY.equalTo(titleTextField);
                    make.right.equalTo(titleContainerView);
                }];
            }];
            
            ignoreUnusedVariableWarning(imageView)
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
            make.left.right.equalTo(self.queryContainerView);
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
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"translate" object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        [Selection getText:^(NSString * _Nullable text) {
            if (text.length) {
                self.queryTextView.string = text;
                self.resultTextView.string = @"查询中...";
                [self.baiduTranslate queryString:text completion:^(id  _Nonnull result) {
                    NSLog(@"翻译结果\n %@", result);
                    if (result) {
                        self.resultTextView.string = result;
                    }else {
                        self.resultTextView.string = @"查询失败";
                    }
                }];
            }else {
                self.queryTextView.string = @"";
                self.resultTextView.string = @"";
            }
        }];
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
