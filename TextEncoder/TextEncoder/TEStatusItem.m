//
//  TEStatusItem.m
//  TextEncoder
//
//  Created by Kirill Olenyov on 8/27/11.
//  Copyright 2011 House. All rights reserved.
//

#import "TEStatusItem.h"

@implementation TEStatusItem

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _image = [NSImage imageNamed:@"Status"];
        // Initialization code here.
    }
    
    return self;
}

-(void) setAction:(SEL)action
{
    _action = action;
}

-(void) setTarget:(id)target
{
    _target = target;
}

- (void)drawRect:(NSRect)dirtyRect
{    
    NSImage *icon = _image;
    NSSize iconSize = [icon size];
    NSRect bounds = self.bounds;
    CGFloat iconX = roundf((NSWidth(bounds) - iconSize.width) / 2);
    CGFloat iconY = roundf((NSHeight(bounds) - iconSize.height) / 2);
    NSPoint iconPoint = NSMakePoint(iconX, iconY);
    [icon compositeToPoint:iconPoint operation:NSCompositeSourceOver];
}

- (void)mouseDown:(NSEvent *)theEvent
{
    [NSApp sendAction:_action to:_target from:self];
}

@end
