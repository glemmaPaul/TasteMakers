//
//  RestaurantPlaceMarkAnnotationView.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 15-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface RestaurantPlaceMarkAnnotationView : MKAnnotationView {
    MKAnnotationView *_parentAnnotationView;
    MKMapView *_mapView;
    CGRect _endFrame;
    UIView *_contentView;
    CGFloat _yShadowOffset;
    CGPoint _offsetFromParent;
    CGFloat _contentHeight;
}

@property (nonatomic, retain) MKAnnotationView *parentAnnotationView;
@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic, readonly) UIView *contentView;
@property (nonatomic) CGPoint offsetFromParent;
@property (nonatomic) CGFloat contentHeight;

- (void)animateIn;
- (void)animateInStepTwo;
- (void)animateInStepThree;

@end