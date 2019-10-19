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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.baiduTranslate = [BaiduTranslate new];
    [self.baiduTranslate queryString:@"During the last macOS upgrade or file migration, some of your files couldn’t be moved to their new locations. This folder contains these files.Configuration filesThese configuration files were modified or customized by you, by another user, or by an app. The modifications are incompatible with the recent macOS upgrade. The modified files are in the Configuration folder, organized in subfolders named for their original locations.To restore any of the custom configurations, compare your modifications with the configuration changes made during the macOS upgrade and combine them when possible.Copyright © 2019 Apple Inc. All rights reserved." completion:^(id  _Nonnull result) {
        NSLog(@"翻译结果\n %@", result);
    }];
}


@end
