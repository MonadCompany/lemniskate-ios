//
//  LabeledFieldTableViewCell.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 29/11/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "ACTextFieldTableViewCell.h"

@interface ACTextFieldTableViewCell () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@end

@implementation ACTextFieldTableViewCell

#pragma mark - Getters

- (NSString *)content
{
    return self.textField.text;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectZero];
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.delegate = self;
    }
    return _textField;
}

#pragma mark - Setters

- (void)setContent:(NSString *)content
{
    self.textField.text = content;
}

#pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.textField];
    }
    return self;
}

- (instancetype)initWithLabel:(NSString *)label
{
    self = [super init];
    if (self) {
        self.textField.placeholder = label;
    }
    return self;
}

+ (instancetype)cellWithLabel:(NSString *)label
{
    return [[self alloc] initWithLabel:label];
}

#pragma mark Laying out subviews

- (void)layoutSubviews
{
    CGSize size = self.contentView.frame.size;
    CGRect fieldRect = CGRectMake(14, 12.0, size.width - 14 * 2, 25.0);
    [self.textField setFrame:fieldRect];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end

