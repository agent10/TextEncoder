//
//  TEStatusItem.h
//  TextEncoder
//
//  Created by Kirill Olenyov on 8/27/11.
//  Copyright 2011 House. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TEStatusItem : NSView
{
    SEL _action;
    id _target;
    NSImage* _image;
}

-(void) setAction:(SEL)action;
-(void) setTarget:(id)target;

@end
