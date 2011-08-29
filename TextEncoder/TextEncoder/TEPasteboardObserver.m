//
//  TEPasteboardObserver.m
//  TextEncoder
//
//  Created by Kirill Olenyov on 8/29/11.
//  Copyright 2011 House. All rights reserved.
//

#import "TEPasteboardObserver.h"

@implementation TEPasteboardObserver

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        thePasteboard = [NSPasteboard generalPasteboard];
        countChangedInPasteboard = [thePasteboard changeCount];
        
        notificationCenter = [NSNotificationCenter defaultCenter];

        isStarted = true;
        [NSThread detachNewThreadSelector:@selector(checkPasteboard:) toTarget:self withObject:nil];
    }
    
    return self;
}

- (void)dealloc
{
    isStarted = false;
}

- (NSString*)getStringFromPasteboard
{
    return [thePasteboard stringForType:NSPasteboardTypeString];
}

- (void)checkPasteboard:(id)param;
{
    while(isStarted) {
        if([thePasteboard changeCount] != countChangedInPasteboard) {
            [notificationCenter postNotificationName:@"pasteboardUpdated" object:[self getStringFromPasteboard]];
            countChangedInPasteboard = [thePasteboard changeCount];
        }
        sleep(1);
    }
}
             

@end
