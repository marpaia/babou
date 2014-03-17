//
//  Logger.m
//  config
//
//  Created by Mike Arpaia on 3/15/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import "Logger.h"

@implementation Logger

+ (void)debug:(NSString*)message
{
  //NSLog(@"[DEBUG]: %@", message);
}

+ (void)info:(NSString *)message
{
  NSLog(@"[INFO]: %@", message);
}

+ (void)event:(NSString *)message
{
  NSLog(@"[EVENT]: %@", message);
}

+ (void)fatal:(NSString *)message
{
  NSLog(@"[FATAL]: %@", message);
  exit(1);
}

@end
