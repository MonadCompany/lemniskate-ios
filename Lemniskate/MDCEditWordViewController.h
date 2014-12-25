//
//  MDCEditWordViewController.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 25/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LemniWord;

@interface MDCEditWordViewController : UIViewController
- (instancetype)initWithWord:(LemniWord *)word;
+ (instancetype)controllerWithWord:(LemniWord *)word;
@end
