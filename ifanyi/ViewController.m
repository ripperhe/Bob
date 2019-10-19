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
@property (weak) IBOutlet NSTextField *queryTextField;
@property (weak) IBOutlet NSTextField *resultTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.baiduTranslate = [BaiduTranslate new];

    [[NSNotificationCenter defaultCenter] addObserverForName:@"translate" object:nil queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        [Selection getText:^(NSString * _Nullable text) {
            if (text.length) {
                self.queryTextField.stringValue = text;
                self.resultTextField.stringValue = @"查询中...";
                [self.baiduTranslate queryString:text completion:^(id  _Nonnull result) {
                    NSLog(@"翻译结果\n %@", result);
                    if (result) {
                        self.resultTextField.stringValue = result;
                    }else {
                        self.resultTextField.stringValue = @"查询失败";
                    }
                }];
            }else {
                self.queryTextField.stringValue = @"";
                self.resultTextField.stringValue = @"";
            }
        }];
    }];
    
}


@end
