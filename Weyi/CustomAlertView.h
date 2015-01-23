//
//  CustomAlertView.h
//  Weyi
//
//  Created by Dmitry Zubar on 1/22/15.
//  Copyright (c) 2015 Weyimobile Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomAlertViewDelegate;

@interface CustomAlertView : UIView

@property (nonatomic, weak) id<CustomAlertViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame
                       colour:(UIColor *)colour
                        title:(NSString *)title
                         body:(NSString *)body
                     delegate:(id)delegate
            cancelButtonTitle:(NSString *)cancelButtonText
            confirmButtonText:(NSString *)confirmButtonText;

- (instancetype)initWithTitle:(NSString *)title
                         body:(NSString *)body
                     delegate:(id)delegate
            cancelButtonTitle:(NSString *)cancelButtonText
            confirmButtonText:(NSString *)confirmButtonText;



@end

@protocol CustomAlertViewDelegate <NSObject>

@optional
- (void)customAlertViewPressedCancelButton:(CustomAlertView *)alertView;
- (void)customAlertViewPressedConfirmButton:(CustomAlertView *)alertView;

@end