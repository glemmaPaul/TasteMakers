//
//  FilterManagerDelegate.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 19-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FilterManagerDelegate <NSObject>

-(void) didRetrievedFilters:(NSMutableArray *) filters;
-(void) didFailToRetrieveFilters: (NSError *) error;

@end
