//
//  MDCWordCardView.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 26/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDCPracticeViewController.h"

@class LemniWord;

@interface MDCWordCardView : UIView
@property (nonatomic, strong) LemniWord *word;
@property (nonatomic) MDCPracticeType practiceType;
@end
