//
//  SelectLanguageViewController.h
//  Weyi
//
//  Created by Dmitry Zubar on 1/20/15.
//  Copyright (c) 2015 Weyimobile Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectLanguageViewControllerDelegate;

@interface SelectLanguageViewController : UIViewController

@property (nonatomic, weak) id<SelectLanguageViewControllerDelegate>delegate;

@end

@protocol SelectLanguageViewControllerDelegate <NSObject>

- (void)selectLanguageViewController:(SelectLanguageViewController *)controller didSelectLanguage:(NSString *)languageName;

@end
