//
//  ResultView.h
//  Bob
//
//  Created by ripper on 2019/11/17.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NormalResultView.h"
#import "WordResultView.h"
#import "TranslateResult.h"

NS_ASSUME_NONNULL_BEGIN

@interface ResultView : NSView

@property (nonatomic, strong) NormalResultView *normalResultView;
@property (nonatomic, strong) WordResultView *wordResultView;
@property (nonatomic, strong) NSTextField *stateTextField;

- (void)refreshWithResult:(TranslateResult *)result;
- (void)refreshWithStateString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
