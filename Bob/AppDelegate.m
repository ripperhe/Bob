//
//  AppDelegate.m
//  Bob
//
//  Created by ripper on 2019/11/20.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "AppDelegate.h"
#import <Carbon/Carbon.h>
#import "StatusItem.h"
#import "TranslateWindowController.h"
#import "Configuration.h"
#import "Snip.h"

OSStatus GlobalHotKeyHandler(EventHandlerCallRef nextHandler, EventRef theEvent, void *userData) {
    EventHotKeyID hotKeyCom;
    GetEventParameter(theEvent, kEventParamDirectObject, typeEventHotKeyID, NULL, sizeof(hotKeyCom), NULL, &hotKeyCom);
    uint32 hotKeyId = hotKeyCom.id;
    switch (hotKeyId) {
        case kVK_ANSI_D:
            [TranslateWindowController.shared selectionTranslate];
            break;
        case kVK_ANSI_S:
            [TranslateWindowController.shared snipTranslate];
            break;
            
    }
    return noErr;
}

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [self addGlobalHotKey:kVK_ANSI_D];
    [self addGlobalHotKey:kVK_ANSI_S];
    [StatusItem.shared setup];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    [StatusItem.shared remove];
}

- (void)addGlobalHotKey:(uint32)keyCode {
    EventHotKeyRef       gMyHotKeyRef;
    EventHotKeyID        gMyHotKeyID;
    EventTypeSpec        eventType;
    eventType.eventClass = kEventClassKeyboard;
    eventType.eventKind = kEventHotKeyPressed;
    InstallApplicationEventHandler(&GlobalHotKeyHandler,1,&eventType,NULL,NULL);
    gMyHotKeyID.signature = 0;
    gMyHotKeyID.id = keyCode;
    RegisterEventHotKey(keyCode, optionKey, gMyHotKeyID, GetApplicationEventTarget(), 0, &gMyHotKeyRef);
}

@end
