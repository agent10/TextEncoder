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

- (NSString *) getNSString:(char *) in_buff;
{
    return [NSString stringWithCString:in_buff encoding:NSUTF8StringEncoding];
}

- (NSString* )decodeNSString:(NSString* )string checkCP1251:(BOOL)check
{
    const char* in_buff = [string UTF8String];
    char* decoded_buff = [self decode:in_buff checkCP1251:check];
    if(decoded_buff == nil) {
        return nil;
    }
    NSString* out_string = [self getNSString:decoded_buff];
    free(decoded_buff);
    return out_string;
}

- (char *)decode:(const char *)in_buff checkCP1251:(BOOL)check
{
    const char* in = in_buff;
    size_t len = strlen(in);
    char* out = NewPtr(len+1);
    int charcp1251 = 0;
    int i = 0;
    unsigned char first_byte_in;
    unsigned char second_byte_in;
    unsigned char first_byte_out;
    unsigned char second_byte_out;
    while(i < len) {
        first_byte_in = (unsigned char)in[i];
        second_byte_in = (unsigned char)in[i+1];
        //Small and capital leters IO
        if(first_byte_in == 0xc2 && second_byte_in == 0xa8) {
            out[i] = 0xd0;
            out[i+1] = 0x81;
            i += 2;
            continue;
        }
        if(first_byte_in == 0xc2 && second_byte_in == 0xb8) {
            out[i] = 0xd1;
            out[i+1] = 0x91;
            i += 2;
            continue;
        }
        
        if(first_byte_in != 0xc3) {
            out[i] = first_byte_in;
            i++;
            continue;
        }
        charcp1251++;
        
        first_byte_out = 0xd0;
        second_byte_out = second_byte_in + 0x10;
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
    if (charcp1251 == 0 && check) {
        free(out);
        return nil;
    }
    out[len] = '\0';
    return out;
}

@end
