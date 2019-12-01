//
//  NSImage+MM.m
//  Bob
//
//  Created by ripper on 2019/11/29.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "NSImage+MM.h"

@implementation NSImage (MM)

+ (NSImage *)mm_imageWithSize:(CGSize)size graphicsContext:(void (^NS_NOESCAPE)(CGContextRef ctx))block {
    NSBitmapImageRep *rep = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:NULL
                                                                    pixelsWide:size.width
                                                                    pixelsHigh:size.height
                                                                 bitsPerSample:8
                                                               samplesPerPixel:4
                                                                      hasAlpha:YES
                                                                      isPlanar:NO
                                                                colorSpaceName:NSDeviceRGBColorSpace
                                                                  bitmapFormat:NSAlphaFirstBitmapFormat
                                                                   bytesPerRow:0
                                                                  bitsPerPixel:0];
    
    NSGraphicsContext *g = [NSGraphicsContext graphicsContextWithBitmapImageRep:rep];
    
    [NSGraphicsContext saveGraphicsState];
    [NSGraphicsContext setCurrentContext:g];

    if (@available(macOS 10.14, *)) {
        block(g.CGContext);
    } else {
        block(g.graphicsPort);
    }
    
    [NSGraphicsContext restoreGraphicsState];

    NSImage *newImage = [[NSImage alloc] initWithSize:size];
    [newImage addRepresentation:rep];
    return newImage;
}

- (BOOL)mm_writeToFileAsPNG:(NSString *)path {
    NSBitmapImageRep *imgRep = [NSBitmapImageRep imageRepWithData:self.TIFFRepresentation];
    NSData *data = [imgRep representationUsingType:NSPNGFileType properties:@{}];
    BOOL result = [data writeToFile:path atomically:NO];
    return result;
}

@end
