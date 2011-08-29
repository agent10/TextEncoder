//
//  TextEncoderAppDelegate.h
//  TextEncoder
//
//  Created by Kirill Olenyov on 8/27/11.
//  Copyright 2011 House. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TEPasteboardObserver.h"

@interface TextEncoderAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    TEPasteboardObserver *pasteboardObserver;
}

@property (assign) IBOutlet NSWindow *window;

@end
