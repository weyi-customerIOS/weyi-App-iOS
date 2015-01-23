//
//  weyiConnectionDelegate.h
//  weyiClient
//
//  Created by Xiang Xu on 12/31/14.
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
@class weyiConnection;

@protocol weyiConnectionDelegate <NSObject>

@optional
/* called when user start a request to receive available providers
 */
-(void) startRequest:(weyiConnection*) connection;

/* called when there is no provider available
 */
-(void) noProviderInfo:(weyiConnection*) connection;

/* called when receive a provider message.
 */
-(void) receiveProviderInfo:(Provider*) provider;

/* called when user call to a provider
 */
-(void) callingToProvider:(weyiConnection*) connection :(Provider*) provider;

/* called when call is connected
 */
-(void) callDidConnected:(weyiConnection*) connection;

/* called when call is failed
 */
-(void) callFailed:(weyiConnection*) connection;

/* called when call is hanged up
 */
-(void) callFinished:(weyiConnection*) connection;

/* called when request is canceled by user.
 */
-(void) callIsCanceled:(weyiConnection*) connection;

/* called when user choose to finish the whole service process
 */
-(void) finishAll:(weyiConnection*) connection;

@end
