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

@property (nonatomic, assign) BOOL isStart;
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
    }];
    
    self.rectView = [NSView mm_make:^(NSView * _Nonnull view) {
        [self.view addSubview:view];
        view.wantsLayer = YES;
        view.layer.backgroundColor = [[NSColor blueColor] colorWithAlphaComponent:0.2].CGColor;
        view.layer.borderColor = [NSColor blueColor].CGColor;
        view.layer.borderWidth = 1;
    }];
}

- (void)viewDidLayout {
    [super viewDidLayout];
    
    // 设置约束竟然有问题，什么毛病？
    self.imageView.frame = self.view.bounds;
}

- (void)updateRectFrame {
    NSRect rect = NSUnionRect(NSMakeRect(self.startPoint.x, self.startPoint.y, 1, 1), NSMakeRect(self.endPoint.x, self.endPoint.y, 1, 1));
    rect = NSIntersectionRect(rect, self.view.window.frame);
    rect = [self.view.window convertRectFromScreen:rect];
    rect = NSIntegralRect(rect);
    self.targetRect = rect;
    self.rectView.frame = rect;
}

#pragma mark -

- (void)mouseDown:(NSEvent *)event {
    NSLog(@"鼠标按下 %@", self.view.window);

    // 双击关闭 用于debug
    if ([event clickCount] >= 2) {
        [[NSApplication sharedApplication] terminate:nil];
        return;
    }
    
    self.isStart = YES;
    self.startPoint = [NSEvent mouseLocation];
    if (self.startBlock) {
        self.startBlock();
    }
}

- (void)mouseDragged:(NSEvent *)event {
    if (!self.isStart) return;
    
    self.endPoint = [NSEvent mouseLocation];
    [self updateRectFrame];
}

- (void)mouseUp:(NSEvent *)event {
    NSLog(@"鼠标起来 %@", self.view.window);
    if (!self.isStart) return;
    self.isStart = NO;
    if (self.targetRect.size.width < 5 || self.targetRect.size.height < 5) {
        if (self.endBlock) {
            self.endBlock(nil);
        }
    }else {
        NSRect targetPixelRect = [self.view.window.screen convertRectToBacking:self.targetRect];
        CGRect rect = NSRectToCGRect(targetPixelRect);
        rect.origin.y = self.image.size.height - rect.origin.y - rect.size.height;
        rect = NSIntegralRect(rect);
        
        @try {
            CGImageRef imageRef = [self.image CGImageForProposedRect:nil context:nil hints:nil];
            CGImageRef newImageRef = CGImageCreateWithImageInRect(imageRef, rect);
            NSImage *newImage = [[NSImage alloc] initWithCGImage:newImageRef size:rect.size];
            CGImageRelease(newImageRef);
            
            // debug一下
//            self.imageView.image = newImage;
//            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"snipImage.png"];
//            [newImage mm_writeToFileAsPNG:path];
//            NSLog(@"图片path:\n%@", path);
            
            if (self.endBlock) {
                self.endBlock(newImage);
            }
        } @catch (NSException *exception) {
            NSLog(@"截取图片异常 %@", exception);
            if (self.endBlock) {
                self.endBlock(nil);
            }
        }
    }
}

@end
