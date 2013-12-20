//
//  RestaurantPlacemark.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 15-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface RestaurantPlacemark : NSObject <MKAnnotation> {
    CLLocationCoordinate2D coordinate;
    NSString *markTitle, *markSubTitle;
    NSNumber *reference;
    NSString *image;
    
    
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *markTitle, *markSubTitle;
@property (nonatomic, readonly) NSNumber *reference;
@property (nonatomic, readonly) NSString *image;



-(void)initWithCoordinate:(CLLocationCoordinate2D)theCoordinate andMarkTitle:(NSString *)theMarkTitle andMarkSubTitle:(NSString *)theMarkSubTitle andReference:(NSNumber *)theReference;

@end
