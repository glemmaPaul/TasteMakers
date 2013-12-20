//
//  DetailsChildPageViewController.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 15-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "DetailsChildPageViewController.h"
#import "RestaurantDetailsManager.h"

@interface DetailsChildPageViewController ()

@end

@implementation DetailsChildPageViewController
@synthesize restaurant, descriptionTextView, titleTextLabel;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
