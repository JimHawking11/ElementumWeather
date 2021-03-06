//
//  EWAppDelegate.h
//  ElementumWeather
//
//  Created by Mike Salkin on 6/29/14.
//  Copyright (c) 2014 MikeSalkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWSideMenuViewController.h"
#import "EWMenuViewController.h"

@interface EWAppDelegate : UIResponder <UIApplicationDelegate, EWSideMenuViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) EWSideMenuViewController *sideMenuViewController;
@property (nonatomic, strong) EWMenuViewController *menuViewController;
@property (nonatomic, strong) EWViewController *mainViewController;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory;
- (void) saveContext;

@end
