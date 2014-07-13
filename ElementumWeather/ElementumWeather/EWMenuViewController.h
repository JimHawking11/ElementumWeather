//
//  EWMenuViewController.h
//  ElementumWeather
//
//  Created by Mike Salkin on 6/29/14.
//  Copyright (c) 2014 MikeSalkin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EWMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSArray *cityList;
@property (nonatomic, strong) IBOutlet UITableView *cities;

@end
