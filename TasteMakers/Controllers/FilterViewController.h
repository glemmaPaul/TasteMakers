//
//  FilterViewController.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 17-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "ViewController.h"
#import "FilterViewControllerDelegate.h"
#import "FilterManager.h"
#import "FilterManagerDelegate.h"

@interface FilterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, FilterManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *filterTableView;
@property (retain, nonatomic) id<FilterViewControllerDelegate> delegate;
-(void) setDelegate:(id<FilterViewControllerDelegate>)delegate;
@property NSMutableArray *selectedFilters;
@property NSMutableArray *filters;
@property FilterManager *manager;
@end
