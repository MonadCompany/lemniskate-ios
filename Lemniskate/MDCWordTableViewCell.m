//
//  MDCWordTableCellView.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 26/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCWordTableViewCell.h"
#import "LemniWord.h"

@interface MDCWordTableViewCell ()
@property (nonatomic, strong) UIImageView *usagesPresented;
@property (nonatomic, strong) UIImageView *imagesPresented;
@end

@implementation MDCWordTableViewCell

#pragma mark - Initializations

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self.contentView addSubview:self.usagesPresented];
        [self.contentView addSubview:self.imagesPresented];
    }
    
    return self;
}

#pragma mark - Getters

- (UIImageView *)usagesPresented {
    if (!_usagesPresented) {
        _usagesPresented = [UIImageView new];
        _usagesPresented.contentMode = UIViewContentModeScaleAspectFill;
        _usagesPresented.clipsToBounds = YES;
        [_usagesPresented setImage:[UIImage imageNamed:@"usage-icon"]];
    }
    return _usagesPresented;
}

- (UIImageView *)imagesPresented {
    if (!_imagesPresented) {
        _imagesPresented = [UIImageView new];
        _imagesPresented.contentMode = UIViewContentModeScaleAspectFill;
        _imagesPresented.clipsToBounds = YES;
        [_imagesPresented setImage:[UIImage imageNamed:@"image-icon"]];
    }
    return _imagesPresented;
}

#pragma mark - Setters

- (void)setWord:(LemniWord *)word {
    _word = word;
    self.textLabel.text = word.spelling;
}

#pragma mark - UIView Lifecycle

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect cb = self.contentView.bounds;
    CGSize imagesPresentedSize = self.imagesPresented.image.size;
    CGSize usagesPresentedSize = self.usagesPresented.image.size;
    
    if (self.word.pictures.count > 0) {
        self.imagesPresented.frame = CGRectMake(-10 + cb.origin.x + cb.size.width - imagesPresentedSize.width,
                                                cb.origin.y + 43.0/2 - imagesPresentedSize.height/2,
                                                imagesPresentedSize.width,
                                                imagesPresentedSize.height);
    } else {
        self.imagesPresented.frame = CGRectZero;
    }
    
    if (self.word.usages.count > 0) {
        self.usagesPresented.frame = CGRectMake(-10 + cb.origin.x + cb.size.width - imagesPresentedSize.width - 10 - usagesPresentedSize.width,
                                                cb.origin.y + 43.0/2 - usagesPresentedSize.height/2,
                                                usagesPresentedSize.width,
                                                usagesPresentedSize.height);
    } else {
        self.usagesPresented.frame = CGRectZero;
    }

}

@end
