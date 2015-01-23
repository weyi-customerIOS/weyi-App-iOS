//
//  FontButton.m
//  Weyi
//
//  Created by Dmitry Zubar on 1/22/15.
//  Copyright (c) 2015 Weyimobile Inc. All rights reserved.
//

#import "FontButton.h"
#import "Constants.h"

@implementation FontButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.titleLabel setText:NSLocalizedString(self.titleLabel.text, nil)];
    
    UIFont *currentFont = self.titleLabel.font;
    
    if (currentFont == [UIFont systemFontOfSize:currentFont.pointSize])
    {
        [self.titleLabel setFont:[UIFont fontWithName:fDroidSerif size:currentFont.pointSize]];
    }
    else if (currentFont == [UIFont boldSystemFontOfSize:currentFont.pointSize])
    {
        [self.titleLabel setFont:[UIFont fontWithName:fDroidSerifBold size:currentFont.pointSize]];
    }
}

@end
