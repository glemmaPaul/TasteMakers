//
//  DetailsChildPageViewController.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 15-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "DetailsChildPageViewController.h"
#import "RestaurantDetailsManager.h"
#import "Filter.h"

@interface DetailsChildPageViewController ()

@end

@implementation DetailsChildPageViewController
@synthesize restaurant, descriptionTextView, titleTextLabel, filtersTextLabel, avatarImageLabel, tasteByTextLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // set the restaurant object
    restaurant = [[RestaurantDetailsManager sharedInstance] getRestaurant];
    NSLog(@"%@", restaurant.description);
    [titleTextLabel setText:restaurant.title];
    [descriptionTextView setText:restaurant.description];
    
    [tasteByTextLabel setText:[[NSString alloc] initWithFormat:@"Taste by @%@", restaurant.user.username]];
    
    if ([restaurant.filters count] > 0) {
        // first we set up a mutable array. To add the names from the filters to it
        NSMutableArray *_filterTextArray = [[NSMutableArray alloc] init];
        
        for (Filter *_filterObject in restaurant.filters) {
            [_filterTextArray addObject:_filterObject.name];
        }
        [filtersTextLabel setText:[[NSString alloc] initWithFormat:@"Filters: %@", [_filterTextArray componentsJoinedByString:@","]]];
        
    }
    else {
        [filtersTextLabel setHidden:YES];
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
