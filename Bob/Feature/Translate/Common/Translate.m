//
//  Translate.m
//  Bob
//
//  Created by ripper on 2019/12/13.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "Translate.h"

#define MethodNotImplemented() \
@throw [NSException exceptionWithName:NSInternalInconsistencyException \
reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
userInfo:nil]

@interface Translate ()

@property (nonatomic, strong) NSArray *languages;
@property (nonatomic, strong) NSDictionary<NSNumber *, NSString *> *langStringFromEnumDict;
@property (nonatomic, strong) NSDictionary<NSString *, NSNumber *> *langEnumFromStringDict;
@property (nonatomic, strong) NSDictionary<NSNumber *, NSNumber *> *langIndexDict;

@end

@implementation Translate

- (instancetype)init {
    self = [super init];
    if (self) {
        MMOrderedDictionary *langDict = [self supportLanguagesDictionary];
        self.languages = [langDict sortedKeys];
        self.langStringFromEnumDict = [langDict keysAndObjects];
        self.langEnumFromStringDict = [[langDict keysAndObjects] mm_reverseKeysAndObjectsDictionary];
        self.langIndexDict = [self.languages mm_objectToIndexDictionary];
    }
    return self;
}

#pragma mark -

- (NSArray<NSNumber *> *)languages {
    return _languages;
}

- (NSString *)languageStringFromEnum:(Language)lang {
    return [_langStringFromEnumDict objectForKey:@(lang)];
}

- (Language)languageEnumFromString:(NSString *)langString {
    return [[_langEnumFromStringDict objectForKey:langString] integerValue];
}

- (NSInteger)indexForLanguage:(Language)lang {
    return [[self.langIndexDict objectForKey:@(lang)] integerValue];
}

#pragma mark - 子类重写

- (NSString *)identifier {
    MethodNotImplemented();
    return nil;
}

- (NSString *)name {
    MethodNotImplemented();
    return nil;
}

- (NSString *)link {
    MethodNotImplemented();
    return nil;
}

- (MMOrderedDictionary *)supportLanguagesDictionary {
    MethodNotImplemented();
}

- (void)translate:(NSString *)text from:(Language)from to:(Language)to completion:(void (^)(TranslateResult * _Nullable, NSError * _Nullable))completion {
    MethodNotImplemented();
}

- (void)detect:(NSString *)text completion:(void (^)(Language, NSError * _Nullable))completion {
    MethodNotImplemented();
}

- (void)audio:(NSString *)text from:(Language)from completion:(void (^)(NSString * _Nullable, NSError * _Nullable))completion {
    MethodNotImplemented();
}

- (void)ocr:(NSImage *)image from:(Language)from to:(Language)to completion:(void (^)(OCRResult * _Nullable, NSError * _Nullable))completion {
    MethodNotImplemented();
}

- (void)ocrAndTranslate:(NSImage *)image from:(Language)from to:(Language)to ocrSuccess:(void (^)(OCRResult * _Nonnull, BOOL))ocrSuccess completion:(void (^)(OCRResult * _Nullable, TranslateResult * _Nullable, NSError * _Nullable))completion {
    MethodNotImplemented();
}

@end
