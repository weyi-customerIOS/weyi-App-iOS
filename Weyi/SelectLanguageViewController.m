//
//  SelectLanguageViewController.m
//  Weyi
//
//  Created by Dmitry Zubar on 1/20/15.
//  Copyright (c) 2015 Weyimobile Inc. All rights reserved.
//

#import "SelectLanguageViewController.h"

static NSString * const cellIdentifier = @"cellIdentifier";

@interface SelectLanguageViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *languageTableView;
@property (strong, nonatomic) NSArray *languageArray;

@end

@implementation SelectLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.languageArray = @[@"test1", @"test2"];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.languageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell.textLabel setText:[self.languageArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *languageName = [self.languageArray objectAtIndex:indexPath.row];
    
    if ([self.delegate respondsToSelector:@selector(selectLanguageViewController:didSelectLanguage:)])
    {
        [self.delegate selectLanguageViewController:self didSelectLanguage:languageName];
    }
}

@end
