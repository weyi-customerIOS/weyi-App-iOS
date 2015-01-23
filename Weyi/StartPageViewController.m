//
//  StartPageViewController.m
//  Weyi
//
//  Created by Dmitry Zubar on 1/20/15.
//  Copyright (c) 2015 Weyimobile Inc. All rights reserved.
//

#import "StartPageViewController.h"
#import "RegistrationViewController.h"
#import "SelectLanguageViewController.h"
#import "SignInViewController.h"
#import "FontButton.h"
#import "FontLabel.h"

@interface StartPageViewController () <SelectLanguageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet FontButton *languageButton;
@property (weak, nonatomic) IBOutlet FontLabel *mottoLabel;

- (IBAction)signinButtonPressed:(UIButton *)sender;
- (IBAction)registerButtonPressed:(UIButton *)sender;
- (IBAction)languageButtonPressed:(UIButton *)sender;

@end

@implementation StartPageViewController

#pragma mark - lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.mottoLabel.layer setShadowColor:[UIColor colorWithRed:215.0f/255.0f
                                                          green:247.0f/255.0f
                                                           blue:99.0f/255.0f
                                                          alpha:1.0f].CGColor];
    [self.mottoLabel.layer setShadowOpacity:0.7f];
    [self.mottoLabel.layer setShadowRadius:2.0f];
    [self.mottoLabel.layer setShadowOffset:CGSizeMake(0.0f, 0.0f)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegates

- (void)selectLanguageViewController:(SelectLanguageViewController *)controller didSelectLanguage:(NSString *)languageName
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.languageButton setTitle:languageName forState:UIControlStateNormal];
}

#pragma mark - button actions

- (IBAction)signinButtonPressed:(UIButton *)sender
{
    SignInViewController *signInVC = [[SignInViewController alloc] initWithNibName:NSStringFromClass([SignInViewController class]) bundle:nil];
    [self.navigationController pushViewController:signInVC animated:YES];
}

- (IBAction)registerButtonPressed:(UIButton *)sender
{
    RegistrationViewController *registrationViewController = [[RegistrationViewController alloc] initWithNibName:NSStringFromClass([RegistrationViewController class]) bundle:nil];
    [self.navigationController pushViewController:registrationViewController animated:YES];
}

- (IBAction)languageButtonPressed:(UIButton *)sender
{
    SelectLanguageViewController *selectLanguageVC = [[SelectLanguageViewController alloc] initWithNibName:NSStringFromClass([SelectLanguageViewController class]) bundle:nil];
    [selectLanguageVC setDelegate:self];
    [self.navigationController pushViewController:selectLanguageVC animated:YES];
}
@end
