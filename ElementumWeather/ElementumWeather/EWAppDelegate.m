//
//  EWAppDelegate.m
//  ElementumWeather
//
//  Created by Kyara Moss on 6/29/14.
//  Copyright (c) 2014 MikeSalkin. All rights reserved.
//

#import "EWAppDelegate.h"
#import "EWMenuViewController.h"
#import "EWViewController.h"

#import "EWSideMenuViewController.h"

@interface EWAppDelegate ()

@property (nonatomic, strong) EWSideMenuViewController *sideMenuViewController;
@property (nonatomic, strong) EWMenuViewController *menuViewController;
@property (nonatomic, strong) EWViewController *mainViewController;

@end

@implementation EWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.menuViewController = [[EWMenuViewController alloc] initWithNibName:nil bundle:nil];
    self.mainViewController = [[EWViewController alloc] initWithNibName:nil bundle:nil];
    
    self.sideMenuViewController = [[EWSideMenuViewController alloc] initWithMenuViewController:self.menuViewController mainViewController:[[UINavigationController alloc] initWithRootViewController:self.mainViewController]];
    self.sideMenuViewController.shadowColor = [UIColor blackColor];
    self.sideMenuViewController.edgeOffset = (UIOffset) { .horizontal = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 18.0f : 0.0f };
    self.sideMenuViewController.zoomScale = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 0.93f : 0.85f;
    self.sideMenuViewController.delegate = self;
    self.window.rootViewController = self.sideMenuViewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark - EWSideMenuViewControllerDelegate

- (UIStatusBarStyle)sideMenuViewController:(EWSideMenuViewController *)sideMenuViewController statusBarStyleForViewController:(UIViewController *)viewController
{
    if (viewController == self.menuViewController) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

- (void)sideMenuViewControllerWillOpenMenu:(EWSideMenuViewController *)sender {
    NSLog(@"willOpenMenu");
}

- (void)sideMenuViewControllerDidOpenMenu:(EWSideMenuViewController *)sender {
    NSLog(@"didOpenMenu");
}

- (void)sideMenuViewControllerWillCloseMenu:(EWSideMenuViewController *)sender {
    NSLog(@"willCloseMenu");
}

- (void)sideMenuViewControllerDidCloseMenu:(EWSideMenuViewController *)sender {
	NSLog(@"didCloseMenu");
}

@end