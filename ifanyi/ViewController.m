//
//  ViewController.m
//  ifanyi
//
//  Created by ripper on 2019/10/19.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "ViewController.h"
#import "BaiduTranslate.h"
#import "Selection.h"

@interface ViewController ()

@property (nonatomic, strong) BaiduTranslate *baiduTranslate;

@property (nonatomic, strong) NSButton *pinButton;
@property (nonatomic, strong) NSView *queryContainerView;
@property (nonatomic, strong) NSScrollView *queryScrollView;
@property (nonatomic, strong) NSTextView *queryTextView;
@property (nonatomic, strong) NSButton *queryAudioButton;
@property (nonatomic, strong) NSButton *queryCopyButton;
@property (nonatomic, strong) NSView *resultContainerView;
@property (nonatomic, strong) NSScrollView *resultScrollView;
@property (nonatomic, strong) NSTextView *resultTextView;

@end

@implementation ViewController

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
    
    self.pinButton = [NSButton zy_make:^(NSButton * button) {
        [self.view addSubview:button];
        button.bordered = NO;
        button.imageScaling = NSImageScaleProportionallyDown;
        button.bezelStyle = NSBezelStyleRegularSquare;
        [button setButtonType:NSButtonTypeToggle];
        button.image = [NSImage imageNamed:@"xx"];
        button.alternateImage = [NSImage imageNamed:@"oo"];
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
    
    self.queryContainerView = [NSView zy_make:^(NSView * _Nonnull view) {
        [self.view addSubview:view];
        view.wantsLayer = YES;
        view.layer.backgroundColor = NSColor.greenColor.CGColor;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.inset(12);
            make.top.equalTo(self.pinButton.mas_bottom).offset(2);
            make.height.equalTo(@176);
        }];
        
        self.queryScrollView = [NSScrollView zy_make:^(NSScrollView *  _Nonnull scrollView) {
            [view addSubview:scrollView];
            scrollView.wantsLayer = YES;
            scrollView.backgroundColor = NSColor.redColor;
            scrollView.hasVerticalScroller = YES;
            scrollView.hasHorizontalScroller = NO;
            scrollView.autohidesScrollers = YES;
            self.queryTextView = [NSTextView zy_make:^(NSTextView * _Nonnull textView) {
                textView.textContainerInset = CGSizeMake(16, 12);
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
            button.image = [NSImage imageNamed:@"xx"];
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
            button.image = [NSImage imageNamed:@"xx"];
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
