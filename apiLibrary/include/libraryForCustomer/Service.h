//
//  Service.h
//  weyiClient
//
//  Created by Xiang Xu on 12/22/14.
//  Copyright (c) 2014 weyimobile,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
enum{
    ServiceStateRequested,
    ServiceStateProcessing,
    ServiceStateCompleted,
    ServiceStateFailed
};

typedef NSInteger ServiceStateType;
@interface Service : NSObject
{
    NSString *m_userid;
    NSString *m_serviceid;
    NSString *m_provider;
    NSString *m_froml;
    NSString *m_tol;
    NSString *m_price;
    double m_calling_time;
    NSString *m_situation;
    double m_voice_rating;
    double m_provider_rating;
}
//Basic information of Service class including userid, serviceid , providerid,
//from language, to language, price(per sec) , situation, calling time,voice rating
//and provider rating
@property (nonatomic,retain) NSString *m_userid;
@property (nonatomic,retain) NSString *m_serviceid;
@property (nonatomic,retain)NSString *m_providerid;
@property (nonatomic,retain)NSString *m_froml;
@property (nonatomic,retain)NSString *m_tol;
@property (nonatomic,retain)NSString *m_price;
@property (nonatomic,retain)NSString *m_situation;
@property (nonatomic)double m_calling_time;
@property (nonatomic)double m_voice_rating,m_provider_rating;

//Construct a service from customer client side using from language , to language ,userid and situation
-(id) initfromuser:(NSString*) lfrom : (NSString*) lto :(NSString*) userid :(NSString*) situation;

//Construct a service from provider client side using from language , to language ,userid and situation
-(id) initfromservermsg:(NSString*) lfrom :(NSString*) lto :(NSString*) userid :(NSString*) situation;

//set userid of the service
-(void) setuserid:(NSString*) uid;

//set serviceid of the service
-(void) setserviceid:(NSString*) sid;

//set provider id of the service
-(void) setproviderid:(NSString*) pid;

//set from language of the service
-(void) setfroml:(NSString*) m_from;

//set to language of the service
-(void) settol:(NSString*) m_to;

//set the rate of the service
-(void) setprice:(NSString*) m_price;

//update the total calling time of the service
-(void) updateTime:(double) callingtime;

//set situation of the service
-(void) setsituation:(NSString*) situation;

//update the voice rating and the provider rating of the service
-(void) updateRating:(double) vrating : (double) prating;

//generate a html file summary of this service. If you use UIWebview *webview
//use [webview loadData:data MIMEType:@"text/html" textEncodingName: @"UTF-8" baseURL: nil];
-(NSData*) getSummaryHtml;
@end

