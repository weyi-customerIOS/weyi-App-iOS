//
//  SignInViewController.m
//  Weyi
//
//  Created by Dmitry Zubar on 1/20/15.
//  Copyright (c) 2015 Weyimobile Inc. All rights reserved.
//

#import "SignInViewController.h"
#import "weyiLogin.h"
#import "utilities.h"
#import "Constants.h"
#import "CustomAlertView.h"

static NSString * const loginStatusSuccessful = @"Success Login";
static NSString * const loginStatusFailed = @"Fail Login";
static NSString * const failedToLogin = @"Failed to Sign In";

@interface SignInViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputContainerTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *inputContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *emailImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;

@property (strong, nonatomic) NSNumber *inputContainerTopConstant;

- (IBAction)signinButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;
- (IBAction)forgotPasswordButtonPressed:(UIButton *)sender;

@end

@implementation SignInViewController

#pragma mark - lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.emailTextfield setDelegate:self];
    [self.passwordTextfield setDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowNotification:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHideNotification:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    self.inputContainerTopConstant = [NSNumber numberWithFloat:self.inputContainerTopConstraint.constant];
    // Do any additional setup after loading the view from its nib.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            [weakSelf.inputContainerTopConstraint setConstant:weakSelf.inputContainerTopConstant.floatValue - intersectionHeight];
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
        [weakSelf.inputContainerTopConstraint setConstant:weakSelf.inputContainerTopConstant.floatValue];
        [weakSelf.view layoutIfNeeded];
    }];
}

- (void)loginUser
{
    weyiLogin *loginManager = [[weyiLogin alloc] init];
    NSString *loginStatus = [loginManager signIn:self.emailTextfield.text :self.passwordTextfield.text];
    
    if ([loginStatus isEqualToString:loginStatusSuccessful])
    {
        //pass to the app
    }
    else
    {
        CustomAlertView *alertView = [[CustomAlertView alloc] initWithTitle:NSLocalizedString(avTitleWarning, nil)
                                                                       body:NSLocalizedString(failedToLogin, nil)
                                                                   delegate:nil
                                                          cancelButtonTitle:NSLocalizedString(avButtonReturn, nil)
                                                          confirmButtonText:nil];
        [self.view addSubview:alertView];
    }
}

#pragma mark - button actions

- (IBAction)signinButtonPressed:(UIButton *)sender
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
        case 4:
        {
            [self loginUser];
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

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)forgotPasswordButtonPressed:(UIButton *)sender
{
    
}
@end
