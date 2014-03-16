//
//  Git.h
//  config
//
//  Created by Mike Arpaia on 3/15/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Logger.h"
#import "Util.h"

@class App;

@interface Git : NSObject

@property (nonatomic) App* sharedApp;
@property (nonatomic) NSDictionary* repositories;
@property (nonatomic) NSString* gitPath;

- (id)initWithRepositories:(NSDictionary*)repositories;
- (void)clone;

@end
