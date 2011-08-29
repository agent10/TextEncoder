//
//  TEPasteboardObserver.h
//  TextEncoder
//
//  Created by Kirill Olenyov on 8/29/11.
//  Copyright 2011 House. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEPasteboardObserver : NSObject
{
    NSInteger countChangedInPasteboard;
    NSPasteboard *thePasteboard;
    BOOL isStarted;
    NSNotificationCenter* notificationCenter;
}

- (NSString*)getStringFromPasteboard;
- (void)checkPasteboard:(id)param;

@end
