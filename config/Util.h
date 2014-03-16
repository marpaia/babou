//
//  Util.h
//  config
//
//  Created by Mike Arpaia on 3/14/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+MD5.h"
#import "App.h"

@interface Util : NSObject

+ (NSString*)hashForFileAtPath:(NSString*)path;
+ (NSString*)resolveHomeDirPathString:(NSString*)path;
+ (NSString*)which:(NSString*)binary;
+ (NSArray*)generateArrayOfDirectoryChildrenAtPath:(NSString*)path;

@end
