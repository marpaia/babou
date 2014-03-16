//
//  Files.h
//  config
//
//  Created by Mike Arpaia on 3/15/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Logger.h"
#import "Errors.h"
#import "Util.h"

@class App;

@interface Files : NSObject

@property (nonatomic) NSDictionary *environment;
@property (nonatomic) NSString *homeDir;
@property (nonatomic) App *sharedApp;

- (void)createDirectories:(NSDictionary*)directories;
+ (void)createDirectoryIfNotExists:(NSString*)directory;
- (void)createFileMappings:(NSDictionary*)fileMappings;
- (void)copyFileIfDifferentFrom:(NSString*)fullPath to:(NSString*)savedPath;
- (NSString*)resolveFileTargetFromSubPath:(NSString*)path;

@end
