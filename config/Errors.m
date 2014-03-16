//
//  Errors.m
//  config
//
//  Created by Mike Arpaia on 3/15/14.
//  Copyright (c) 2014 Mike Arpaia. All rights reserved.
//

#import "Errors.h"

@implementation Errors

// returns a char* error message for an int enum error reference
+ (char *)errorMessageForError:(int)error
{
  switch (error) {

    case CONFIG_DIR_NOT_FOUND:
      return "The config directory not found";
    case CONFIG_DIR_IS_NOT_DIR:
      return "The config directory is not a directory";
    case CONFIG_JSON_NOT_FOUND:
      return "The config.json file was not found";

    case JSON_FILE_READ_ERROR:
      return "An error occured trying to read the config.json file";
    case JSON_PARSE_ERROR:
      return "An error occured trying to parse the config.json file. Make sure that the file is valid json.";

    case BREW_NOT_FOUND:
      return "It doesn't look like homebrew is installed. Please install it and try again.";
    case BREW_PACKAGE_INSTALL_FAILED:
      return "Failed to install a brew package";

    case CREATE_DIRECTORY_FAILED:
      return "Failed to create a directory";

    case FILE_IN_MAPPING_NOT_FOUND:
      return "A file in the file_mappings section of config.json was not found in the config directory";
    case FILE_COPY_FAILED:
      return "The copy from source to destination failed";

    case LIST_CONTENTS_OF_DIRECTORY_FAILED:
      return "There was a problem listing the contents of a directory.";
    case READ_ATTRIBUTES_OF_FILE_FAILED:
      return "There was a problem reading the attributes of a node on the filesystem.";

    default:
      break;
  }

  return "An unknown error occured";
}

@end
