//
//  Provider.h
//  weyiClient
//
//  Created by Xiang Xu on 12/24/14.
//  Copyright (c) 2014 weyimobile,Inc. All rights reserved.
//

#import "User.h"

@interface Provider:User{
    NSString* m_rate;
    NSString* m_rating;
}
/* m_rate : the price of this provider
 * m_rating : the average review rating of this provider
 */
@property (nonatomic,retain) NSString *m_rate,*m_rating;

@end

