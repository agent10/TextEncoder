//
//  TEPopoverViewController.m
//  TextEncoder
//
//  Created by Kirill Olenyov on 8/27/11.
//  Copyright 2011 House. All rights reserved.
//

#import "TEPopoverViewController.h"
#import "Encoder.h"
#import "TEStatusItem.h"

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
    
    NSPasteboard *thePasteboard = [NSPasteboard generalPasteboard];
    NSString* stringFromPasteboard = [thePasteboard stringForType:NSPasteboardTypeString];
    if (stringFromPasteboard != NULL && [stringFromPasteboard length] != 0) {
        [textField setStringValue:stringFromPasteboard];
        [self decode:nil];
    }

}

-(void) checkPasteboard:(id)param;
{
    while(1) {
        NSPasteboard *thePasteboard = [NSPasteboard generalPasteboard];
        if([thePasteboard changeCount] != countChangedInPasteboard) {
            countChangedInPasteboard = [thePasteboard changeCount];
            if (statusItem != nil) {
                id sender = [statusItem view];
                [self onStatusBarClicked:sender];
            }
        }
        sleep(1);
    }
}

- (IBAction)decode:(id)sender
{
    Encoder *encoder = [Encoder new];
    NSString* text = [textField stringValue];
    [decodedTextField setString: [encoder decodeNSString:text]];
    [encoder release];
}

- (void) awakeFromNib
{    
    TEStatusItem* view = [[TEStatusItem alloc] initWithFrame:NSMakeRect(0, 0, 24, 24)];
    [view setAction:@selector(onStatusBarClicked:)];
    [view setTarget:self];
    
    statusItem = [[[NSStatusBar systemStatusBar]
                                 statusItemWithLength:NSSquareStatusItemLength] retain];
    [statusItem setHighlightMode:NO];
    [statusItem setView:view];
    
    countChangedInPasteboard =[[NSPasteboard generalPasteboard] changeCount];
    
    [NSThread detachNewThreadSelector:@selector(checkPasteboard:) toTarget:self withObject:nil];

}

@end
