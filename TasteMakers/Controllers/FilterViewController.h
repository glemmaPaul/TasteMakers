//
//  FilterViewController.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 17-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "FilterViewController.h"
#import "FilterViewControllerDelegate.h"
#import "FilterManager.h"
#import "FilterManagerDelegate.h"

@interface FilterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, FilterManagerDelegate> {
    NSMutableArray *selectedFilters;
}
@property (weak, nonatomic) IBOutlet UITableView *filterTableView;
@property (retain, nonatomic) id<FilterViewControllerDelegate> delegate;
-(void) setDelegate:(id<FilterViewControllerDelegate>)delegate;
@property (nonatomic,retain) NSMutableArray *selectedFilters;
@property NSMutableArray *filters;
@property FilterManager *manager;

@end
