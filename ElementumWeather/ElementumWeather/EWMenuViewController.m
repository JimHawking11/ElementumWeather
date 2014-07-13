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
    
    //Get City List
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"City" inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    self.cityList = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cityList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UIFont *myFont = [ UIFont fontWithName: @"Heiti TC Light" size: 14.0 ];
    cell.textLabel.font = myFont;
    cell.backgroundColor = [UIColor redColor];
    cell.textLabel.textColor = [UIColor blackColor];
    
    NSManagedObject *city = [self.cityList objectAtIndex:indexPath.row];
    NSString *cityName = [city valueForKey:@"name"];
    cell.textLabel.text = cityName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSManagedObject *city = [self.cityList objectAtIndex:indexPath.row];
    
    EWAppDelegate* appDelegate = (EWAppDelegate*)[[UIApplication sharedApplication]delegate];
    [appDelegate.mainViewController updateWeatherWithLocation:[city valueForKey:@"name"]];
    [self.sideMenuViewController closeMenuAnimated:YES completion:nil];
    [self.cityField resignFirstResponder];
}

@end
