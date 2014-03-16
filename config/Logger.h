//
//  Logger.h
//  config
//
//  Created by Mike Arpaia on 3/15/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Logger : NSObject

+ (void)debug:(NSString*)message;
+ (void)info:(NSString*)message;
+ (void)event:(NSString*)message;
+ (void)fatal:(NSString*)message;

@end
