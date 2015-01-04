//
//  MDCCollectionTableViewCell.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 24/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCCollectionTableViewCell.h"
#import "LemniCollection.h"
#import "UIImage_ColorizeAdditions.h"
#import "MDCControlConstants.h"

@interface MDCCollectionTableViewCell ()

@property (nonatomic, strong) LemniCollection *collection;

@property (nonatomic, strong) UILabel     *collectionName;
@property (nonatomic, strong) UILabel     *collectionComment;

@end

@implementation MDCCollectionTableViewCell

#pragma mark - Initializations

- (instancetype)initWithCollection:(LemniCollection *)collection
{
    self = [super init];
    if (self) {
        self.collection = collection;
        
        [self.collectionName setText:collection.name];
        [self.collectionComment setText:collection.comment];
        
        UIImage *backgroundImage = [UIImage imageWithData:collection.background];
        [(UIImageView *)self.backgroundView setImage:[backgroundImage withColor:MDCSemiopaqueBalck]];
        [(UIImageView *)self.selectedBackgroundView setImage:[backgroundImage withColor:MDCLessSemiopaqueBalck]];
    }
    
    return self;
}

+ (instancetype)cellWithCollection:(LemniCollection *)collection
{
    return [[self alloc] initWithCollection:collection];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Initialize & Configure Backgrounds
        UIImageView *background = [UIImageView new];
        background.backgroundColor = MDCCollectionBackgroundColor;
        background.contentMode = UIViewContentModeScaleAspectFill;
        background.clipsToBounds = YES;
        self.backgroundView = background;

        UIImageView *selectedBackground = [UIImageView new];
        selectedBackground.backgroundColor = MDCCollectionBackgroundColor;
        selectedBackground.contentMode = UIViewContentModeScaleAspectFill;
        selectedBackground.clipsToBounds = YES;
        self.selectedBackgroundView = selectedBackground;

        // Initialize & Configure Name Label
        self.collectionName = [[UILabel alloc] initWithFrame:CGRectZero];
        
        [self.collectionName setTextAlignment:NSTextAlignmentLeft];
        [self.collectionName setTextColor:MDCCollectionNameColor];
        [self.collectionName setFont:MDCCollectionNameFont];
        [self.contentView addSubview:self.collectionName];

        // Initialize & Configure Comment Label
        self.collectionComment = [[UILabel alloc] initWithFrame:CGRectZero];
        
        [self.collectionComment setTextAlignment:NSTextAlignmentLeft];
        [self.collectionComment setTextColor:MDCCollectionCommentColor];
        [self.collectionComment setFont:MDCCollectionCommentFont];
        [self.contentView addSubview:self.collectionComment];
}
    
    return self;
}

#pragma mark - Laying out subviews

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = self.contentView.frame;
    
    [self.collectionName setFrame:CGRectMake(14.0, 12.0, frame.size.width, 25.0)];
    [self.collectionComment setFrame:CGRectMake(14.0, 12.0 + 30.0, frame.size.width, 25.0)];
}


@end
