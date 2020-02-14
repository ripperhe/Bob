//
//  NSString+Additional.m
//
//  Created by Joey.
//  Copyright (c) 2019. All rights reserved.
//

#import "NSString+Additional.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Additional)

- (NSString *)MD5 {
    if(self == nil || [self length] == 0)
        return nil;
    
	const char* str = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(str, (CC_LONG)strlen(str), result);
	
	NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
	for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
		[ret appendFormat:@"%02x",result[i]];
	}
	return ret;
}

@end
