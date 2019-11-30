//
//  SnipViewController.m
//  Bob
//
//  Created by ripper on 2019/11/27.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "SnipViewController.h"
#import "SnipFocusView.h"

@interface SnipViewController ()

@property (nonatomic, strong) NSImageView *imageView;
@property (nonatomic, strong) NSView *rectView;
@property (nonatomic, strong) SnipFocusView *focusView;

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
        view.layer.backgroundColor = [[NSColor mm_colorWithHexString:@"#007AFF"] colorWithAlphaComponent:0.2].CGColor;
        view.layer.borderColor = [NSColor mm_colorWithHexString:@"#007AFF"].CGColor;
        view.layer.borderWidth = 1;
    }];
    
    self.focusView = [SnipFocusView mm_make:^(SnipFocusView * _Nonnull view) {
        [self.view addSubview:view];
        view.hidden = YES;
        view.frame = CGRectMake(0, 0, view.expectSize.width, view.expectSize.height);
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

- (void)updateFocusFrame {
    if (self.focusView.hidden == YES) {
        return;
    }
    
    NSRect windowFrame = self.window.frame;
    NSPoint mouseLocation = [NSEvent mouseLocation];

    if (mouseLocation.x < windowFrame.origin.x) {
        mouseLocation.x = windowFrame.origin.x;
    }
    if (mouseLocation.x > windowFrame.origin.x + windowFrame.size.width) {
        mouseLocation.x = windowFrame.origin.x + windowFrame.size.width;
    }
    if (mouseLocation.y < windowFrame.origin.y) {
        mouseLocation.y = windowFrame.origin.y;
    }
    if (mouseLocation.y > windowFrame.origin.y + windowFrame.size.height) {
        mouseLocation.y = windowFrame.origin.y + windowFrame.size.height;
    }
    mouseLocation = [self.window convertPointFromScreen:mouseLocation];
    mouseLocation = NSMakePoint(round(mouseLocation.x), round(mouseLocation.y));
    
    NSPoint location = mouseLocation;
    CGSize size = self.focusView.expectSize;
    CGFloat offset = 17;
    
    location.x -= size.width;
    location.y -= size.height;
    
    // 优先考虑鼠标左下角偏移
    location.x -= offset;
    location.y -= offset;
    
    // 底部过低，考虑右上角偏移
    if (location.y < offset) {
        location.y = mouseLocation.y + offset;
        location.x = mouseLocation.x + offset;
    }

    // 太靠左，往右偏移
    if (location.x < offset) {
        location.x = mouseLocation.x + offset;
    }
    
    // 太靠右，往左偏移
    if (location.x > self.view.window.frame.size.width - size.width - offset) {
        location.x = mouseLocation.x - offset - size.width;
    }
    
    NSRect rect = NSMakeRect(location.x, location.y, size.width, size.height);
    rect = NSIntegralRect(rect);
    self.focusView.frame = rect;
    
    // 坐标 尺寸
    self.focusView.locationTextField.stringValue = [NSString stringWithFormat:@"坐标: (%.0f, %.0f)", mouseLocation.x, windowFrame.size.height - mouseLocation.y];
    if (self.isStart) {
        self.focusView.sizeTextFiled.stringValue = [NSString stringWithFormat:@"尺寸: (%.0f, %.0f)", self.targetRect.size.width, self.targetRect.size.height];
    }else {
        self.focusView.sizeTextFiled.stringValue = @"尺寸: (0, 0)";
    }
    
    // 图像
    NSRect locationRect = NSMakeRect(mouseLocation.x - 10, mouseLocation.y - 10, 20, 20);
    NSRect locationPixelRect = [self.view.window.screen convertRectToBacking:locationRect];
    CGRect imageRect = NSRectToCGRect(locationPixelRect);
    imageRect.origin.y = self.image.size.height - imageRect.origin.y - imageRect.size.height;
    imageRect = NSIntegralRect(imageRect);
    CGImageRef imageRef = [self.image CGImageForProposedRect:nil context:nil hints:nil];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(imageRef, imageRect);
    NSImage *newImage = [[NSImage alloc] initWithCGImage:newImageRef size:imageRect.size];
    self.focusView.imageView.image = newImage;
}

#pragma mark -

- (void)showAndUpdateFocusView {
    self.focusView.hidden = NO;
    [self updateFocusFrame];
}

- (void)hiddenFocusView {
    self.focusView.hidden = YES;
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
    self.startPoint = NSMakePoint(round(self.startPoint.x), round(self.startPoint.y));
    if (self.startBlock) {
        self.startBlock();
    }
}

- (void)mouseDragged:(NSEvent *)event {
    NSLog(@"鼠标拖拽 %@", self.view.window);
    if (!self.isStart) return;
    
    self.endPoint = [NSEvent mouseLocation];
    self.endPoint = NSMakePoint(round(self.endPoint.x), round(self.endPoint.y));
    [self updateRectFrame];
    [self updateFocusFrame];
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
//
//            if (self.endBlock) {
//                self.endBlock(newImage);
//            }
        } @catch (NSException *exception) {
            NSLog(@"截取图片异常 %@", exception);
            if (self.endBlock) {
                self.endBlock(nil);
            }
        }
    }
}

@end
