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

- (void)onStatusBarClicked:(id)sender
{
    [popover setBehavior:NSPopoverBehaviorTransient];
    [popover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMaxYEdge];

}

- (IBAction)decode:(id)sender
{
    Encoder* encoder = [Encoder new];
    NSString* text = [textField stringValue];
    [decodedTextField insertText:[encoder decodeNSString:text]];
}

- (void) awakeFromNib
{
    [textField setStringValue:@"Ïðîäîëæèì?:)"];
    
    NSStatusItem* statusitem = [[[NSStatusBar systemStatusBar]
                                 statusItemWithLength:NSVariableStatusItemLength] retain];
    [statusitem setHighlightMode:YES];
    [statusitem setTitle:@"TE"];
    [statusitem setTarget:self];
    [statusitem setAction:@selector(onStatusBarClicked:)];

}

@end
