//
//  EWMenuViewController.m
//  ElementumWeather
//
//  Created by Mike Salkin on 6/29/14.
//  Copyright (c) 2014 MikeSalkin. All rights reserved.
//

#import "EWMenuViewController.h"
#import "EWViewController.h"
#import "EWSideMenuViewController.h"
#import "EWAppDelegate.h"

@interface EWMenuViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) IBOutlet UITextField *cityField;

@end

@implementation EWMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    CGRect imageViewRect = [[UIScreen mainScreen] bounds];
    imageViewRect.size.width += 589;
    self.backgroundImageView.frame = imageViewRect;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.backgroundImageView];
}

//Load Local Weather
- (IBAction)localWeather:(id)sender
{
    EWAppDelegate* appDelegate = (EWAppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.mainViewController updateWeatherLocal];
    [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
    [self.cityField resignFirstResponder];
}

//Load Weather for given city
- (IBAction)cityWeather:(id)sender
{
    EWAppDelegate* appDelegate = (EWAppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.mainViewController updateWeatherWithLocation:self.cityField.text];
    [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
    [self.cityField resignFirstResponder];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
