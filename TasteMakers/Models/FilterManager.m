//
//  FilterManager.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 19-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "FilterManager.h"
#import "TasteApiCommunicator.h"
#import "Filter.h"


@implementation FilterManager
@synthesize cachedFilters;

+ (FilterManager *)sharedInstance
{
    static FilterManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id) init {
    
    self.communicator = [[TasteApiCommunicator alloc] init];
    self.communicator.delegate = self;
    
    
    return self;
}

- (void) didReceiveData:(NSMutableDictionary *)jsonData {
    
    NSMutableArray *filterData = [jsonData valueForKey:@"results"];
    
    cachedFilters = [[NSMutableArray alloc] init];
    
    for (NSDictionary *filterDict in filterData) {
        
        Filter *_filter = [[Filter alloc] init];
        _filter.name = [filterDict valueForKey:@"name"];
        _filter.identifier = [filterDict valueForKey:@"id"];
        
        [cachedFilters addObject:_filter];
        
    }
    [self.delegate didRetrievedFilters:cachedFilters];
}

- (void) fetchingError:(NSError *)error {
    [self.delegate didFailToRetrieveFilters:error];
}


- (void) getFilters {
    
    if ([self.cachedFilters count] != 0) {
        
        [self.delegate didRetrievedFilters:self.cachedFilters];

        
    }
    else {
        [self.communicator getFilters];
    }
    
}
@end
