//
//  MDCTextViewTableViewCell.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 27/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCTextViewTableViewCell.h"
#import "MDCControlConstants.h"

@interface MDCTextViewTableViewCell () <MDCTextViewViewControllerDelegate>

@property (nonatomic, strong) UILabel  *placeholderLabel;
@property (nonatomic, strong) UILabel  *contentLabel;
@property (nonatomic, strong) UIView   *background;
@property (nonatomic, strong) UIButton *button;

@end

@implementation MDCTextViewTableViewCell

#pragma mark - Getters

- (NSString *)content
{
    return self.contentLabel.text;
}

- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _placeholderLabel.textColor = MDCPlaceholderLabelColor;
    }
    return _placeholderLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = [UIFont systemFontOfSize:16];
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIView *)background
{
    if (!_background) {
        _background = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _background;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_button addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

#pragma mark - Setters

- (void)setContent:(NSString *)content
{
    self.contentLabel.text = content;
}

#pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Hide separator
        self.layoutMargins = UIEdgeInsetsZero;
        self.separatorInset = UIEdgeInsetsMake(0,1e7,0,0);
        
        // Add subviews
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.placeholderLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.button];
    }
    return self;
}

- (instancetype)initWithLabel:(NSString *)label
{
    self = [super init];
    if (self) {
        self.placeholderLabel.text = label;
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
    [self.placeholderLabel setFrame:CGRectMake(14, 12, size.width - 14*2, 25)];
    
    [self.contentLabel setFrame:CGRectMake(14, 12, size.width - 14*2, size.height - 18)];
    [self.contentLabel sizeToFit];
    
    [self.button setFrame:self.contentView.frame];
}

#pragma mark - MDCTextViewViewControllerDelegate

- (void)finishedEditing:(NSString *)content
{
    self.placeholderLabel.hidden = content.length > 0;
    self.contentLabel.text = content;
    [self layoutSubviews]; // to reposition label, because it's content may changed from "" to something
}

#pragma mark - Actions

- (void)tapped:(id)sender
{
    MDCTextViewViewController *controller = [[MDCTextViewViewController alloc] initWithText:self.contentLabel.text];
    [controller setDelegate:self];
    [self.delegate presentTextViewViewController:controller];
}

@end
