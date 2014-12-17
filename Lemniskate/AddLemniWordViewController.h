//
//  AddLemniWordViewController.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 09/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LemniCollection;

@interface AddLemniWordViewController : UIViewController
- (instancetype)initWithCollection:(LemniCollection *)collection;
+ (instancetype)controllerWithCollection:(LemniCollection *)collection;
@end
