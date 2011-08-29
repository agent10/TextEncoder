//
//  TEPopoverViewController.h
//  TextEncoder
//
//  Created by Kirill Olenyov on 8/27/11.
//  Copyright 2011 House. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Encoder.h"
#import "TEStatusItem.h"

@interface TEPopoverViewController : NSViewController <NSPopoverDelegate>
{
    IBOutlet id popover;
    IBOutlet id decodedTextField;
    NSStatusItem* statusItem;
    TEStatusItem* TEstatusItem;
    Encoder *encoder;
}

-(NSString*) decode:(NSString*)string;
-(void)showPopover:(NSString*)decodedString;

@end
