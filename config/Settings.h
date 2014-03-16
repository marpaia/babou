//
//  Settings.h
//  config
//
//  Created by Mike Arpaia on 3/15/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Logger.h"

@interface Settings : NSObject

@property (nonatomic) NSDictionary *settings;

- (id)initWithSettings:(NSDictionary*)settings;
- (void)configure;

@end
