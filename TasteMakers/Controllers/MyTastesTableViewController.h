//
//  MyTastesTableViewController.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 16-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTasteManager.h"
#import "TasteRestaurantsDelegate.h"
#import "UserPreferences.h"

@interface MyTastesTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, TasteRestaurantsDelegate>

@property (weak, nonatomic) IBOutlet UITableView *MyTastersTableView;
@property MyTasteManager * manager;
@property NSArray *restaurants;
@property (strong, nonatomic) UserPreferences *userPreferences;
@end
