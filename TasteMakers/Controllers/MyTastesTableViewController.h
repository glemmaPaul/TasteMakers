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
#import "CreateTasteDelegate.h"
#import "NotificationManager.h"
#import "NewTasteViewController.h"
@interface MyTastesTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CreateTasteDelegate, TasteRestaurantsDelegate>

@property (weak, nonatomic) IBOutlet UITableView *MyTastersTableView;
@property MyTasteManager * manager;
@property NSMutableArray *restaurants;
@property (strong, nonatomic) UserPreferences *userPreferences;
@property NotificationManager *notificationManager;
@property NewTasteViewController *createTasteViewController;
@end
