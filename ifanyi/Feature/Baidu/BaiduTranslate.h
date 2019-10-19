//
//  BaiduTranslate.h
//  ifanyi
//
//  Created by ripper on 2019/10/19.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaiduTranslate : NSObject

- (void)queryString:(NSString *)queryString completion:(void (^)(id result))completion;

@end

NS_ASSUME_NONNULL_END
