//
//  LabeledFieldTableViewCell.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 29/11/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCLabeledFieldTableViewCell.h"

@interface MDCLabeledFieldTableViewCell ()

@property (nonatomic, strong) UILabel     *uiLabel;
@property (nonatomic, strong) UITextField *uiTextField;

@end

@implementation MDCLabeledFieldTableViewCell

#pragma mark - Getters

- (NSString *)content {
    return self.uiTextField.text;
}

#pragma mark - setters

- (void)setContent:(NSString *)content {
    self.uiTextField.text = content;
}

#pragma mark - General Lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Initialize & Configure text field
        self.uiTextField = [[UITextField alloc] initWithFrame:CGRectZero];
        self.uiTextField.returnKeyType = UIReturnKeyDone;
        [self.contentView addSubview:self.uiTextField];
    }
    
    return self;
}

- (instancetype)initWithLabel:(NSString *)label {
    self = [super init];
    if (self) {
        _label = label;
        self.uiLabel.text = self.label;
        self.uiTextField.placeholder = label;
    }

    return self;
}

+ (instancetype)cellWithLabel:(NSString *)label {
    return [[self alloc] initWithLabel:label];
}

#pragma mark Laying out subviews

- (void)layoutSubviews {
    CGSize size = self.contentView.frame.size;
    CGRect fieldRect = CGRectMake(MarginBetweenControls,
                                  12.0,
                                  size.width - MarginBetweenControls * 2,
                                  25.0);
    [self.uiTextField setFrame:fieldRect];
    
}

@end

