//
//  ViewController.m
//  Bob
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
#import "Configuration.h"
#import <AVFoundation/AVFoundation.h>
#import "ImageButton.h"
#import "TranslateWindowController.h"

#define kMargin 12.0
#define kQueryMinHeight 120.0

@interface TranslateViewController ()

@property (nonatomic, strong) BaiduTranslate *baiduTranslate;
@property (nonatomic, strong) NSArray<NSNumber *> *languages;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) TranslateResult *currentResult;
@property (nonatomic, strong) MMEventMonitor *monitor;

@property (nonatomic, strong) NSButton *pinButton;
@property (nonatomic, strong) NSButton *foldButton;
@property (nonatomic, strong) NSButton *linkButton;
@property (nonatomic, strong) QueryView *queryView;
@property (nonatomic, strong) PopUpButton *fromLanguageButton;
@property (nonatomic, strong) ImageButton *transformButton;
@property (nonatomic, strong) PopUpButton *toLanguageButton;
@property (nonatomic, strong) ResultView *resultView;

@property (nonatomic, assign) CGFloat queryHeightWhenFold;
@property (nonatomic, strong) MASConstraint *queryHeightConstraint;
@property (nonatomic, strong) MASConstraint *resultTopConstraint;

@end

@implementation TranslateViewController

/// 用代码创建 NSViewController 貌似不会自动创建 view，需要手动初始化
- (void)loadView {
    self.view = [NSView new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupMonitor];
    [self setupTranslate];
    [self setupViews];
}

- (void)viewDidAppear {
    [super viewDidAppear];
    
    if (!Configuration.shared.isPin) {
        [self.monitor start];
    }
}

- (void)viewDidDisappear {
    [super viewDidDisappear];
    
    [self.monitor stop];
}

- (void)setupViews {
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
        button.mm_isOn = Configuration.shared.isPin;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.offset(6);
            make.width.height.mas_equalTo(32);
        }];
        mm_weakify(button)
        [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            mm_strongify(button)
            Configuration.shared.isPin = button.mm_isOn;
            if (button.mm_isOn) {
                [self.monitor stop];
            }else {
                [self.monitor start];
            }
            return RACSignal.empty;
        }]];
    }];
    
    self.foldButton = [NSButton mm_make:^(NSButton * _Nonnull button) {
        [self.view addSubview:button];
        button.bordered = NO;
        button.imageScaling = NSImageScaleProportionallyDown;
        button.bezelStyle = NSBezelStyleRegularSquare;
        [button setButtonType:NSButtonTypeToggle];
        button.image = [NSImage imageNamed:@"fold_up"];
        button.alternateImage = [NSImage imageNamed:@"fold_down"];
        button.mm_isOn = Configuration.shared.isFold;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(9);
            make.right.inset(9);
            make.width.height.mas_equalTo(26);
        }];
        mm_weakify(button)
        [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            mm_strongify(button)
            Configuration.shared.isFold = button.mm_isOn;
            [self updateFoldState:button.mm_isOn];
            return RACSignal.empty;
        }]];
    }];
    
    self.linkButton = [NSButton mm_make:^(NSButton * _Nonnull button) {
        [self.view addSubview:button];
        button.bordered = NO;
        button.imageScaling = NSImageScaleProportionallyDown;
        button.bezelStyle = NSBezelStyleRegularSquare;
        [button setButtonType:NSButtonTypeToggle];
        button.image = [NSImage imageNamed:@"link"];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.foldButton);
            make.right.equalTo(self.foldButton.mas_left).inset(8);
            make.width.height.equalTo(self.foldButton);
        }];
        mm_weakify(self)
        [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            mm_strongify(self)
            [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:self.currentResult.link ?: self.baiduTranslate.link]];
            if (!Configuration.shared.isPin) {
                [TranslateWindowController.shared close];
            }
            return RACSignal.empty;
        }]];
    }];

    self.queryView = [QueryView mm_make:^(QueryView * _Nonnull view) {
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.pinButton.mas_bottom).offset(2);
            make.left.right.inset(kMargin);
            self.queryHeightConstraint = make.height.greaterThanOrEqualTo(@(kQueryMinHeight));
        }];
        [view setCopyActionBlock:^(QueryView * _Nonnull view) {
            [[NSPasteboard generalPasteboard] clearContents];
            [[NSPasteboard generalPasteboard] setString:view.textView.string forType:NSPasteboardTypeString];
        }];
        mm_weakify(self)
        [view setAudioActionBlock:^(QueryView * _Nonnull view) {
            mm_strongify(self);
            [self playAudioWithText:view.textView.string lang:Configuration.shared.from];
        }];
        [view setEnterActionBlock:^(QueryView * _Nonnull view) {
            mm_strongify(self);
            if (view.textView.string.length) {
                [self translateText:view.textView.string];
            }
        }];
    }];
    
    self.fromLanguageButton = [PopUpButton mm_make:^(PopUpButton *  _Nonnull button) {
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.queryView.mas_bottom).offset(12);
            make.left.offset(kMargin);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(25);
        }];
        [button updateMenuWithTitleArray:[self.languages mm_map:^id _Nullable(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj integerValue] == Language_auto) {
                return @"自动检测";
            }
            return LanguageDescFromEnum([obj integerValue]);
        }]];
        [button updateWithIndex:[self indexFromLangages:Configuration.shared.from]];
        mm_weakify(self);
        [button setMenuItemSeletedBlock:^(NSInteger index, NSString *title) {
            mm_strongify(self);
            Configuration.shared.from = [[self.languages objectAtIndex:index] integerValue];
        }];
    }];
    
    self.transformButton = [ImageButton mm_make:^(NSButton * _Nonnull button) {
        [self.view addSubview:button];
        button.bordered = NO;
        button.imageScaling = NSImageScaleProportionallyDown;
        button.bezelStyle = NSBezelStyleRegularSquare;
        [button setButtonType:NSButtonTypeToggle];
        button.image = [NSImage imageNamed:@"transform"];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.fromLanguageButton);
            make.left.equalTo(self.fromLanguageButton.mas_right).offset(20);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
        }];
        mm_weakify(self)
        [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            mm_strongify(self)
            Language from = Configuration.shared.from;
            Configuration.shared.from = Configuration.shared.to;
            Configuration.shared.to = from;
            [self.fromLanguageButton updateWithIndex:[self indexFromLangages:Configuration.shared.from]];
            [self.toLanguageButton updateWithIndex:[self indexFromLangages:Configuration.shared.to]];
            return RACSignal.empty;
        }]];
    }];
    
    self.toLanguageButton = [PopUpButton mm_make:^(PopUpButton *  _Nonnull button) {
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.transformButton.mas_right).offset(20);
            make.centerY.equalTo(self.transformButton);
            make.width.height.equalTo(self.fromLanguageButton);
            make.right.lessThanOrEqualTo(self.view.mas_right).offset(-kMargin);
        }];
        [button updateMenuWithTitleArray:[self.languages mm_map:^id _Nullable(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj integerValue] == Language_auto) {
                return @"自动选择";
            }
            return LanguageDescFromEnum([obj integerValue]);
        }]];
        [button updateWithIndex:[self indexFromLangages:Configuration.shared.to]];
        mm_weakify(self);
        [button setMenuItemSeletedBlock:^(NSInteger index, NSString *title) {
            mm_strongify(self);
            Configuration.shared.to = [[self.languages objectAtIndex:index] integerValue];
        }];
    }];
    
    self.resultView = [ResultView mm_anyMake:^(ResultView *  _Nonnull view) {
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if (Configuration.shared.isFold) {
                self.resultTopConstraint = make.top.equalTo(self.pinButton.mas_bottom).offset(2);
            }else {
                self.resultTopConstraint = make.top.equalTo(self.fromLanguageButton.mas_bottom).offset(12);
            }
            make.left.right.equalTo(self.queryView);
            make.bottom.inset(kMargin);
            make.height.greaterThanOrEqualTo(@(100));
        }];
        mm_weakify(self)
        [view.normalResultView setAudioActionBlock:^(NormalResultView * _Nonnull view) {
            mm_strongify(self);
            if (!self.currentResult) return;
            [self playAudioWithText:view.textView.string lang:self.currentResult.to];
        }];
        [view.normalResultView setCopyActionBlock:^(NormalResultView * _Nonnull view) {
            mm_strongify(self);
            if (!self.currentResult) return;
            [[NSPasteboard generalPasteboard] clearContents];
            [[NSPasteboard generalPasteboard] setString:view.textView.string forType:NSPasteboardTypeString];
        }];
        [view.wordResultView setPlayAudioBlock:^(WordResultView * _Nonnull view, NSString * _Nonnull url) {
            mm_strongify(self);
            [self playAudioWithURL:url];
        }];
        [view.wordResultView setSelectWordBlock:^(WordResultView * _Nonnull view, NSString * _Nonnull word) {
            mm_strongify(self);
            [self translateText:word];
            [[NSPasteboard generalPasteboard] clearContents];
            [[NSPasteboard generalPasteboard] setString:word forType:NSPasteboardTypeString];
        }];
    }];
    
    [self updateFoldState:Configuration.shared.isFold];
}

- (void)setupTranslate {
    self.baiduTranslate = [BaiduTranslate new];
    self.languages = @[
        @(Language_auto),
        @(Language_zh),
        @(Language_cht),
        @(Language_en),
        @(Language_yue),
        @(Language_wyw),
        @(Language_jp),
        @(Language_kor),
        @(Language_fra),
        @(Language_spa),
        @(Language_th),
        @(Language_ara),
        @(Language_ru),
        @(Language_pt),
        @(Language_de),
        @(Language_it),
        @(Language_el),
        @(Language_nl),
        @(Language_pl),
        @(Language_bul),
        @(Language_est),
        @(Language_dan),
        @(Language_fin),
        @(Language_cs),
        @(Language_rom),
        @(Language_slo),
        @(Language_swe),
        @(Language_hu),
        @(Language_vie),
    ];
    self.player = [[AVPlayer alloc] init];
}

- (void)setupMonitor {
    mm_weakify(self)
    self.monitor = [MMEventMonitor globalMonitorWithEvent:NSEventMaskLeftMouseDown | NSEventMaskRightMouseDown handler:^(NSEvent * _Nonnull event) {
        mm_strongify(self);
        if (!Configuration.shared.isPin) {
            // 关闭视图
            [TranslateWindowController.shared close];
            [self.monitor stop];
        }
    }];
}

#pragma mark -

- (NSInteger)indexFromLangages:(Language)lang {
    return [self.languages mm_find:^BOOL(NSNumber * _Nonnull obj, NSUInteger idx) {
        return obj.integerValue == lang;
    }].integerValue;
}

- (void)playAudioWithText:(NSString *)text lang:(Language)lang {
    if (text.length) {
        mm_weakify(self)
        [self.baiduTranslate audio:text from:lang completion:^(NSString * _Nullable url, NSError * _Nullable error) {
            mm_strongify(self);
            if (!error) {
                [self playAudioWithURL:url];
            }
        }];
    }
}

- (void)playAudioWithURL:(NSString *)url {
    [self.player pause];
    [self.player replaceCurrentItemWithPlayerItem:[AVPlayerItem playerItemWithURL:[NSURL URLWithString:url]]];
    [self.player play];
}

#pragma mark -

- (void)resetWithState:(NSString *)stateString {
    self.currentResult = nil;
    self.queryView.textView.string = @"";
    [self.resultView refreshWithStateString:stateString];
    [self resizeWindowWithQueryViewExpectHeight:0];
}

- (void)translateText:(NSString *)text {
    self.currentResult = nil;
    self.queryView.textView.string = text;
    [self.resultView refreshWithStateString:@"翻译中..."];
    [self resizeWindowWithQueryViewExpectHeight:0];
    mm_weakify(self)
    [self.baiduTranslate translate:text
                              from:Configuration.shared.from
                                to:Configuration.shared.to
                        completion:^(TranslateResult * _Nullable result, NSError * _Nullable error) {
        mm_strongify(self);
        if (error) {
            [self.resultView refreshWithStateString:error.localizedDescription];
        }else {
            self.currentResult = result;
            [self.resultView refreshWithResult:result];
        }
        mm_weakify(self)
        dispatch_async(dispatch_get_main_queue(), ^{
            mm_strongify(self);
            [self moveWindowToScreen];
            [self resetQueryViewHeightConstraint];
        });
    }];
}

- (void)translateImage:(NSImage *)image {
    [self resetWithState:@"图片文本识别中..."];
    mm_weakify(self)
    [self.baiduTranslate ocr:image
                        from:Configuration.shared.from
                          to:Configuration.shared.to
                  completion:^(OCRResult * _Nullable result, NSError * _Nullable error) {
        mm_strongify(self)
        NSLog(@"识别到的文本:\n%@", result.texts);
        if (error) {
            [self.resultView refreshWithStateString:error.localizedDescription];
        }else {
            [self translateText:[NSString mm_stringByCombineComponents:result.texts separatedString:@" "]];
        }
    }];
}

#pragma mark - window frame

- (void)resetQueryViewHeightConstraint {
    self.queryHeightConstraint.greaterThanOrEqualTo(@(kQueryMinHeight));
}

- (void)updateFoldState:(BOOL)isFold {
    if (isFold) {
        self.queryHeightWhenFold = self.queryView.frame.size.height;
    }
    self.queryView.hidden = isFold;
    self.fromLanguageButton.hidden = isFold;
    self.transformButton.hidden = isFold;
    self.toLanguageButton.hidden = isFold;
    [self.resultTopConstraint uninstall];
    [self.resultView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (isFold) {
            self.resultTopConstraint = make.top.equalTo(self.pinButton.mas_bottom).offset(2);
        }else {
            self.resultTopConstraint = make.top.equalTo(self.fromLanguageButton.mas_bottom).offset(12);
        }
    }];
    [self resizeWindowWithQueryViewExpectHeight:self.queryHeightWhenFold];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self resetQueryViewHeightConstraint];
    });
}

// 保证 result size 达到最小
- (void)resizeWindowWithQueryViewExpectHeight:(CGFloat)expectHeight {
    NSPoint topLeft = self.window.topLeft;
    CGFloat height = expectHeight > 0 ? expectHeight : self.queryView.frame.size.height;
    self.queryHeightConstraint.greaterThanOrEqualTo(@(height > kQueryMinHeight ? height : kQueryMinHeight));
    [self.window setContentSize:CGSizeMake(self.window.frame.size.width, 0)];
    [self.window setTopLeft:topLeft];
    // 等待合适的时机重置查询视图最小高度
}

- (void)moveWindowToScreen {
    NSRect windowFrame = self.window.frame;
    NSRect visibleFrame = self.window.screen.visibleFrame;
    if (windowFrame.origin.y < visibleFrame.origin.y + 10) {
        windowFrame.origin.y = visibleFrame.origin.y + 10;
    }
    if (windowFrame.origin.x > visibleFrame.origin.x + visibleFrame.size.width - windowFrame.size.width - 10) {
        windowFrame.origin.x = visibleFrame.origin.x + visibleFrame.size.width - windowFrame.size.width - 10;
    }
    if (!NSEqualRects(self.window.frame, windowFrame)) {
        [self.window setFrame:windowFrame display:YES animate:YES];
    }
}

@end
