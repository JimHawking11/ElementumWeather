//
//  EWViewController.m
//  ElementumWeather
//
//  Created by Mike Salkin on 6/29/14.
//  Copyright (c) 2014 MikeSalkin. All rights reserved.
//

#import "EWViewController.h"
#import "EWSideMenuViewController.h"
#import "EWMTLWeather.h"

static NSString * const BaseURLString = @"http://api.openweathermap.org/data/2.5/";

@interface EWViewController ()

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation EWViewController

float longitude;
float latitude;
bool isClosed;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Current Weather";
    //self.view.backgroundColor = [UIColor grayColor];
    
    UIBarButtonItem *openItem = [[UIBarButtonItem alloc] initWithTitle:@"Open" style:UIBarButtonItemStylePlain target:self action:@selector(openButtonPressed)];
    self.navigationItem.leftBarButtonItem = openItem;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    [self.locationManager startUpdatingLocation];
    
    [self.view addSubview:self.details];
    self.details.frame = CGRectMake(0, 538, 320, 165);
    isClosed = true;
}

- (void)openButtonPressed
{
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}

- (IBAction)toggleDetailsShelf:(id)sender{
    
    
    [UIView animateWithDuration:.25 animations:^
    {
        if (isClosed) {
            self.details.frame = CGRectMake(0, 403, 320, 165);
        }else{
            self.details.frame = CGRectMake(0, 538, 320, 165);
        }
    }
    completion:^(BOOL finished){
        isClosed = !isClosed;
    }];
}

- (void)updateWeatherLocal{
    if(latitude != 0 && longitude != 0){
        NSString *connectionString = [NSString stringWithFormat:@"%@weather?lat=%f&lon=%f", BaseURLString, latitude, longitude];
        NSURL *url = [NSURL URLWithString:connectionString];
        [self loadWeather:url];
    }
}

- (void)updateWeatherWithLocation:(NSString*)locationName{
    NSString *connectionString = [NSString stringWithFormat:@"%@weather?q=%@", BaseURLString, locationName];
    NSURL *url = [NSURL URLWithString:connectionString];
    [self loadWeather:url];
}

- (void)loadWeather:(NSURL*)url
{
    // 1

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        EWMTLWeather *weather = [MTLJSONAdapter modelOfClass:EWMTLWeather.class fromJSONDictionary:responseObject error:NULL];
        self.title = weather.locationName;
        self.condition.text = weather.condition;
        self.curTemp.text = [NSString stringWithFormat:@"%d\u00B0", [weather.temperature intValue]];
        self.highTemp.text = [NSString stringWithFormat:@"%d\u00B0", [weather.tempLow intValue]];
        self.lowTemp.text = [NSString stringWithFormat:@"%d\u00B0", [weather.tempHigh intValue]];
        self.humidity.text = [NSString stringWithFormat:@"%d%%", [weather.humidity intValue]];
        self.windspeed.text = [NSString stringWithFormat:@"%d MPH", [weather.windSpeed intValue]];
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"hh:mm a"];
        self.sunrise.text = [dateFormatter stringFromDate:weather.sunrise];
        self.sunset.text = [dateFormatter stringFromDate:weather.sunset];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    [operation start];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    longitude = manager.location.coordinate.longitude;
    latitude = manager.location.coordinate.latitude;
    
    if (oldLocation == nil){
        [self updateWeatherLocal];
    }
}

@end