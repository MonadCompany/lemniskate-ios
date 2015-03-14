//
//  ACWordCardView.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 26/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACPracticeViewController.h"

@class LemniWord;

@interface ACWordCardView : UIView
@property (nonatomic, strong) LemniWord *word;
@property (nonatomic) MDCPracticeType practiceType;
@end
