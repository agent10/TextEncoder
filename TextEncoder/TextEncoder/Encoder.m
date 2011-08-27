//
//  Encoder.m
//  TextEncoder
//
//  Created by Kirill Olenyov on 8/26/11.
//  Copyright 2011 House. All rights reserved.
//

#import "Encoder.h"

@implementation Encoder

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (const char *)getCharPointer:(NSString *)string
{
    return [string UTF8String];
}

- (NSString *) getNSString:(char *) in_buff;
{
    return [NSString stringWithCString:in_buff encoding:NSUTF8StringEncoding];
}

- (NSString* )decodeNSString:(NSString* )string checkCP1251:(BOOL)check
{
    const char* in_buff = [self getCharPointer:string];
    char* decoded_buff = [self decode:in_buff checkCP1251:NO];
    NSString* out_string = [self getNSString:decoded_buff];
    return out_string;
}

- (char *)decode:(const char *)in_buff checkCP1251:(BOOL)check
{
    const char* in = in_buff;
    int len = strlen(in);
    char* out = NewPtr(len+1);// = new char[len+1];
    int charnotcp1251 = 0;
    int i = 0;
    while(i < len) {
        unsigned char first_byte_in = (unsigned char)in[i];
        unsigned char second_byte_in = (unsigned char)in[i+1];
        if(first_byte_in != 0xc3) {
            charnotcp1251++;
            if (charnotcp1251 > 5 && check) {
                //TODO
                //Memory out should be free
                return nil;
            }
            out[i] = first_byte_in;
            i++;
            continue;
        }
        
        unsigned char first_byte_out = 0xd0;
        unsigned char second_byte_out = second_byte_in + 0x10;
        if(second_byte_out > 0xbf) {
            second_byte_out -= 0x40;
        }
        if(second_byte_out < 0x90) {
            first_byte_out = 0xd1;
        }
        out[i] = first_byte_out;
        out[i+1] = second_byte_out;
        
        i += 2;
    }
    out[len] = '\0';
    return out;
}

@end
