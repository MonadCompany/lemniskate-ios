//
//  MDCCollectionTableViewCell.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 24/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCCollectionTableViewCell.h"
#import "LemniCollection.h"

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
        
        UIColor *semiopaqueBalck = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        UIImage *shadedImage = [MDCCollectionTableViewCell colorizeImage:backgroundImage withColor:semiopaqueBalck];
        [(UIImageView *)self.backgroundView setImage:shadedImage];
        
        UIColor *lessSemiopaqueBalck = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        UIImage *lessShadedImage = [MDCCollectionTableViewCell colorizeImage:backgroundImage withColor:lessSemiopaqueBalck];
        [(UIImageView *)self.selectedBackgroundView setImage:lessShadedImage];
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
        background.backgroundColor = [UIColor blackColor];
        background.contentMode = UIViewContentModeScaleAspectFill;
        background.clipsToBounds = YES;
        self.backgroundView = background;

        UIImageView *selectedBackground = [UIImageView new];
        selectedBackground.backgroundColor = [UIColor blackColor];
        selectedBackground.contentMode = UIViewContentModeScaleAspectFill;
        selectedBackground.clipsToBounds = YES;
        self.selectedBackgroundView = selectedBackground;

        // Initialize & Configure Name Label
        self.collectionName = [[UILabel alloc] initWithFrame:CGRectZero];
        
        UIColor *lighterWhite = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        [self.collectionName setTextAlignment:NSTextAlignmentLeft];
        [self.collectionName setTextColor:lighterWhite];
        [self.collectionName setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [self.collectionName setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        [self.contentView addSubview:self.collectionName];

        // Initialize & Configure Comment Label
        self.collectionComment = [[UILabel alloc] initWithFrame:CGRectZero];
        
        [self.collectionComment setTextAlignment:NSTextAlignmentLeft];
        [self.collectionComment setTextColor:[UIColor lightGrayColor]];
        [self.collectionComment setFont:[UIFont systemFontOfSize:14.0f]];
        [self.collectionName setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        [self.contentView addSubview:self.collectionComment];
}
    
    return self;
}

#pragma mark - Laying out subviews

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = self.contentView.frame;
    
    [self.collectionName setFrame:CGRectMake(14.0, 12.0, frame.size.width, 25.0)];
    [self.collectionComment setFrame:CGRectMake(14.0, 12.0 + 25.0, frame.size.width, 25.0)];
}

#pragma mark - Helpers

+ (UIImage *)colorizeImage:(UIImage *)image withColor:(UIColor *)color {
    UIGraphicsBeginImageContext(image.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -area.size.height);
    
    CGContextSaveGState(context);
    CGContextClipToMask(context, area, image.CGImage);
    
    [color set];
    CGContextFillRect(context, area);
    
    CGContextRestoreGState(context);
    
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
    
    CGContextDrawImage(context, area, image.CGImage);
    
    UIImage *colorizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return colorizedImage;
}

@end
