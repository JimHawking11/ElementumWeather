//
//  EWViewController.h
//  ElementumWeather
//
//  Created by Mike Salkin on 6/29/14.
//  Copyright (c) 2014 MikeSalkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface EWViewController : UIViewController <CLLocationManagerDelegate>


@property (nonatomic, strong) IBOutlet UILabel *condition;
@property (nonatomic, strong) IBOutlet UILabel *curTemp;
@property (nonatomic, strong) IBOutlet UILabel *highTemp;
@property (nonatomic, strong) IBOutlet UILabel *lowTemp;

@property (nonatomic, strong) IBOutlet UIView *details;
@property (nonatomic, strong) IBOutlet UILabel *humidity;
@property (nonatomic, strong) IBOutlet UILabel *windspeed;
@property (nonatomic, strong) IBOutlet UILabel *sunrise;
@property (nonatomic, strong) IBOutlet UILabel *sunset;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)updateWeatherLocal;
- (void)updateWeatherWithLocation:(NSString*)locationName;

@end
