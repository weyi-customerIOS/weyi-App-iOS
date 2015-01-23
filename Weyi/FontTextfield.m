//
//  FontTextfield.m
//  Weyi
//
//  Created by Dmitry Zubar on 1/22/15.
//  Copyright (c) 2015 Weyimobile Inc. All rights reserved.
//

#import "FontTextfield.h"
#import "Constants.h"

@implementation FontTextfield

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setPlaceholder:NSLocalizedString(self.placeholder, nil)];
    
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
