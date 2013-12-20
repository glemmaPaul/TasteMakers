//
//  FilterManager.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 19-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FilterManagerDelegate.h"
#import "TasteApiCommunicator.h"
#import "TasteApiCommunicatorDelegate.h"

@interface FilterManager : NSObject <TasteApiCommunicatorDelegate>

@property (strong, nonatomic) NSMutableArray *cachedFilters;
@property TasteApiCommunicator *communicator;

+ (FilterManager*)sharedInstance;
@property (nonatomic, weak) id<FilterManagerDelegate>  delegate;
-(void) getFilters;
@end
