//
//  Cask.m
//  config
//
//  Created by Mike Arpaia on 3/15/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import "Cask.h"

@implementation Cask

- (id)initWithPackages:(NSDictionary *)packages
{
  self = [super initWithPackages:packages];
  if (self) {
    self.listArgs = @[@"cask", @"list"];
    self.installArgs = @[@"cask", @"install"];
  }
  return self;
}

@end
