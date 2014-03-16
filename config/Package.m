//
//  Package.m
//  config
//
//  Created by Mike Arpaia on 3/15/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import "Package.h"
#import "App.h"

@implementation Package

- (id)initWithPackages:(NSDictionary *)packages
{
  self = [super init];
  if (self) {
    self.sharedApp = [App sharedInstance];
    self.packages = packages;
    self.path = @"/usr/local/bin/brew";
  }
  return self;
}

- (void)install
{
  [self verifyIsInstalled];
  [self listAllInstalledPackages];
  [self installPackages];
}

- (void)verifyIsInstalled
{
  BOOL exists = [[NSFileManager defaultManager] isExecutableFileAtPath:self.path];
  if (!exists) {
    [App printHelpAndExitWithExitCode:1
                           andMessage:[Errors errorMessageForError:BREW_NOT_FOUND]];
  }
}

- (void)listAllInstalledPackages
{
  NSTask *task = [NSTask new];
  NSPipe *outputText = [NSPipe new];
  NSMutableArray *args = [[NSMutableArray alloc] init];
  [args addObject:self.path];
  for (NSString *each in self.listArgs) {
    [args addObject:each];
  }

  task.launchPath = self.sharedApp.shell;
  task.arguments = args;
  task.standardOutput = outputText;
  task.environment = self.sharedApp.environment;
  [task launch];
  [task waitUntilExit];

  NSData *data = [[outputText fileHandleForReading] readDataToEndOfFile];
  NSString *output = [[NSString alloc] initWithData:data
                                           encoding:NSUTF8StringEncoding];

  self.installedPackages = [output componentsSeparatedByString:@"\n"];
}

- (int)install:(NSString*)package withOptions:(NSDictionary*)options
{
  NSMutableArray *args = [[NSMutableArray alloc] init];
  [args addObject:self.path];
  for (NSString *each in self.installArgs) {
    [args addObject:each];
  }
  [args addObject:package];

  if ([options count] > 0) {
    if ([options objectForKey:@"options"]) {
      [args addObject:[options objectForKey:@"options"]];
    }
  }

  NSTask *task = [NSTask new];
  task.launchPath = self.sharedApp.shell;
  task.arguments = args;
  task.environment = self.sharedApp.environment;
  [task launch];
  [task waitUntilExit];
  if (task.terminationStatus == 0) {
    NSString *logString = [[NSString alloc]
                           initWithFormat:@"brew installed package %@", package];
    [Logger event:logString];
  } else {
    NSString *logString = [[NSString alloc]
                           initWithFormat:@"brew installed package %@ failed with exit code %d", package, task.terminationStatus];
    [Logger fatal:logString];
  }

  return task.terminationStatus;
}

- (int)installPackages
{
  for (NSString* package in self.packages) {
    if (![self.installedPackages containsObject:package]) {
      int exitCode = [self install:package withOptions:[self.packages objectForKey:package]];
      if (exitCode != 0) {
        [App printHelpAndExitWithExitCode:exitCode
                               andMessage:[Errors errorMessageForError:BREW_PACKAGE_INSTALL_FAILED]];
      }
    } else {
      NSString *logString = [[NSString alloc]
                             initWithFormat:@"skipping brew installing %@ because it's already installed", package];
      [Logger info:logString];
    }
  }
  return 0;
}

@end
