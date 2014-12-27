//
//  LabeledFieldTableViewCell.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 29/11/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDCTextFieldTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *content;

- (instancetype)initWithLabel:(NSString *)label;
+ (instancetype)cellWithLabel:(NSString *)label;

@end
