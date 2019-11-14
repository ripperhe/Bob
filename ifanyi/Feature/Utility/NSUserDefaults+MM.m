//
//  NSUserDefaults+MM.m
//  ifanyi
//
//  Created by ripper on 2019/11/14.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "NSUserDefaults+MM.h"

@implementation NSUserDefaults (MM)

+ (id)mm_read:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)mm_write:(id)obj forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
