//
//  LabeledFieldTableViewCell.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 29/11/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabeledFieldTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) NSString *value;
@end
