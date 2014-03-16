//
//  Brew.m
//  config
//
//  Created by Mike Arpaia on 3/15/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import "Brew.h"

@implementation Brew

- (id)initWithPackages:(NSDictionary *)packages
{
  self = [super initWithPackages:packages];
  if (self) {
    self.listArgs = @[@"list"];
    self.installArgs = @[@"install"];
  }
  return self;
}

@end
