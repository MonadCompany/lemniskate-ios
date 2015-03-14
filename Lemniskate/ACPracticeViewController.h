//
//  ACPracticeViewController.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 26/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LemniCollection;

typedef NS_ENUM(NSInteger, MDCPracticeType) {
    MDCPracticeTypeMeaning,
    MDCPracticeTypeUsage,
    MDCPracticeTypePicture
};

@interface ACPracticeViewController : UIViewController

@property (nonatomic, strong) LemniCollection *collection;
@property (nonatomic) MDCPracticeType practiceType;

- (instancetype)initWithType:(MDCPracticeType)type collection:(LemniCollection *)collection;
+ (instancetype)controllerWithType:(MDCPracticeType)type collection:(LemniCollection *)collection;

@end
