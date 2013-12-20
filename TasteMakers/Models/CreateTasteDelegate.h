//
//  CreateTasteDelegate.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 16-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CreateTasteDelegate <NSObject>
- (void) savingTasteSuccess: (Restaurant *) restaurantObject;
- (void) errorDuringSavingTaste:(NSError *) error;
@end
