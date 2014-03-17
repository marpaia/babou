//
//  Util.m
//  config
//
//  Created by Mike Arpaia on 3/14/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (NSString*)hashForFileAtPath:(NSString*)path
{
  NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
  return [data MD5];
}

+ (NSString*)resolveHomeDirPathString:(NSString*)path
{
  App *sharedApp = [App sharedInstance];
  return [path stringByReplacingOccurrencesOfString:@"~" withString:sharedApp.homeDir];
}

+ (NSString*)which:(NSString*)binary
{
  NSTask *task = [NSTask new];
  NSPipe *outputText = [NSPipe new];
  App* sharedApp = [App sharedInstance];
  task.launchPath = @"/usr/bin/which";
  task.arguments = @[binary];
  task.standardOutput = outputText;
  task.environment = sharedApp.environment;
  [task launch];
  [task waitUntilExit];
  NSData *data = [[outputText fileHandleForReading] readDataToEndOfFile];
  NSString *output = [[NSString alloc] initWithData:data
                                           encoding:NSUTF8StringEncoding];
  return output;
}

+ (NSArray*)generateArrayOfDirectoryChildrenAtPath:(NSString*)path
{
  NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:@[]];
  NSFileManager *fileManager = [NSFileManager defaultManager];
  NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:path];
  for (NSString *file in enumerator) {
    BOOL isDir = NO;
    [fileManager fileExistsAtPath:file isDirectory:&isDir];
    if (!isDir) {
      [mutableArray addObject:[@[path, file] componentsJoinedByString:@"/"]];
    }
  }
  return mutableArray;
}

@end
