//
//  AppDelegate.m
//  ifanyi
//
//  Created by ripper on 2019/10/19.
//  Copyright © 2019 ripperhe. All rights reserved.
//

#import "AppDelegate.h"
#import <Carbon/Carbon.h>

@interface AppDelegate ()

@end

OSStatus GlobalHotKeyHandler(EventHandlerCallRef nextHandler, EventRef theEvent, void *userData) {
    EventHotKeyID hkCom;
    GetEventParameter(theEvent,kEventParamDirectObject,typeEventHotKeyID,NULL,
                      sizeof(hkCom),NULL,&hkCom);
//    int l = hkCom.id;
//    switch (l) {
//        case kVK_ANSI_1: //do something
//            NSLog(@"kVK_ANSI_1按下");
//            break;
//        case kVK_ANSI_2:
//            NSLog(@"kVK_ANSI_2按下");
//            break;
//        case kVK_ANSI_3:
//            NSLog(@"kVK_ANSI_3按下");
//            break;
//    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"translate" object:nil];
    
    return noErr;
}

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [self addGlobalHotKey:kVK_ANSI_D];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)addGlobalHotKey:(NSInteger)keyCode {
    EventHotKeyRef       gMyHotKeyRef;
    EventHotKeyID        gMyHotKeyID;
    EventTypeSpec        eventType;
    eventType.eventClass = kEventClassKeyboard;
    eventType.eventKind = kEventHotKeyPressed;
    InstallApplicationEventHandler(&GlobalHotKeyHandler,1,&eventType,NULL,NULL);
    gMyHotKeyID.signature = 'abcdef';
    gMyHotKeyID.id = keyCode;
//    RegisterEventHotKey(keyCode, 0, gMyHotKeyID, GetApplicationEventTarget(), 0, &gMyHotKeyRef);
//    RegisterEventHotKey(keyCode, cmdKey+optionKey, gMyHotKeyID,GetApplicationEventTarget(), 0, &gMyHotKeyRef);
    RegisterEventHotKey(keyCode, optionKey, gMyHotKeyID,GetApplicationEventTarget(), 0, &gMyHotKeyRef);

}

@end
