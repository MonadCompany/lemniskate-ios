//
//  LabeledFieldTableViewCell.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 29/11/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCLabeledFieldTableViewCell.h"

@implementation MDCLabeledFieldTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Initialize & Configure Main Label
        self.label = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.label setTextAlignment:NSTextAlignmentRight];
        [self.label setTextColor:[UIColor lightGrayColor]];
        [self.label setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        [self.contentView addSubview:self.label];
        
        // Initialize & Configure text field
        self.field = [[UITextField alloc] initWithFrame:CGRectZero];
//        self.field.clearsOnBeginEditing = NO;
        self.field.returnKeyType = UIReturnKeyDone;
        [self.contentView addSubview:self.field];
    }
    
    return self;
}

#pragma mark Laying out subviews

- (void)layoutSubviews {
    CGSize size = self.contentView.frame.size;
    CGFloat cappedWidth = size.width - (MarginBetweenControls * 3);
    
    CGRect labelRect = CGRectMake(MarginBetweenControls,
                                  12.0,
                                  cappedWidth * (1 - CellTextFieldWidthPercent),
                                  25.0);
    [self.label setFrame:labelRect];
    
    CGRect fieldRect = CGRectMake((MarginBetweenControls * 2) + labelRect.size.width,
                                  12.0,
                                  cappedWidth * CellTextFieldWidthPercent,
                                  25.0);
    [self.field setFrame:fieldRect];
    
}

@end

