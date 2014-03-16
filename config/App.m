//
//  App.m
//  config
//
//  Created by Mike Arpaia on 3/14/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import "App.h"

@implementation App

+ (App*)sharedInstance
{
  static App *app = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    app = [[self alloc] init];
  });
  return app;
}

- (void)startApp
{
  // configure the settings that the app needs to run. if it didn't work, bail
  // out and print help.
  int gatherSettings = [self gatherSettings];
  if (gatherSettings != 0) {
    [App printHelpAndExitWithExitCode:1
                           andMessage:[Errors errorMessageForError:gatherSettings]];
  }
  [Logger debug:@"finished gathering settings"];

  // parse the config.json file. it it didn't work, bail out and print help.
  int parseConfigFile = [self parseConfigFile];
  if (parseConfigFile != 0) {
    [App printHelpAndExitWithExitCode:1
                           andMessage:[Errors errorMessageForError:parseConfigFile]];
  }
  [Logger debug:@"finished parsing the config file"];

  [Logger debug:[NSString stringWithFormat:@"config file content:\n%@", self.configFileContent]];

  dispatch_group_t group = dispatch_group_create();
  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

  dispatch_group_async(group, queue, ^{
    Brew *brew = [[Brew alloc] initWithPackages:[self.configFileContent objectForKey:@"brew_packages"]];
    [brew install];
  });

  dispatch_group_async(group, queue, ^{
    Cask *cask = [[Cask alloc] initWithPackages:[self.configFileContent objectForKey:@"cask_packages"]];
    [cask install];
  });

  dispatch_group_async(group, queue, ^{
    Files *files = [Files new];
    [files createDirectories:[self.configFileContent objectForKey:@"create_directories"]];
    [files createFileMappings:[self.configFileContent objectForKey:@"file_mappings"]];
    
    Git *git = [[Git alloc] initWithRepositories:[self.configFileContent objectForKey:@"git"]];
    [git clone];
  });

  dispatch_group_async(group, queue, ^{
    Settings *settings = [[Settings alloc] initWithSettings:[self.configFileContent objectForKey:@"defaults_write"]];
    [settings configure];
  });

  dispatch_group_wait(group, DISPATCH_TIME_FOREVER);

}

// printHelp, quite logically, prints the apps help info
+ (void)printHelp
{
  printf("  OS X configuration utility\n");
  printf("\n");
}

// printHelpAndExitWithExitCode: prints the help info and exits with the
// supplied exit code
+ (void)printHelpAndExitWithExitCode:(int)exitCode
{
  [App printHelp];
  exit(exitCode);
}

// printHelpAndExitWithExitCode:andMessage: prints the supplied message and the
// help info and exits with the supplied exit code
+ (void)printHelpAndExitWithExitCode:(int)exitCode andMessage:(char*)message
{
  printf("\n  Error: %s\n\n", message);
  [App printHelpAndExitWithExitCode:exitCode];
}

// the gatherSettings method will parse out all of the settings that the
// application needs to work. if everything works out, it will save all of
// the appropriate settings as instance variables and return 0. if something
// goes wrong, gatherSettings will return an error from Errors.h.
- (int)gatherSettings
{
  // save an NSDictionary of the current environment variables
  self.environment = [[NSProcessInfo processInfo] environment];
  self.homeDir = [self.environment objectForKey:@"HOME"];
  self.shell = [self.environment objectForKey:@"SHELL"];

  // first order of precedence is the CONFIGDIR environment variable
  self.configDirPath = [self.environment objectForKey:@"CONFIGDIR"];

  // if the CONFIGDIR environment variable doesn't exist, try ~/.config
  if (!self.configDirPath) {
    self.configDirPath = [NSString stringWithFormat:@"%@/.config", self.homeDir];
  }

  // instantiate the NSFileManager instance as well as a BOOL that we can use
  // to check if self.configDir is a directory or not
  NSFileManager *fileManager = [NSFileManager new];
  BOOL isDir;

  // if the file/directory doesn't exist, return NO, indicating that the
  // settings couldn't be gathered
  if (![fileManager fileExistsAtPath:self.configDirPath isDirectory:&isDir]) {
    return CONFIG_DIR_NOT_FOUND;
  }

  // if self.configDir isn't a directory, it's not what we want so return NO
  if (!isDir) {
    return CONFIG_DIR_IS_NOT_DIR;
  }

  // check if the config.json file exists
  self.configFilePath = [NSString stringWithFormat:@"%@/config.json", self.configDirPath];
  if (![fileManager fileExistsAtPath:self.configFilePath]) {
    return CONFIG_JSON_NOT_FOUND;
  }

  // if we've gotten this far, everything has worked
  return 0;
}

// parseConfigFile parses the config.json file. if everything works out, it will
// save all of the appropriate settings as instance variables and return 0. if
// something goes wrong, parseConfigFiles will return an error from Errors.h.
- (int)parseConfigFile
{
  NSError *error;
  NSData *configFileContent = [[NSData alloc] initWithContentsOfFile:self.configFilePath
                                                            options:kNilOptions
                                                               error:&error];
  if (error) {
    return JSON_FILE_READ_ERROR;
  }

  self.configFileContent = [NSJSONSerialization JSONObjectWithData:configFileContent
                                                       options:NSJSONReadingAllowFragments
                                                         error:&error];

  if (error) {
    return JSON_PARSE_ERROR;
  }

  return 0;
}

@end
