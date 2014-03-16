//
//  Package.h
//  config
//
//  Created by Mike Arpaia on 3/15/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class App;

@interface Package : NSObject

@property (nonatomic) NSString *path;
@property (nonatomic) NSArray *listArgs;
@property (nonatomic) NSArray *installArgs;
@property (nonatomic) NSArray *installedPackages;
@property (nonatomic) NSDictionary *packages;
@property (nonatomic) App* sharedApp;

- (id)initWithPackages:(NSDictionary *)packages;
- (void)install;
- (void)verifyIsInstalled;
- (void)listAllInstalledPackages;
- (int)install:(NSString*)package withOptions:(NSDictionary*)options;
- (int)installPackages;


@end
