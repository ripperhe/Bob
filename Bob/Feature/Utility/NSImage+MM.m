//
//  NSImage+MM.m
//  Bob
//
//  Created by ripper on 2019/11/29.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "NSImage+MM.h"

@implementation NSImage (MM)

- (BOOL)mm_writeToFileAsPNG:(NSString *)path {
    NSBitmapImageRep *imgRep = [NSBitmapImageRep imageRepWithData:self.TIFFRepresentation];
    NSData *data = [imgRep representationUsingType:NSPNGFileType properties:@{}];
    BOOL result = [data writeToFile:path atomically:NO];
    return result;
}

@end
