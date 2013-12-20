//
//  RestaurantPlacemark.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 15-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "RestaurantPlacemark.h"
#import <MapKit/MapKit.h>



@implementation RestaurantPlacemark
@synthesize coordinate;
@synthesize markTitle, markSubTitle;
@synthesize reference;
@synthesize image;


-(void)initWithCoordinate:(CLLocationCoordinate2D)theCoordinate andMarkTitle:(NSString *)theMarkTitle andMarkSubTitle:(NSString *)theMarkSubTitle andReference:(NSNumber *)theReference {
	coordinate = theCoordinate;
    markTitle = theMarkTitle;
    reference = theReference;
    markSubTitle = theMarkSubTitle;
    
	
}


- (NSString *)title {
    return markTitle;
}

- (NSString *)subtitle {
    return markSubTitle;
}

- (NSNumber *)reference {
    return reference;
}

@end