//
//  RegistrationViewController.m
//  Weyi
//
//  Created by Dmitry Zubar on 1/20/15.
//  Copyright (c) 2015 Weyimobile Inc. All rights reserved.
//

#import "RegistrationViewController.h"
#import "FontTextfield.h"
#import "utilities.h"
#import "Constants.h"
#import "CustomAlertView.h"
#import "FontButton.h"
#import "RegionViewController.h"

@interface RegistrationViewController () <CustomAlertViewDelegate, UITextFieldDelegate, RegionViewControllerDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputContainerToNavConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoToNavConstraint;
@property (weak, nonatomic) IBOutlet UIView *inputContainerView;
@property (weak, nonatomic) IBOutlet FontTextfield *emailTextfield;
@property (weak, nonatomic) IBOutlet FontTextfield *phoneTextfield;
@property (weak, nonatomic) IBOutlet FontTextfield *passwordTextfield;
@property (weak, nonatomic) IBOutlet UIImageView *emailImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (weak, nonatomic) IBOutlet FontButton *regionButton;

@property (strong, nonatomic) NSNumber *inputContainerTopConstant;

- (IBAction)registerButtonPressed:(UIButton *)sender;
- (IBAction)termsButtonPressed:(UIButton *)sender;
- (IBAction)backButtonPressed:(UIButton *)sender;
- (IBAction)regionButtonPressed:(UIButton *)sender;

@end

@implementation RegistrationViewController

#pragma mark - lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //we have to adjust constraints manually to fit into iPhone 5/5s height
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGFloat scale = ([mainScreen respondsToSelector:@selector(scale)] ? mainScreen.scale : 1.0f);
    CGFloat pixelHeight = (CGRectGetHeight(mainScreen.bounds) * scale);

    if (scale == 2.0f && pixelHeight == 1136.0f)
    {
        [self.inputContainerToNavConstraint setConstant:self.inputContainerToNavConstraint.constant - 60.0f];
        [self.logoToNavConstraint setConstant:self.logoToNavConstraint.constant - 25.0f];
    }
    
    self.inputContainerTopConstant = [NSNumber numberWithFloat:self.inputContainerToNavConstraint.constant];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - delegates
#pragma mark - UITextfield delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.emailTextfield)
    {
        UIImage *image = [UIImage imageNamed:@"email-icon"];
        
        [self.emailImageView setTintColor:[UIColor clearColor]];
        [self.emailImageView setImage:image];
        [self.emailTextfield setTextColor:DEFAULT_TEXT_COLOUR];
    }
    else if (textField == self.passwordTextfield)
    {
        UIImage *image = [UIImage imageNamed:@"password-icon"];
        
        [self.passwordImageView setTintColor:[UIColor clearColor]];
        [self.passwordImageView setImage:image];
        [self.passwordTextfield setTextColor:DEFAULT_TEXT_COLOUR];
    }
}

#pragma mark - CustomAlertView delegates

- (void)customAlertViewPressedConfirmButton:(CustomAlertView *)alertView
{
    [alertView removeFromSuperview];
    
    //push next screen
    
    utilities *utilsManager = [[utilities alloc] init];
    [utilsManager sendVerCodeToPhone:self.phoneTextfield.text];
}

#pragma mark - RegionViewController delegates

- (void)regionViewControllerDidPressBack:(RegionViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)regionViewController:(RegionViewController *)controller didSelectCountryCode:(NSString *)countryCode phoneCode:(NSString *)phoneCode
{
    [self.regionButton setTitle:countryCode forState:UIControlStateNormal];
    [self.phoneTextfield setText:phoneCode];
    
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - actions
#pragma mark - notifications

- (void)keyboardWillShowNotification:(NSNotification *)notification
{
    NSDictionary *notificationDictionary = [notification userInfo];
    
    CGRect keyboardFrame = [[notificationDictionary objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect intersectionFrame = CGRectIntersection(keyboardFrame, self.inputContainerView.frame);
    CGFloat intersectionHeight = CGRectGetHeight(intersectionFrame);
    
    if (intersectionHeight > 0.0f)
    {
        double animationDuration = [[notificationDictionary objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        __weak typeof(self)weakSelf = self;
        
        [UIView animateWithDuration:animationDuration animations:^{
            [weakSelf.inputContainerToNavConstraint setConstant:weakSelf.inputContainerTopConstant.floatValue - intersectionHeight];
            [weakSelf.view layoutIfNeeded];
        }];
    }
}

- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    NSDictionary *notificationDictionary = [notification userInfo];
    
    double animationDuration = [[notificationDictionary objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    __weak typeof(self)weakSelf = self;
    
    [UIView animateWithDuration:animationDuration animations:^{
        [weakSelf.inputContainerToNavConstraint setConstant:weakSelf.inputContainerTopConstant.floatValue];
        [weakSelf.view layoutIfNeeded];
    }];
}

#pragma mark - IBActions

- (IBAction)registerButtonPressed:(UIButton *)sender
{    
    utilities *utilsManager = [[utilities alloc] init];
    
    int loginCheckStatus = [utilsManager checkAccountValidation:self.emailTextfield.text :self.passwordTextfield.text];
    
    switch (loginCheckStatus)
    {
        case 0:
        {
            CustomAlertView *alertView = [[CustomAlertView alloc] initWithTitle:NSLocalizedString(avTitleWarning, nil)
                                                                           body:NSLocalizedString(avBodyFillAll, nil)
                                                                       delegate:nil
                                                              cancelButtonTitle:NSLocalizedString(avButtonReturn, nil)
                                                              confirmButtonText:nil];
            [self.view addSubview:alertView];
            
            break;
        }
        case 1:
        {
            CustomAlertView *alertView = [[CustomAlertView alloc] initWithTitle:NSLocalizedString(avTitleWarning, nil)
                                                                           body:NSLocalizedString(avBodyEmailExists, nil)
                                                                       delegate:nil
                                                              cancelButtonTitle:NSLocalizedString(avButtonReturn, nil)
                                                              confirmButtonText:nil];
            [self.view addSubview:alertView];

            [self.emailTextfield setTextColor:[UIColor redColor]];
            UIImage *image = [UIImage imageNamed:@"email-icon"];
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            
            [self.emailImageView setTintColor:[UIColor redColor]];
            [self.emailImageView setImage:image];
            
            break;
        }
        case 2:
        {
            CustomAlertView *alertView = [[CustomAlertView alloc] initWithTitle:NSLocalizedString(avTitleWarning, nil)
                                                                           body:NSLocalizedString(avBodyPasswordRequirements, nil)
                                                                       delegate:nil
                                                              cancelButtonTitle:NSLocalizedString(avButtonReturn, nil)
                                                              confirmButtonText:nil];
            [self.view addSubview:alertView];
            
            [self.passwordTextfield setTextColor:[UIColor redColor]];
            UIImage *image = [UIImage imageNamed:@"password-icon"];
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            
            [self.passwordImageView setTintColor:[UIColor redColor]];
            [self.passwordImageView setImage:image];
            
            break;
        }
        case 3:
        {
            CustomAlertView *alertView = [[CustomAlertView alloc] initWithTitle:NSLocalizedString(avTitlePhoneNumberConfirmation, nil)
                                                                           body:[NSString stringWithFormat:@"%@%@", NSLocalizedString(avBodyPhoneNumberConfirmation, nil), self.phoneTextfield.text]
                                                                       delegate:self
                                                              cancelButtonTitle:NSLocalizedString(avButtonReturn, nil)
                                                              confirmButtonText:nil];
            [self.view addSubview:alertView];
            
            break;
        }
        case 4:
        {
            CustomAlertView *alertView = [[CustomAlertView alloc] initWithTitle:NSLocalizedString(avTitleWarning, nil)
                                                                           body:NSLocalizedString(avBodyEmailInvalid, nil)
                                                                       delegate:nil
                                                              cancelButtonTitle:NSLocalizedString(avButtonReturn, nil)
                                                              confirmButtonText:nil];
            [self.view addSubview:alertView];
            
            [self.emailTextfield setTextColor:[UIColor redColor]];
            UIImage *image = [UIImage imageNamed:@"email-icon"];
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            
            [self.emailImageView setTintColor:[UIColor redColor]];
            [self.emailImageView setImage:image];
            
            break;
        }
        default:
        {
            CustomAlertView *alertView = [[CustomAlertView alloc] initWithTitle:NSLocalizedString(avTitleWarning, nil)
                                                                           body:NSLocalizedString(avBodyUnknownError, nil)
                                                                       delegate:nil
                                                              cancelButtonTitle:NSLocalizedString(avButtonReturn, nil)
                                                              confirmButtonText:nil];
            [self.view addSubview:alertView];
            
            break;
        }
    }
}

- (IBAction)termsButtonPressed:(UIButton *)sender
{
    //show terms
}

- (IBAction)backButtonPressed:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)regionButtonPressed:(UIButton *)sender
{
    RegionViewController *regionVC = [[RegionViewController alloc] initWithNibName:NSStringFromClass([RegionViewController class]) bundle:nil];
    [regionVC setDelegate:self];
    
    [self presentViewController:regionVC animated:YES completion:nil];
}
@end
