//
//  RegionViewController.h
//  Weyi
//
//  Created by Dmitry Zubar on 1/23/15.
//  Copyright (c) 2015 Weyimobile Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegionViewControllerDelegate;

@interface RegionViewController : UIViewController

@property (nonatomic, weak) id<RegionViewControllerDelegate>delegate;

@end

@protocol RegionViewControllerDelegate <NSObject>

- (void)regionViewControllerDidPressBack:(RegionViewController *)controller;
- (void)regionViewController:(RegionViewController *)controller didSelectCountryCode:(NSString *)countryCode phoneCode:(NSString *)phoneCode;

@end
