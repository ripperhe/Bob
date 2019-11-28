//
//  SnipViewController.m
//  Bob
//
//  Created by ripper on 2019/11/27.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "SnipViewController.h"

@interface SnipViewController ()

@property (nonatomic, strong) NSImageView *imageView;
@property (nonatomic, strong) NSView *rectView;

@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;
@property (nonatomic, assign) CGRect targetRect;

@end

@implementation SnipViewController

- (void)loadView {
    self.view = [NSView new];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor whiteColor].CGColor;
    
    self.imageView = [NSImageView mm_make:^(NSImageView * _Nonnull imageView) {
        [self.view addSubview:imageView];
        imageView.image = self.image;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.inset(0);
        }];
    }];
    
    self.rectView = [NSView mm_make:^(NSView * _Nonnull view) {
        [self.view addSubview:view];
        view.wantsLayer = YES;
        view.layer.backgroundColor = [[NSColor blueColor] colorWithAlphaComponent:0.2].CGColor;
        view.layer.borderColor = [NSColor blueColor].CGColor;
        view.layer.borderWidth = 1;
    }];
}

- (void)updateRectFrame {
    if (self.startPoint.x == 0 && self.startPoint.y == 0) {
        return;
    }
    if (self.endPoint.x == 0 && self.endPoint.y == 0) {
        return;
    }
    
    NSRect rect = NSUnionRect(NSMakeRect(self.startPoint.x, self.startPoint.y, 1, 1), NSMakeRect(self.endPoint.x, self.endPoint.y, 1, 1));
    rect = NSIntersectionRect(rect, self.view.window.frame);
    rect = [self.view.window convertRectFromScreen:rect];
    self.targetRect = rect;
    self.rectView.frame = rect;
}

#pragma mark -

- (void)mouseDown:(NSEvent *)event {
    NSLog(@"鼠标按下 %@", self.view.window);

    // 双击关闭 用于debug
    if ([event clickCount] >= 2) {
        [[NSApplication sharedApplication] terminate:nil];
    }
    
    self.startPoint = [NSEvent mouseLocation];
    if (self.startBlock) {
        self.startBlock();
    }
}

- (void)mouseDragged:(NSEvent *)event {
//    NSLog(@"鼠标拖拽 %@", self.view.window);
    
    self.endPoint = [NSEvent mouseLocation];
    [self updateRectFrame];
}

- (void)mouseUp:(NSEvent *)event {
    NSLog(@"鼠标起来 %@", self.view.window);
    
    if (self.targetRect.size.width < 5 || self.targetRect.size.height < 5) {
        if (self.endBlock) {
            self.endBlock(nil);
        }
    }else {
//        CGImageRef imageRef = [self.image CGImageForProposedRect:nil context:nil hints:nil];
//        CGRect rect = NSRectToCGRect(self.targetRect);
//        rect.origin.y = self.image.size.height - rect.origin.y - rect.size.height;
//        CGImageRef newImageRef = CGImageCreateWithImageInRect(imageRef, rect);
//        NSImage *newImage = [[NSImage alloc] initWithCGImage:newImageRef size:rect.size];
//        NSLog(@"原始rect:%@ 目标rect:%@ newsize:%@", NSStringFromRect(self.targetRect), NSStringFromRect(rect), NSStringFromSize(newImage.size));
        
        // 这个方式很慢，不过暂时能解决问题，还需要试试
        [self.image lockFocus];
        NSRect rect = NSIntegralRect(self.targetRect);
        NSBitmapImageRep *bitmap = [[NSBitmapImageRep alloc] initWithFocusedViewRect:rect];
        [self.image unlockFocus];
        NSDictionary *imageProps = @{NSImageCompressionFactor:@(1.0)};
        NSData *imageData = [bitmap representationUsingType:NSJPEGFileType properties:imageProps];
        NSImage *newImage = [[NSImage alloc] initWithData:imageData];

        // 设置来debug一下
//        self.imageView.image = newImage;
        
        // 写入文件测试
        NSBitmapImageRep *imgRep = [NSBitmapImageRep imageRepWithData:newImage.TIFFRepresentation];
        NSData *data = [imgRep representationUsingType:NSPNGFileType properties:@{}];
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [documentPath stringByAppendingPathComponent:@"snipImage.png"];
        BOOL result = [data writeToFile:path atomically:NO];
        NSLog(@"图片保存%@\n%@", result ? @"成功" : @"失败", path);

        
        if (self.endBlock) {
            self.endBlock(newImage);
        }
    }
}

- (void)test {
    NSImage *image = [NSImage imageNamed:@"xxxxx"];
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)image.TIFFRepresentation, NULL);
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(imageSourceRef, 0, NULL);
    CGImageRef newImageRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(0, 300, 100, 100));
    NSImage *newImage = [[NSImage alloc] initWithCGImage:newImageRef size:CGSizeMake(100, 100)];
    NSBitmapImageRep *imgRep = [NSBitmapImageRep imageRepWithData:newImage.TIFFRepresentation];
    NSDictionary *imageProps = @{NSImageCompressionFactor : @(1.0)};
    NSData *data = [imgRep representationUsingType: NSJPEGFileType properties: imageProps];
    NSString *downloadPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    BOOL result = [data writeToFile: [downloadPath stringByAppendingPathComponent:@"new_image.jpg"] atomically: NO];
    
//    [image lockFocus];
//    NSBitmapImageRep *bits = [[NSBitmapImageRep alloc] initWithFocusedViewRect:CGRectMake(0, 0, 100, 100)];
//    [image unlockFocus];
//    //再设置后面要用到得 props属性
//    NSDictionary *imageProps = @{NSImageCompressionFactor : @(1.0)};
//
//    //之后 转化为NSData 以便存到文件中
//    NSData *imageData = [bits representationUsingType:NSJPEGFileType properties:imageProps];
////    NSImage *pasteImage = [[NSImage alloc] initWithData:imageData];
//    NSString *downloadPath = [NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, YES) lastObject];
//    [imageData writeToFile: [downloadPath stringByAppendingPathComponent:@"image_xx.jpg"] atomically: NO];
}

@end
