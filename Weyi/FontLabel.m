//
//  LocalisedLabel.m
//  Weyi
//
//  Created by Dmitry Zubar on 1/20/15.
//  Copyright (c) 2015 Weyimobile Inc. All rights reserved.
//

#import "FontLabel.h"
#import "Constants.h"

@implementation FontLabel

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setText:NSLocalizedString(self.text, nil)];
    
    UIFont *currentFont = self.font;
    
    if (currentFont == [UIFont systemFontOfSize:currentFont.pointSize])
    {
        [self setFont:[UIFont fontWithName:fDroidSerif size:currentFont.pointSize]];
    }
    else if (currentFont == [UIFont boldSystemFontOfSize:currentFont.pointSize])
    {
        [self setFont:[UIFont fontWithName:fDroidSerifBold size:currentFont.pointSize]];
    }
}

@end
