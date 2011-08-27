//
//  TEPopoverViewController.m
//  TextEncoder
//
//  Created by Kirill Olenyov on 8/27/11.
//  Copyright 2011 House. All rights reserved.
//

#import "TEPopoverViewController.h"
#import "Encoder.h"

@implementation TEPopoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (IBAction)decode:(id)sender
{
    [popover setBehavior:NSPopoverBehaviorTransient];
    [popover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMaxYEdge];
    Encoder* encoder = [Encoder new];
    NSString* text = [textField stringValue];
    [decodedTextField setStringValue:[encoder decodeNSString:text]];
}

- (void) awakeFromNib
{
    [textField setStringValue:@"Ïðîäîëæèì?:)"];
}

@end
