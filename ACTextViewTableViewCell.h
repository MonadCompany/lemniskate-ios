//
//  ACTextViewTableViewCell.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 27/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACTextViewViewController.h"

/// Allows to present ViewController to edit content
@protocol MDCTextViewTableViewCellDelegate <NSObject>
- (void)presentTextViewViewController:(ACTextViewViewController *)controller;
@end


@interface ACTextViewTableViewCell : UITableViewCell

- (instancetype)initWithLabel:(NSString *)label;
+ (instancetype)cellWithLabel:(NSString *)label;

@property (nonatomic, strong) NSString *content;
@property (nonatomic, weak) id <MDCTextViewTableViewCellDelegate> delegate;

@end
