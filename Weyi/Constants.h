//
//  Constants.h
//  Weyi
//
//  Created by Dmitry Zubar on 1/22/15.
//  Copyright (c) 2015 Weyimobile Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

//UIAlertView srtings
//title
extern NSString * const avTitleWarning;
extern NSString * const avTitleError;
extern NSString * const avTitlePhoneNumberConfirmation;
//body
extern NSString * const avBodyFillAll;
extern NSString * const avBodyEmailExists;
extern NSString * const avBodyPasswordRequirements;
extern NSString * const avBodyEmailInvalid;
extern NSString * const avBodyUnknownError;
extern NSString * const avBodyPhoneNumberConfirmation;
//buttons
extern NSString * const avButtonReturn;

//Font Names
extern NSString * const fDroidSerif;
extern NSString * const fDroidSerifBold;

#define DEFAULT_TEXT_COLOUR [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f]

@end
