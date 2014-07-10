//
//  EWMTLWeather.h
//  ElementumWeather
//
//  Created by Michael Salkin on 7/9/14.
//  Copyright (c) 2014 MikeSalkin. All rights reserved.
//

#import <Mantle/Mantle.h>

#define MPS_TO_MPH 2.23694f
#define CALVIN_TO_CELSIUS 273.15f


@interface EWMTLWeather : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSNumber *humidity;
@property (nonatomic, strong) NSNumber *temperature;
@property (nonatomic, strong) NSNumber *tempHigh;
@property (nonatomic, strong) NSNumber *tempLow;
@property (nonatomic, strong) NSString *locationName;
@property (nonatomic, strong) NSDate *sunrise;
@property (nonatomic, strong) NSDate *sunset;
@property (nonatomic, strong) NSString *conditionDescription;
@property (nonatomic, strong) NSString *condition;
@property (nonatomic, strong) NSNumber *windBearing;
@property (nonatomic, strong) NSNumber *windSpeed;
@property (nonatomic, strong) NSString *icon;

@end
