//
//  EWMTLWeather.m
//  ElementumWeather
//
//  Created by Michael Salkin on 7/9/14.
//  Copyright (c) 2014 MikeSalkin. All rights reserved.
//

#import "EWMTLWeather.h"

@implementation EWMTLWeather

//Key Map
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"date": @"dt",
             @"locationName": @"name",
             @"humidity": @"main.humidity",
             @"temperature": @"main.temp",
             @"tempHigh": @"main.temp_max",
             @"tempLow": @"main.temp_min",
             @"sunrise": @"sys.sunrise",
             @"sunset": @"sys.sunset",
             @"conditionDescription": @"weather.description",
             @"condition": @"weather.main",
             @"icon": @"weather.icon",
             @"windBearing": @"wind.deg",
             @"windSpeed": @"wind.speed"
             };
}

//Data Transformers
+ (NSValueTransformer *)dateJSONTransformer {
    // 1
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
        return [NSDate dateWithTimeIntervalSince1970:str.floatValue];
    } reverseBlock:^(NSDate *date) {
        return [NSString stringWithFormat:@"%f",[date timeIntervalSince1970]];
    }];
}

+ (NSValueTransformer *)tempJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *calvin) {
        float temp = ((calvin.floatValue - CALVIN_TO_CELSIUS) * 1.8f) + 32;
        return @(temp);
    } reverseBlock:^(NSNumber *fahrenheit) {
        float temp = ((fahrenheit.floatValue - 32) / 1.8f) - CALVIN_TO_CELSIUS;
        return @(temp);
    }];
}

+ (NSValueTransformer *)sunriseJSONTransformer {
    return [self dateJSONTransformer];
}

+ (NSValueTransformer *)sunsetJSONTransformer {
    return [self dateJSONTransformer];
}

+ (NSValueTransformer *)temperatureJSONTransformer {
    return [self tempJSONTransformer];
}

+ (NSValueTransformer *)tempHighJSONTransformer {
    return [self tempJSONTransformer];
}

+ (NSValueTransformer *)tempLowJSONTransformer {
    return [self tempJSONTransformer];
}


+ (NSValueTransformer *)conditionDescriptionJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *values) {
        return [values firstObject];
    } reverseBlock:^(NSString *str) {
        return @[str];
    }];
}

+ (NSValueTransformer *)conditionJSONTransformer {
    return [self conditionDescriptionJSONTransformer];
}

+ (NSValueTransformer *)iconJSONTransformer {
    return [self conditionDescriptionJSONTransformer];
}

+ (NSValueTransformer *)windSpeedJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *num) {
        return @(num.floatValue*MPS_TO_MPH);
    } reverseBlock:^(NSNumber *speed) {
        return @(speed.floatValue/MPS_TO_MPH);
    }];
}

@end
