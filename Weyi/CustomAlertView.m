//
//  CustomAlertView.m
//  Weyi
//
//  Created by Dmitry Zubar on 1/22/15.
//  Copyright (c) 2015 Weyimobile Inc. All rights reserved.
//

#import "CustomAlertView.h"
#import "FontButton.h"
#import "FontLabel.h"
#import "Constants.h"

#define LABEL_MARGIN 15.0f
#define TITLE_HEIGHT 31.0f
#define TITLE_FONT_HEIGHT 15.0f
#define BODY_FONT_SIZE 14.0f
#define BUTTON_WIDTH 75.0f
#define BUTTON_HEIGHT 25.0f
#define BUTTON_FONT_SIZE 17.0f
#define BUTTON_MIDDLE_GAP 22.0f
#define BUTTON_BOTTOM_MARGIN 7.0f
#define DEFAULT_ALERT_WIDTH 250.0f
#define DEFAULT_ALERT_BOTTOM_MARGIN 19.0f

@implementation CustomAlertView

#pragma mark - initialisation

- (instancetype)initWithFrame:(CGRect)frame
                       colour:(UIColor *)colour
                        title:(NSString *)title
                         body:(NSString *)body
                     delegate:(id)delegate
            cancelButtonTitle:(NSString *)cancelButtonText
            confirmButtonText:(NSString *)confirmButtonText
{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    
    self = [super initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    
    if (self)
    {
        if (colour == nil)
        {
            if (confirmButtonText == nil || confirmButtonText.length == 0)
            {
                colour = [UIColor redColor];
            }
            else
            {
                colour = [UIColor colorWithRed:0.0f green:51.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
            }
        }
        
        self.delegate = delegate;

        FontLabel *titleLabel = [[FontLabel alloc] initWithFrame:CGRectMake(0,
                                                                            0,
                                                                            CGRectGetWidth(frame),
                                                                            TITLE_HEIGHT)];
        [titleLabel setBackgroundColor:colour];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setText:title];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont fontWithName:fDroidSerifBold size:TITLE_FONT_HEIGHT]];
        
        CGSize bodyLabelSize = CGSizeMake(CGRectGetWidth(frame) - LABEL_MARGIN * 2.0f, MAXFLOAT);
        CGRect bodyLabelRect = [body boundingRectWithSize:bodyLabelSize
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:[UIFont fontWithName:fDroidSerif size:BODY_FONT_SIZE]}
                                                  context:nil];
        
        float bodyLabelHeight = roundf(CGRectGetHeight(bodyLabelRect));
        int numberOfLines = (int)bodyLabelHeight/(int)14.0f;
        
        FontLabel *bodyLabel = [[FontLabel alloc] initWithFrame:CGRectMake(LABEL_MARGIN,
                                                                           CGRectGetMaxY(titleLabel.frame) + LABEL_MARGIN,
                                                                           bodyLabelSize.width,
                                                                           CGRectGetHeight(bodyLabelRect))];
        [bodyLabel setNumberOfLines:numberOfLines];
        [bodyLabel setFont:[UIFont fontWithName:fDroidSerif size:BODY_FONT_SIZE]];
        [bodyLabel setText:body];
        [bodyLabel setTextAlignment:NSTextAlignmentCenter];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame)/2.0f - BUTTON_WIDTH/2.0f,
                                                                            CGRectGetMaxY(bodyLabel.frame) + LABEL_MARGIN,
                                                                            BUTTON_WIDTH,
                                                                            BUTTON_HEIGHT)];
        [cancelButton setTitle:cancelButtonText forState:UIControlStateNormal];
        [cancelButton setBackgroundColor:colour];
        [cancelButton.titleLabel setFont:[UIFont fontWithName:fDroidSerifBold size:BUTTON_FONT_SIZE]];
        [cancelButton.titleLabel setTextColor:[UIColor whiteColor]];
        [cancelButton.layer setCornerRadius:5.0f];
        [cancelButton setClipsToBounds:YES];
        [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - CGRectGetWidth(frame))/2.0f,
                                                                     CGRectGetMinY(frame),
                                                                     CGRectGetWidth(frame),
                                                                     CGRectGetMaxY(cancelButton.frame) + BUTTON_BOTTOM_MARGIN)];
        [alertView setBackgroundColor:[UIColor whiteColor]];
        [alertView.layer setCornerRadius:5.0f];
        [alertView setClipsToBounds:YES];
        
        [alertView addSubview:titleLabel];
        [alertView addSubview:bodyLabel];
        [alertView addSubview:cancelButton];
        
        if (confirmButtonText != nil && confirmButtonText.length > 0)
        {
            [cancelButton setFrame:CGRectMake((CGRectGetWidth(frame) - BUTTON_WIDTH - BUTTON_WIDTH - BUTTON_MIDDLE_GAP)/2.0f,
                                              CGRectGetMinY(cancelButton.frame),
                                              BUTTON_WIDTH,
                                              BUTTON_HEIGHT)];
            
            UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cancelButton.frame) + BUTTON_MIDDLE_GAP,
                                                                                 CGRectGetMinY(cancelButton.frame),
                                                                                 BUTTON_WIDTH,
                                                                                 BUTTON_HEIGHT)];
            [confirmButton setTitle:confirmButtonText forState:UIControlStateNormal];
            [confirmButton setBackgroundColor:colour];
            [confirmButton.titleLabel setFont:[UIFont fontWithName:fDroidSerifBold size:BUTTON_FONT_SIZE]];
            [confirmButton.titleLabel setTextColor:[UIColor whiteColor]];
            [confirmButton.layer setCornerRadius:5.0f];
            [confirmButton setClipsToBounds:YES];
            [confirmButton addTarget:self action:@selector(confirmButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            
            [alertView addSubview:confirmButton];
        }
        [self addSubview:alertView];
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                         body:(NSString *)body
                     delegate:(id)delegate
            cancelButtonTitle:(NSString *)cancelButtonText
            confirmButtonText:(NSString *)confirmButtonText
{
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    
    self = [super initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    
    if (self != nil)
    {
        UIColor *primaryColour = nil;
        UIColor *secondaryColor = nil;
        
        if (confirmButtonText == nil || confirmButtonText.length == 0)
        {
            primaryColour = [UIColor redColor];
        }
        else
        {
            primaryColour = [UIColor colorWithRed:0.0f green:51.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
            secondaryColor = [UIColor colorWithRed:51.0f/255.0f green:204.0f/255.0f blue:1.0f alpha:1.0f];
        }
        
        self.delegate = delegate;
        
        FontLabel *titleLabel = [[FontLabel alloc] initWithFrame:CGRectMake(0,
                                                                            0,
                                                                            DEFAULT_ALERT_WIDTH,
                                                                            TITLE_HEIGHT)];
        [titleLabel setBackgroundColor:primaryColour];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setText:title];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setFont:[UIFont fontWithName:fDroidSerifBold size:TITLE_FONT_HEIGHT]];
        
        CGSize bodyLabelSize = CGSizeMake(DEFAULT_ALERT_WIDTH - LABEL_MARGIN * 2.0f, MAXFLOAT);
        CGRect bodyLabelRect = [body boundingRectWithSize:bodyLabelSize
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:[UIFont fontWithName:fDroidSerif size:BODY_FONT_SIZE]}
                                                  context:nil];
        
        float bodyLabelHeight = roundf(CGRectGetHeight(bodyLabelRect));
        int numberOfLines = (int)bodyLabelHeight/(int)14.0f;
        
        FontLabel *bodyLabel = [[FontLabel alloc] initWithFrame:CGRectMake(LABEL_MARGIN,
                                                                           CGRectGetMaxY(titleLabel.frame) + LABEL_MARGIN,
                                                                           bodyLabelSize.width,
                                                                           CGRectGetHeight(bodyLabelRect))];
        [bodyLabel setNumberOfLines:numberOfLines];
        [bodyLabel setFont:[UIFont fontWithName:fDroidSerif size:BODY_FONT_SIZE]];
        [bodyLabel setText:body];
        [bodyLabel setTextAlignment:NSTextAlignmentCenter];
        
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(DEFAULT_ALERT_WIDTH/2.0f - BUTTON_WIDTH/2.0f,
                                                                            CGRectGetMaxY(bodyLabel.frame) + LABEL_MARGIN,
                                                                            BUTTON_WIDTH,
                                                                            BUTTON_HEIGHT)];
        [cancelButton setTitle:cancelButtonText forState:UIControlStateNormal];
        [cancelButton setBackgroundColor:primaryColour];
        [cancelButton.titleLabel setFont:[UIFont fontWithName:fDroidSerifBold size:BUTTON_FONT_SIZE]];
        [cancelButton.titleLabel setTextColor:[UIColor whiteColor]];
        [cancelButton.layer setCornerRadius:5.0f];
        [cancelButton setClipsToBounds:YES];
        [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat alertHeight = CGRectGetMaxY(cancelButton.frame) + BUTTON_BOTTOM_MARGIN;
        
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame) - DEFAULT_ALERT_WIDTH)/2.0f,
                                                                     CGRectGetHeight(self.frame) - DEFAULT_ALERT_BOTTOM_MARGIN - alertHeight,
                                                                     DEFAULT_ALERT_WIDTH,
                                                                     CGRectGetMaxY(cancelButton.frame) + BUTTON_BOTTOM_MARGIN)];
        [alertView setBackgroundColor:[UIColor whiteColor]];
        [alertView.layer setCornerRadius:5.0f];
        [alertView setClipsToBounds:YES];
        
        [alertView addSubview:titleLabel];
        [alertView addSubview:bodyLabel];
        [alertView addSubview:cancelButton];
        
        if (confirmButtonText != nil && confirmButtonText.length > 0)
        {
            [cancelButton setFrame:CGRectMake((DEFAULT_ALERT_WIDTH - BUTTON_WIDTH - BUTTON_WIDTH - BUTTON_MIDDLE_GAP)/2.0f,
                                              CGRectGetMinY(cancelButton.frame),
                                              BUTTON_WIDTH,
                                              BUTTON_HEIGHT)];
            
            UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cancelButton.frame) + BUTTON_MIDDLE_GAP,
                                                                                 CGRectGetMinY(cancelButton.frame),
                                                                                 BUTTON_WIDTH,
                                                                                 BUTTON_HEIGHT)];
            [confirmButton setTitle:confirmButtonText forState:UIControlStateNormal];
            [confirmButton setBackgroundColor:secondaryColor];
            [confirmButton.titleLabel setFont:[UIFont fontWithName:fDroidSerifBold size:BUTTON_FONT_SIZE]];
            [confirmButton.titleLabel setTextColor:[UIColor whiteColor]];
            [confirmButton.layer setCornerRadius:5.0f];
            [confirmButton setClipsToBounds:YES];
            [confirmButton addTarget:self action:@selector(confirmButtonPressed) forControlEvents:UIControlEventTouchUpInside];
            
            [alertView addSubview:confirmButton];
        }
        [self addSubview:alertView];
    }
    return self;
}

#pragma mark - actions

- (void)cancelButtonPressed
{
    if ([self.delegate respondsToSelector:@selector(customAlertViewPressedCancelButton:)])
    {
        [self.delegate customAlertViewPressedCancelButton:self];
    }
    else
    {
        [self removeFromSuperview];
    }
}

- (void)confirmButtonPressed
{
    if ([self.delegate respondsToSelector:@selector(customAlertViewPressedConfirmButton:)])
    {
        [self.delegate customAlertViewPressedConfirmButton:self];
    }
}

@end
