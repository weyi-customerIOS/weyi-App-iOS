//
//  RegionViewController.m
//  Weyi
//
//  Created by Dmitry Zubar on 1/23/15.
//  Copyright (c) 2015 Weyimobile Inc. All rights reserved.
//

#import "RegionViewController.h"
#import "weyiContentLayout.h"
#import "Constants.h"

#define SELECTED_BACKGROUND_MARGIN 30.0f
#define CELL_HEIGHT 27.0f
#define CODE_LABEL_WIDTH 55.0f
#define CODE_LABEL_RIGHT_MARGIN 17.0f

static NSString * const cellIdentifier = @"cellIdentifier";
static NSString * const dCountryKey = @"country";
static NSString * const dCodeKey = @"code";

@interface RegionViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *regionTableView;
@property (strong, nonatomic) NSMutableArray *countriesArrayUnsorted;
@property (strong, nonatomic) NSArray *countriesArraySorted;
@property (strong, nonatomic) NSDictionary *selectedDictionary;

- (IBAction)backButtonPressed:(UIButton *)sender;
- (IBAction)nextButtonPressed:(UIButton *)sender;

@end

@implementation RegionViewController

#pragma mark - lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    weyiContentLayout *contentManager = [[weyiContentLayout alloc] init];
    
    NSMutableDictionary *regionDictionary = [contentManager getAllCountryList];
    
    self.countriesArrayUnsorted = [[NSMutableArray alloc] init];
    
    for (NSString *countryKey in [regionDictionary allKeys])
    {
        NSString *phoneCode = [regionDictionary objectForKey:countryKey];
        NSDictionary *countryDictionary = @{dCountryKey: countryKey,
                                            dCodeKey: phoneCode};
        [self.countriesArrayUnsorted addObject:countryDictionary];
    }
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"country"  ascending:YES];
    self.countriesArraySorted = [self.countriesArrayUnsorted sortedArrayUsingDescriptors:@[descriptor]];
    
    [self.regionTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView handling

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.countriesArraySorted.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell setSelectedBackgroundView:[self createSelectedViewForCell]];
    
    NSDictionary *countryDictionary = [self.countriesArraySorted objectAtIndex:indexPath.row];

    for (UIView *subview in [cell.contentView subviews])
    {
        [subview removeFromSuperview];
    }
    
    UILabel *countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(35.0f, 0, CGRectGetWidth(self.regionTableView.frame) - 35.0f - CODE_LABEL_WIDTH - CODE_LABEL_RIGHT_MARGIN, CELL_HEIGHT)];
    [countryLabel setFont:[UIFont fontWithName:fDroidSerif size:17.0f]];
    [countryLabel setTextColor:DEFAULT_TEXT_COLOUR];
    [countryLabel setText:[countryDictionary objectForKey:dCountryKey]];
    
    UILabel *codeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(countryLabel.frame), 0, CODE_LABEL_WIDTH, CELL_HEIGHT)];
    [codeLabel setTextAlignment:NSTextAlignmentRight];
    [codeLabel setFont:[UIFont fontWithName:fDroidSerif size:17.0f]];
    [codeLabel setTextColor:DEFAULT_TEXT_COLOUR];
    [codeLabel setText:[countryDictionary objectForKey:dCodeKey]];
    
    [cell.contentView addSubview:countryLabel];
    [cell.contentView addSubview:codeLabel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *countryDictionary = [self.countriesArraySorted objectAtIndex:indexPath.row];
    self.selectedDictionary = countryDictionary;
}

#pragma mark - private methods

- (UIView *)createSelectedViewForCell
{
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.regionTableView.frame), CELL_HEIGHT)];
    
    UIView *fillView = [[UIView alloc] initWithFrame:CGRectMake(SELECTED_BACKGROUND_MARGIN, 0.0f, CGRectGetWidth(self.regionTableView.frame) - SELECTED_BACKGROUND_MARGIN, CELL_HEIGHT)];
    [fillView setBackgroundColor:[UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:236.0f/255.0f alpha:1.0f]];
    
    UIView *greenLineView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 2.0f, CELL_HEIGHT)];
    [greenLineView setBackgroundColor:[UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:0.0f alpha:1.0f]];
    
    [fillView addSubview:greenLineView];
    
    [containerView addSubview:fillView];
    
    return containerView;
}

#pragma mark - actions
#pragma mark - IBActions

- (IBAction)backButtonPressed:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(regionViewControllerDidPressBack:)])
    {
        [self.delegate regionViewControllerDidPressBack:self];
    }
}

- (IBAction)nextButtonPressed:(UIButton *)sender
{
    if (self.selectedDictionary != nil && [self.delegate respondsToSelector:@selector(regionViewController:didSelectCountryCode:phoneCode:)])
    {
        [self.delegate regionViewController:self didSelectCountryCode:[self.selectedDictionary objectForKey:dCountryKey] phoneCode:[self.selectedDictionary objectForKey:dCodeKey]];
    }
}

@end
