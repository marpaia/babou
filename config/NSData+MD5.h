//
//  NSData+MD5.h
//  config
//
//  Created by Mike Arpaia on 3/15/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSData(MD5)

- (NSString *)MD5;

@end