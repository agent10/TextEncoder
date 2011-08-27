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

- (void) autoClosePopover: (NSTimer*)timer
{
    [popover close];
}

- (void)popoverDidShow: (NSNotification*)notification
{
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(autoClosePopover:) userInfo:nil repeats:NO];
}

- (void)onStatusBarClicked:(id)sender
{
    [popover setBehavior:NSPopoverBehaviorTransient];
    [popover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMaxYEdge];

    NSPasteboard *thePasteboard = [NSPasteboard generalPasteboard];
    NSString* stringFromPasteboard = [thePasteboard stringForType:NSPasteboardTypeString];
    if (stringFromPasteboard != NULL && [stringFromPasteboard length] != 0) {
        [self decode:stringFromPasteboard];
    }
}

- (void) checkPasteboard:(id)param;
{
    while(1) {
        NSPasteboard *thePasteboard = [NSPasteboard generalPasteboard];
        if([thePasteboard changeCount] != countChangedInPasteboard) {
            countChangedInPasteboard = [thePasteboard changeCount];
            if (statusItem != nil) {
                id sender = [statusItem view];
                [NSApp sendAction:@selector(onStatusBarClicked:) to:self from:sender];
            }
        }
        sleep(1);
    }
}

- (void)decode:(NSString*)string
{
    Encoder *encoder = [Encoder new];
    [decodedTextField setFont:[NSFont fontWithName:@"Baskerville" size:15]];
    [decodedTextField setString: [encoder decodeNSString:string checkCP1251:NO]];
    [encoder release];
}

- (void) awakeFromNib
{    
    TEStatusItem* view = [[TEStatusItem alloc] initWithFrame:NSMakeRect(0, 0, 24, 24)];
    //[view setAction:@selector(onStatusBarClicked:)];
    //[view setTarget:self];
    
    statusItem = [[[NSStatusBar systemStatusBar]
                                 statusItemWithLength:NSSquareStatusItemLength] retain];
    [statusItem setHighlightMode:NO];
    [statusItem setView:view];
    
    NSPopover* p = (NSPopover*) popover;
    p.delegate = (id<NSPopoverDelegate>)self;
    
    countChangedInPasteboard =[[NSPasteboard generalPasteboard] changeCount];
    
    [NSThread detachNewThreadSelector:@selector(checkPasteboard:) toTarget:self withObject:nil];

}

@end
