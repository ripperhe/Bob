//
//  NSUserDefaults+MM.h
//  ifanyi
//
//  Created by ripper on 2019/11/14.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSUserDefaults (MM)

+ (id _Nullable)mm_read:(NSString *)key;

+ (void)mm_write:(id _Nullable)obj forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
