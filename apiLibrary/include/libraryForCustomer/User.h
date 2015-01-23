//
//  User.h
//  weyiClient
//
//  Created by Xiang Xu on 12/24/14.
//  Copyright (c) 2014 weyimobile,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Service.h"
#import <UIKit/UIKit.h>//

enum {
    UserStateOff,
    UserStateForeGround,
    UserStateBackGround
};

typedef NSInteger UserStateType;
enum {
    Native = 0,
    NearNative = 1,
    Proficient = 2,
    VeryGoodCommand = 3,
    GoodCommand = 4,
    Basic= 5
};
typedef NSInteger LanguageLevel;
@interface User : NSObject
{
    NSString *m_id;
    NSString *m_email;
    NSString *m_address;
    NSString *m_name;
    NSString *m_remain;
    UserStateType *m_status;
    NSMutableArray *m_history;
    NSString *m_tel;
    NSString *m_pwd;
    NSString *m_gender;
    NSString *m_country;
    UIImage *m_photo;
    NSDictionary *m_lan;
}
//several basic information for users
@property (nonatomic) NSString *m_id,*m_email,*m_address,*m_name,*m_pwd,*m_gender,*m_country;
@property (nonatomic) NSString *m_remain,*m_tel;
@property (nonatomic) NSMutableArray* m_history;
@property (nonatomic) UserStateType* m_status;
@property (nonatomic) UIImage *m_photo;
//store example as key:@"English" value:@"5"
@property (nonatomic) NSDictionary *m_lan;

-(id) init;

//Convert user information to dictionary. Already used in our utilities.h class.
-(NSMutableDictionary*) convertToDict;

//Convert dictionary back to user class.Can be call c = [c convertFromDict map]

-(User*) convertFromDict:(NSMutableDictionary*) map;

//method to set the user email
-(void) setEmail:(NSString*) email;

//method to set the user address
-(void) setAdd:(NSString*) add;

//method to set user name
-(void) setName:(NSString*) name;

//method to set user password
-(void) setPwd:(NSString*) pwd;

//method to set user gender
-(void) setGender:(NSString*) gender;

//method to set the remain balance of user
-(void) setRemain:(NSString*) remain;

//method to set the user phone number
-(void) setTel:(NSString*) tel;

//method to set the user country
-(void) setCountry:(NSString*) country;

//method to update user information to server
-(void) updateStatus;

//method to set the user photo
-(void) setPhoto:(UIImage*) photo;

/*method to add a language into user skill set
  level ranged from 0 to 5, 5 is native language
 */
 -(void) addAlanguage:(NSString*) language : (NSInteger) level;

//add a service instance to the service history.
-(void) addServiceToHistory:(Service *) service;
@end




