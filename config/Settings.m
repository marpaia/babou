//
//  Settings.m
//  config
//
//  Created by Mike Arpaia on 3/15/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import "Settings.h"

@implementation Settings

- (id)initWithSettings:(NSDictionary*)settings
{
  self = [super init];
  if (self) {
    [Logger debug:@"[Settings configureSystemSettings]"];
    self.settings = settings;
  }
  return self;
}

- (void)configure
{
  if (!self.settings) {
    [Logger info:@"no settings to configure"];
    return;
  }

  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

  for (NSString *domain in self.settings) {
    NSMutableDictionary *dict = [[defaults persistentDomainForName:domain] mutableCopy];
    for (NSString *key in [self.settings objectForKey:domain]) {
      id value = [[self.settings objectForKey:domain] objectForKey:key];
      [dict setValue:value forKey:key];
    }
    [defaults setPersistentDomain:dict forName:domain];
  }
}

@end
