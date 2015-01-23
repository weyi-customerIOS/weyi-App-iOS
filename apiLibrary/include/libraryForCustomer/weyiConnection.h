//
//  weyiConnection.h
//  weyiClient
//
//  Created by Xiang Xu on 12/30/14.
//  Copyright (c) 2014 weyimobile,Inc. All rights reserved.
//

/* The weyiConnection whole process is like following
 * 1.initialization: weyiConnection *w = [[weyiConnection alloc] init]
 * 2.[w startProcessingBeforeCall] start to receive provider message
 *   there is a possibility that no providers available for 10 sec
 *   the request will be canceled.
 * 3.[w startCalling:provider] call to provider you choose
 *   there is a possibility that call is failed,
 *   you can recall to the provider by recalling this method
 * 4.While the call is connected, you can hangup the call by [w finishCalling]
 * 5.When the call is finished, you can choose to recall/finishService.
 */

#import "utilities.h"
#import "weyiConnectionDelegate.h"
enum {
    Waiting =0,
    AvailableProvider =1,
    Calling=2,
    CallFail=3,
    Connected=4,
    Finish=5
};
typedef NSInteger ConnectionStatus;

@interface weyiConnection : NSObject
{
    Service *m_service;
    NSInteger m_status;
    NSTimer *m_timer;
    NSMutableArray *m_providers;
    NSDate* start;
    NSDate* end;
    Provider* generated;
}

//property of the delegate.
@property (nonatomic,assign) id delegate;

//A connection must be with a service
@property (nonatomic,retain) Service* m_service;

//The status of the whole process ranged from 0 to 5 defined above
@property (nonatomic) NSInteger status;

//A timer used to simulate the process since there is no server supported currently
@property (nonatomic,retain) NSTimer* m_timer;

//Two date pointer used to calculate the calling time of the service
@property (nonatomic) NSDate *start,*end;

//initialize an instance to set a new service and a customized protocol with the connection
-(id) initFromUser:(Service*) service :(id<weyiConnectionDelegate>) delegate;

/*Submit the service which user need and start to receive the available provider message
 */
-(void) startProcessingBeforeCall;

/*Fake method to send the photo to other side
 */
-(void) sendPhoto:(UIImage*) img;

/* After choosing a provider from the messages received
 * User need to choose a provider to call
 */
-(void) startCalling:(Provider*) provider;

/* HangUp the call after the connection is already connected
 */
-(void) finishCalling;

/* Finish the whole service process
 * According to the "done" button on the picture
 */
-(void) finishAll;

/* Mute feature when connected, fake method, only log out a mute output
 */
-(void) mute;

/* Speaker feature when connected, fake method, only log out a speaker output
 */
-(void) changeSpeaker;

/* A user can cancel the request in the Waiting, AvailableProvider, NoProvider status.
 */
-(void) cancelAll;

@end
