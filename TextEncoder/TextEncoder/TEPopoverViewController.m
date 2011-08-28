//
//  TEPopoverViewController.m
//  TextEncoder
//
//  Created by Kirill Olenyov on 8/27/11.
//  Copyright 2011 House. All rights reserved.
//

#import "TEPopoverViewController.h"

@implementation TEPopoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) dealloc
{
    [encoder release];
    [TEstatusItem release];
    [super dealloc];
}

- (void) autoClosePopover: (NSTimer*)timer
{
    [popover close];
}

- (void)popoverDidShow: (NSNotification*)notification
{
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoClosePopover:) userInfo:nil repeats:NO];
}

- (void)pasteboardUpdated
{
    NSString* stringFromPasteboard = [thePasteboard stringForType:NSPasteboardTypeString];
    if (stringFromPasteboard != NULL && [stringFromPasteboard length] != 0) {
        NSString* decodedString = [self decode:stringFromPasteboard];
        [self showPopover:decodedString];
    }
}

- (void)showPopover:(NSString*)decodedString
{
    if(![popover isShown]) {
        if (statusItem != nil) {
            id sender = [statusItem view];
            [decodedTextField setString: decodedString];
            [popover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMaxYEdge];
        }
    }
}

- (void) checkPasteboard:(id)param;
{
    while(1) {
        if([thePasteboard changeCount] != countChangedInPasteboard) {
            countChangedInPasteboard = [thePasteboard changeCount];
            [self pasteboardUpdated];
        }
        sleep(1);
    }
}

- (NSString*)decode:(NSString*)string
{
    return [encoder decodeNSString:string checkCP1251:NO];
}

- (void) awakeFromNib
{        
    encoder = [Encoder new];
    
    [popover setBehavior:NSPopoverBehaviorTransient];
    thePasteboard = [NSPasteboard generalPasteboard];
    
    TEstatusItem = [[TEStatusItem alloc] initWithFrame:NSMakeRect(0, 0, 24, 24)];
    
    statusItem = [[[NSStatusBar systemStatusBar]
                   statusItemWithLength:NSSquareStatusItemLength] retain];
    [statusItem setHighlightMode:NO];
    [statusItem setView:TEstatusItem];
    
    [decodedTextField setFont:[NSFont fontWithName:@"Baskerville" size:15]];
    
    countChangedInPasteboard =[thePasteboard changeCount];
    
    [NSThread detachNewThreadSelector:@selector(checkPasteboard:) toTarget:self withObject:nil];
    
    NSPopover* p = (NSPopover*) popover;
    p.delegate = self;

}

@end
