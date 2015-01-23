//
//  weyiContentLayout.h
//  weyiClient
//
//  Created by Xiang Xu on 12/29/14.
//  Copyright (c) 2014 weyimobile,Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "weyiLogin.h"

@interface weyiContentLayout : NSObject
/*MainPage need to dynamicly show some html files maybe AD or Information
 *return NSMutableArray including several html data sources
 *if you use a UIwebview,
 *use [webview loadData:data MIMEType:@"text/html" textEncodingName: @"UTF-8" baseURL: nil]
 */
-(NSMutableArray *) getAllHtmlFileToShowInMainPage;

/*Service Request Waiting Page need to show some content telling customer to wait
 *return NSData for html data source
 *if you use a UIwebview,
 *use [webview loadData:data MIMEType:@"text/html" textEncodingName: @"UTF-8" baseURL: nil]
 */
-(NSData*) getHtmlFileToShowInPhoneWaitingPage;

/*Privacy and Policy section need to show Privacy and Policy content
 *This is a Privacy & Policy sample file
 *return NSData for html data source
 *if you use a UIwebview,
 *use [webview loadData:data MIMEType:@"text/html" textEncodingName: @"UTF-8" baseURL: nil]
 */
-(NSData *) getHTMLFileInPolicy;

/*Terms and Conditions section need to show Terms and Conditions content
 *This is a Terms and Conditions sample file
 *return NSData for html data source
 *if you use a UIwebview,
 *use [webview loadData:data MIMEType:@"text/html" textEncodingName: @"UTF-8" baseURL: nil]
 */
-(NSData *) getHTMLFileInTerm;

/*For specified service we have done in the application, we need to show a summary to customer
 *return NSData for html data source
 *if you use a UIwebview,
 *use [webview loadData:data MIMEType:@"text/html" textEncodingName: @"UTF-8" baseURL: nil]
 */
-(NSData *) getHTMLFileForService:(Service*) service;

/*According to the device location, show the recommand language service
 *return NSString (@"en",@"de",@"cn"...)
 */
-(NSString *) getLocalLanguage;

/* return a dictionary include all the languages
 */
-(NSMutableArray *) getAllLanguages;

/*Fixed array of several situation prediction
 *return an array including several NSString
 */
-(NSMutableArray *) getSituationList;

/* return a dictionary include all the countries
 */
-(NSMutableDictionary *) getAllCountryList;

/* return a string represent the country the device is located
 * country dialing prefix list can be made combined with getAllCountryList method above
 * if you want my location country is at the first.
 */
-(NSString *) getMyLocationCountry;

@end
