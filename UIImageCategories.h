//
//  UIImageCategories.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 25/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorizedImage)

+ (UIImage *)colorizeImage:(UIImage *)image withColor:(UIColor *)color;
- (UIImage *)withColor:(UIColor *)color;

@end
