//
//  MDCWordCardView.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 26/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCWordCardView.h"
#import "LemniWord.h"

@interface MDCWordCardView ()
@property (nonatomic, strong) UILabel *spelling;
@end

@implementation MDCWordCardView

#pragma mark - Getters

- (UILabel *)spelling
{
    if (!_spelling) {
        _spelling = [[UILabel alloc] initWithFrame:self.bounds];
        [_spelling setFont:[UIFont fontWithName:@"American Typewriter" size:64]];
        [_spelling setTextAlignment:NSTextAlignmentCenter];
    }
    return _spelling;
}

#pragma mark - Setters

- (void)setWord:(LemniWord *)word
{
    _word = word;
    self.spelling.text = word.spelling;
}

#pragma mark - Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    
    // Shadow
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.33;
    self.layer.shadowOffset = CGSizeMake(0, 1.5);
    self.layer.shadowRadius = 4.0;
    self.layer.shouldRasterize = YES;
    
    // Corner Radius
    self.layer.cornerRadius = 15.0;
    
    [self addSubview:self.spelling];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.spelling.frame = self.bounds;
}


@end
