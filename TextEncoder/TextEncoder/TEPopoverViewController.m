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

- (void)pasteboardUpdated:(NSNotification *)pNotification
{
    NSString* stringFromPasteboard = (NSString*)[pNotification object];
    if (stringFromPasteboard != nil && [stringFromPasteboard length] != 0) {
        [self showPopover:[self decode:stringFromPasteboard]];
    }
}

- (void)showPopover:(NSString*)decodedString
{
    if(![popover isShown] && decodedString != nil) {
        if (statusItem != nil) {
            id sender = [statusItem view];
            [decodedTextField setString: decodedString];
            [popover showRelativeToRect:[sender bounds] ofView:sender preferredEdge:NSMaxYEdge];
        }
    }
}

- (NSString*)decode:(NSString*)string
{
    return [encoder decodeNSString:string checkCP1251:YES];
}

- (void) awakeFromNib
{        
    encoder = [Encoder new];
    
    TEstatusItem = [[TEStatusItem alloc] initWithFrame:NSMakeRect(0, 0, 24, 24)];
    
    statusItem = [[[NSStatusBar systemStatusBar]
                   statusItemWithLength:NSSquareStatusItemLength] retain];
    [statusItem setHighlightMode:NO];
    [statusItem setView:TEstatusItem];
    
    [decodedTextField setFont:[NSFont fontWithName:@"Baskerville" size:15]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pasteboardUpdated:)
                                                 name:@"pasteboardUpdated" object:nil];
    
    NSPopover* p = (NSPopover*) popover;
    p.delegate = self;

}

@end
