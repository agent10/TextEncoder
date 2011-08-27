//
//  TEPopoverViewController.h
//  TextEncoder
//
//  Created by Kirill Olenyov on 8/27/11.
//  Copyright 2011 House. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TEPopoverViewController : NSViewController
{
    IBOutlet id popover;
    IBOutlet id decodedTextField;
    NSInteger countChangedInPasteboard;
    NSStatusItem* statusItem;
}

-(void) decode:(NSString*)string;
-(void) checkPasteboard:(id)param;

@end
