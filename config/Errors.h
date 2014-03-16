//
//  Errors.h
//  config
//
//  Created by Mike Arpaia on 3/15/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
  SUCCESS,

  CONFIG_DIR_NOT_FOUND,
  CONFIG_DIR_IS_NOT_DIR,
  CONFIG_JSON_NOT_FOUND,

  JSON_FILE_READ_ERROR,
  JSON_PARSE_ERROR,

  BREW_NOT_FOUND,
  BREW_PACKAGE_INSTALL_FAILED,

  CREATE_DIRECTORY_FAILED,

  FILE_IN_MAPPING_NOT_FOUND,
  FILE_COPY_FAILED,

  LIST_CONTENTS_OF_DIRECTORY_FAILED,
  READ_ATTRIBUTES_OF_FILE_FAILED
};

@interface Errors : NSObject

+ (char *)errorMessageForError:(int)error;

@end
