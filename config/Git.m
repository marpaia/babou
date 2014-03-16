//
//  Git.m
//  config
//
//  Created by Mike Arpaia on 3/15/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import "Git.h"
#import "App.h"

@implementation Git

- (id)initWithRepositories:(NSDictionary*)repositories
{
  self = [super init];
  if (self) {
    self.repositories = repositories;
    self.sharedApp = [App sharedInstance];
    self.gitPath = [Util which:@"git"];
    
  }
  return self;
}

- (void)clone
{
  if (!self.repositories) {
    return;
  }

  for (NSString *remote in self.repositories) {
    NSString *path = [Util resolveHomeDirPathString:[self.repositories objectForKey:remote]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
      NSArray *args = @[@"clone", remote, path];
      NSTask *task = [NSTask new];
      task.launchPath = @"/usr/bin/git";
      task.arguments = args;
      task.environment = self.sharedApp.environment;
      [task launch];
      [task waitUntilExit];

      if (task.terminationStatus == 0) {
        NSString *logString = [[NSString alloc]
                               initWithFormat:@"Cloned %@ to %@", remote, path];
        [Logger event:logString];
      } else {
        NSString *logString = [[NSString alloc]
                               initWithFormat:@"Cloning %@ to %@ failed with exit code %d", remote, path, task.terminationStatus];
        [Logger fatal:logString];
      }
    } else {
      NSString *logString = [[NSString alloc]
                             initWithFormat:@"Not cloning %@ to %@ because it already is cloned", remote, path];
      [Logger info:logString];
    }
  }
}

@end
