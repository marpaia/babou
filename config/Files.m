//
//  Files.m
//  config
//
//  Created by Mike Arpaia on 3/15/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import "Files.h"
#import "App.h"

@implementation Files

- (id)init
{
  self = [super init];
  if (self) {
    self.environment = [[NSProcessInfo processInfo] environment];
    self.homeDir = [self.environment objectForKey:@"HOME"];
    self.sharedApp = [App sharedInstance];
  }
  return self;
}

- (void)createDirectories:(NSArray*)directories
{
  [Logger debug:@"[Files createDirectories:]"];
  if (!directories) {
    [Logger debug:@"no directories to create"];
    return;
  }

  for (NSString *directory in directories) {
    [Files createDirectoryIfNotExists:[Util resolveHomeDirPathString:directory]];
  }
}

+ (void)createDirectoryIfNotExists:(NSString*)directory
{
  NSFileManager *fileManager= [NSFileManager defaultManager];
  if(![fileManager fileExistsAtPath:directory]) {
    if(![fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:NULL]) {
      [App printHelpAndExitWithExitCode:1 andMessage:[Errors errorMessageForError:CREATE_DIRECTORY_FAILED]];
    } else {
      NSString *logString = [[NSString alloc] initWithFormat:@"created directory: %@", directory];
      [Logger event:logString];
    }
  } else {
    NSString *logString = [[NSString alloc] initWithFormat:@"directory already exists: %@", directory];
    [Logger info:logString];
  }
}

- (void)createFileMappings:(NSDictionary*)fileMappings
{
  [Logger debug:@"[Files createFileMappings:]"];
  if (!fileMappings) {
    [Logger debug:@"no file mappings to create"];
    return;
  }

  for (NSString *filePath in fileMappings) {
    NSString *fullPath = [Util resolveHomeDirPathString:filePath];

    NSString *savedPath = [self resolveFileTargetFromSubPath:[fileMappings objectForKey:filePath]];

    BOOL savedPathIsDir;
    BOOL savedPathExists = [[NSFileManager defaultManager] fileExistsAtPath:savedPath isDirectory:&savedPathIsDir];

    if (!savedPathExists) {
      [App printHelpAndExitWithExitCode:1 andMessage:[Errors errorMessageForError:FILE_IN_MAPPING_NOT_FOUND]];
    }

    if (savedPathIsDir) {
      NSArray* children = [Util generateArrayOfDirectoryChildrenAtPath:savedPath];

      for (NSString *configPath in children) {
        NSString *shortInstalledPath = [configPath stringByReplacingOccurrencesOfString:savedPath withString:filePath];
        NSString *installedPath = [Util resolveHomeDirPathString:shortInstalledPath];

        [self copyFileIfDifferentFrom:configPath to:installedPath];
      }
      
    } else {
      [self copyFileIfDifferentFrom:savedPath to:fullPath];
    }
  }
}

- (void)copyFileIfDifferentFrom:(NSString*)fullPath to:(NSString*)savedPath
{
  NSString *fullPathHash = [Util hashForFileAtPath:fullPath];
  NSString *savedPathHash = [Util hashForFileAtPath:savedPath];

  BOOL isSrcDir = NO;
  [[NSFileManager defaultManager] fileExistsAtPath:fullPath isDirectory:&isSrcDir];
  BOOL isDstDir = NO;
  BOOL destExists = [[NSFileManager defaultManager] fileExistsAtPath:savedPath isDirectory:&isDstDir];

  if (isSrcDir && !destExists) {
    [Files createDirectoryIfNotExists:savedPath];
  }

  if (isSrcDir || isDstDir) {
    return;
  }

  if (![fullPathHash isEqualToString:savedPathHash]) {
    NSError *error = nil;
    NSString *fileContents = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:&error];
    if (!destExists) {
      [[NSFileManager defaultManager] createFileAtPath:savedPath contents:[NSData dataWithContentsOfFile:fullPath] attributes:nil];
    } else {
      [fileContents writeToFile:fullPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
      if (error) {
        NSLog(@"%@", error);
        [App printHelpAndExitWithExitCode:1 andMessage:[Errors errorMessageForError:FILE_COPY_FAILED]];
      }
    }
    NSString *logString = [NSString stringWithFormat:@"File at path %@ was updated", fullPath];
    [Logger event:logString];
  } else {
    NSString *logString = [NSString stringWithFormat:@"Not copying %@ to %@ because they're identical", savedPath, fullPath];
    [Logger info:logString];
  }
}

- (NSString*)resolveFileTargetFromSubPath:(NSString*)path
{
  return [NSString stringWithFormat:@"%@/%@", self.sharedApp.configDirPath, path];
}

@end
