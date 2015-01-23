//
//  utilities.h
//  weyiClient
//
//  Created by Xiang Xu on 12/24/14.
//  Copyright (c) 2014 weyimobile,Inc. All rights reserved.
//

#import "Customer.h"
#import "Provider.h"
#import "Service.h"
#import "KeychainItemWrapper.h"

//Basicly, when you design UI, this class will not be used at all,
//since it will be used in weyiLogin.h
@interface utilities : NSObject

/*Check if the login is correct. Currently only 3 account is valid
 *email:weyitest1@weyimobile.com pwd:1234Aa
 *email:weyitest2@weyimobile.com pwd:1234Aa
 *email:weyitest3@weyimobile.com pwd:1234Aa
 *param User/Customer/Provider instance
 *return bool
 */
-(bool) checkLogin:(User*) user;

/*check if the registration account is valid before ask to server
 *param: NSString email and NSString passw
 *return: int value
 * 0: form is not filled completed
 * 1: already existing email
 * 2: password need at least an upper case letter and a lower case letter
 * 3: not a valid email format
 * 4: valid
 */
-(int) checkAccountValidation:(NSString*) email :(NSString*) passw;

//store the customer information into keychain in order to sign in immediately next time
//param: Customer
-(void) storeToKeyChain:(Customer*) c;

//read the customer information from keychain to automaticly sign in
//if no record, return nil
-(Customer*) readFromKeyChain;

//fake method , will implement it in the future
//update customer record to server
-(bool) updateToDB:(Customer*) c;

//call after successful registration
-(bool) registerToDB:(Customer*) c;

//send verify code to the phone input
-(void) sendVerCodeToPhone:(NSString *) phoneNum;

//match the code with the verify code sent to phone
//Currently, will return randomly YES OR NO
-(bool) matchVerCode:(NSString*) code :(NSString* ) phoneNum;


@end
