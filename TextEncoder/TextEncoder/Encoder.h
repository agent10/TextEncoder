//
//  Encoder.h
//  TextEncoder
//
//  Created by Kirill Olenyov on 8/26/11.
//  Copyright 2011 House. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Encoder : NSObject
{
    
}
- (NSString *) getNSString:(char *) in_buff;
- (char* )decode:(const char* )in_buff checkCP1251:(BOOL)check;
- (NSString* )decodeNSString:(NSString* )string checkCP1251:(BOOL)check;

@end
