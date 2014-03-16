//
//  App.h
//  config
//
//  Created by Mike Arpaia on 3/14/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>
#import "Errors.h"
#import "Brew.h"
#import "Cask.h"
#import "Files.h"
#import "Git.h"
#import "Settings.h"
#import "Logger.h"
#import "Package.h"
#import "Util.h"

@interface App : NSObject

@property (nonatomic) NSString* configDirPath;
@property (nonatomic) NSString* configFilePath;
@property (nonatomic) NSDictionary* configFileContent;
@property (nonatomic) NSDictionary* environment;
@property (nonatomic) NSString* shell;
@property (nonatomic) NSString* homeDir;

+ (App*)sharedInstance;
- (void)startApp;
+ (void)printHelp;
+ (void)printHelpAndExitWithExitCode:(int)exitCode;
+ (void)printHelpAndExitWithExitCode:(int)exitCode andMessage:(char*)message;
- (int)gatherSettings;
- (int)parseConfigFile;

@end
