//
//  main.m
//  config
//
//  Created by Mike Arpaia on 3/14/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "App.h"

int main(int argc, const char * argv[])
{

  @autoreleasepool {
    App *app = [App sharedInstance];
    [app startApp];
  }
    return 0;
}

