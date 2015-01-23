//
//  weyi.h
//  weyiClient
//
//  Created by Xiang Xu on 12/26/14.
//  Copyright (c) 2014 weyimobile,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "utilities.h"
@interface weyiLogin : NSObject

/*register account for user and automaticly sign in
 *For test, you need to register the account using existing account email and pwd
 *Note that there is a half possibility that return existing email,just ignore this and sign in again
 *email:weyitest1@weyimobile.com pwd:1234Aa
 *email:weyitest2@weyimobile.com pwd:1234Aa
 *email:weyitest3@weyimobile.com pwd:1234Aa
 *param : email,country,phone#,password
 *return :NSString Possible output:
 *@"Success Registration"
 *@"Fail Registration!"
 *@"Please finish the registration form!"
 *@"Email is already registrated!"
 *@"Password need at least 1 uppercase and 1 lowercase letter"
 *@"Email is not in valid format."
 */
-(NSString*) registerIn:(NSString*) email :(NSString*) country :(NSString*) phone :(NSString*) pwd;

/*Sign in using email and password
 *If sign in successful, the user account will automaticly be stored in local keychain
 *email:weyitest1@weyimobile.com pwd:1234Aa
 *email:weyitest2@weyimobile.com pwd:1234Aa
 *email:weyitest3@weyimobile.com pwd:1234Aa
 *param: email,password
 *return NSString Possible output:
 *@"Success Login"
 *@"Fail Login"
 */
-(NSString*) signIn:(NSString*) email :(NSString*) pwd;

//retrieve customer instance from local keychain, if keychain does not have record
//will return nil.
-(Customer*) getCustomerFromLocal;

//when application relaunch, will check if the keychain account valid sign in.
-(bool) loginOrNot;


@end
