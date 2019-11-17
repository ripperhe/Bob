//
//  WordResultView.m
//  ifanyi
//
//  Created by ripper on 2019/11/17.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "WordResultView.h"
#import "ImageButton.h"

@interface WordResultView ()

@end

@implementation WordResultView

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.wantsLayer = YES;
        self.layer.backgroundColor = [NSColor mm_colorWithHexString:@"#EEEEEE"].CGColor;
    }
    return self;
}

- (void)refreshWithWordResult:(TranslateWordResult *)wordResult {
    self.wordResult = wordResult;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    __block NSView *lastView = nil;
    
    [wordResult.phonetics enumerateObjectsUsingBlock:^(TranslatePhonetic * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSTextField *nameTextFiled = [NSTextField mm_make:^(NSTextField * _Nonnull textField) {
            [self addSubview:textField];
            textField.stringValue = obj.name;
            textField.textColor = [NSColor mm_colorWithHexString:@"#333333"];
            textField.font = [NSFont systemFontOfSize:13];
            textField.editable = NO;
            textField.bordered = NO;
            textField.backgroundColor = NSColor.clearColor;
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(16);
                if (idx == 0) {
                    make.top.offset(12);
                }else {
                    make.top.equalTo(lastView.mas_bottom);
                }
            }];
        }];
        NSTextField *valueTextField = [NSTextField mm_make:^(NSTextField * _Nonnull textField) {
            [self addSubview:textField];
            textField.stringValue = [NSString stringWithFormat:@"[%@]", obj.value];
            textField.textColor = [NSColor mm_colorWithHexString:@"#333333"];
            textField.font = [NSFont systemFontOfSize:13];
            textField.editable = NO;
            textField.bordered = NO;
            textField.backgroundColor = NSColor.clearColor;
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(nameTextFiled.mas_right).offset(8);
                make.centerY.equalTo(nameTextFiled);
            }];
        }];
        NSButton *audioButton = [ImageButton mm_make:^(ImageButton * _Nonnull button) {
            [self addSubview:button];
            button.bordered = NO;
            button.imageScaling = NSImageScaleProportionallyDown;
            button.bezelStyle = NSBezelStyleRegularSquare;
            [button setButtonType:NSButtonTypeMomentaryChange];
            button.image = [NSImage imageNamed:@"audio"];
            button.toolTip = @"播放音频";
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(valueTextField.mas_right).offset(11);
                make.centerY.equalTo(valueTextField);
                make.width.height.equalTo(@17);
            }];
            mm_weakify(self, obj)
            [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                mm_strongify(self, obj)
                if (self.playAudioBlock) {
                    self.playAudioBlock(self, obj.ttsURI);
                }
                return RACSignal.empty;
            }]];
        }];
        
        lastView = audioButton;
    }];
    
    [wordResult.parts enumerateObjectsUsingBlock:^(TranslatePart * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSTextField *partTextFiled = nil;
        if (obj.part.length) {
            partTextFiled = [NSTextField mm_make:^(NSTextField * _Nonnull textField) {
                [self addSubview:textField];
                textField.stringValue = obj.part;
                textField.textColor = [NSColor mm_colorWithHexString:@"#999999"];
                textField.font = [NSFont systemFontOfSize:13];
                textField.editable = NO;
                textField.bordered = NO;
                textField.backgroundColor = NSColor.clearColor;
                [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.offset(16);
                    if (lastView) {
                        if (idx == 0) {
                            make.top.equalTo(lastView.mas_bottom).offset(10);
                        }else {
                            make.top.equalTo(lastView.mas_bottom);
                        }
                    }else {
                        make.top.offset(12);
                    }
                }];
            }];
        }
        NSTextField *meanTextField = [[NSTextField wrappingLabelWithString:@""] mm_put:^(NSTextField * _Nonnull textField) {
            [self addSubview:textField];
            textField.stringValue = [NSString mm_stringByCombineComponents:obj.means separatedString:@"; "];
            textField.textColor = [NSColor mm_colorWithHexString:@"#333333"];
            textField.font = [NSFont systemFontOfSize:13];
            textField.backgroundColor = NSColor.clearColor;
            textField.alignment = NSTextAlignmentLeft;
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                if (partTextFiled) {
                    make.left.equalTo(partTextFiled.mas_right).offset(8);
                    make.top.equalTo(partTextFiled);
                }else {
                    make.left.offset(16);
                    if (lastView) {
                        if (idx == 0) {
                            make.top.equalTo(lastView.mas_bottom).offset(10);
                        }else {
                            make.top.equalTo(lastView.mas_bottom);
                        }
                    }else {
                        make.top.offset(12);
                    }
                }
                make.right.inset(16).priorityLow();
            }];
        }];
        
        lastView = meanTextField;
    }];
    
    [wordResult.exchanges enumerateObjectsUsingBlock:^(TranslateExchange * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSTextField *nameTextFiled = [NSTextField mm_make:^(NSTextField * _Nonnull textField) {
            [self addSubview:textField];
            textField.stringValue = [NSString stringWithFormat:@"%@: ", obj.name];
            textField.textColor = [NSColor mm_colorWithHexString:@"#333333"];
            textField.font = [NSFont systemFontOfSize:13];
            textField.editable = NO;
            textField.bordered = NO;
            textField.backgroundColor = NSColor.clearColor;
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.offset(16);
                if (lastView) {
                    if (idx == 0) {
                        make.top.equalTo(lastView.mas_bottom).offset(10);
                    }else {
                        make.top.equalTo(lastView.mas_bottom);
                    }
                }else {
                    make.top.offset(12);
                }
            }];
        }];
        
        [obj.words enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSButton *wordButton = [NSButton mm_make:^(NSButton * _Nonnull button) {
                [self addSubview:button];
                button.bordered = NO;
                button.imageScaling = NSImageScaleProportionallyDown;
                button.bezelStyle = NSBezelStyleRegularSquare;
                [button setButtonType:NSButtonTypeMomentaryChange];
                button.attributedTitle = [NSAttributedString mm_attributedStringWithString:obj font:[NSFont systemFontOfSize:13] color:[NSColor mm_colorWithHexString:@"#007AFF"]];
                [button sizeToFit];
                [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    if (idx == 0) {
                        make.left.equalTo(nameTextFiled.mas_right);
                    }else {
                        make.left.equalTo(lastView.mas_right).offset(5);
                    }
                    make.centerY.equalTo(nameTextFiled);
                }];
                mm_weakify(self, obj)
                [button setRac_command:[[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
                    mm_strongify(self, obj)
                    if (self.selectWordBlock) {
                        self.selectWordBlock(self, obj);
                    }
                    return RACSignal.empty;
                }]];
            }];
            
            lastView = wordButton;
        }];
    }];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.greaterThanOrEqualTo(lastView.mas_bottom).offset(12);
    }];
}

@end
