//
//  LabeledFieldTableViewCell.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 29/11/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CellTextFieldWidthPercent 0.6
#define MarginBetweenControls 20.0

@interface MDCLabeledFieldTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel     *label;
@property (nonatomic, strong) UITextField *field;
@end
