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

@property (nonatomic, strong) UILabel *practiceTextContent;
@property (nonatomic, strong) UIImageView *practiceImageContent;

@property (nonatomic, strong) UIButton *flipButton;
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
        [_practiceTextContent setHidden:YES];
    }
    return _spelling;
}

- (UILabel *)practiceTextContent
{
    if (!_practiceTextContent) {
        _practiceTextContent = [[UILabel alloc] initWithFrame:self.bounds];
        [_practiceTextContent setFont:[UIFont fontWithName:@"American Typewriter" size:64]];
        [_practiceTextContent setTextAlignment:NSTextAlignmentCenter];
        [_practiceTextContent setHidden:YES];
    }
    return _practiceTextContent;
}

- (UIImageView *)practiceImageContent
{
    if (!_practiceImageContent) {
        _practiceImageContent = [[UIImageView alloc] initWithFrame:self.bounds];
        [_practiceImageContent setBackgroundColor:[UIColor whiteColor]];
        [_practiceImageContent setHidden:YES];
    }
    return _practiceImageContent;
}

- (UIButton *)flipButton {
    if (!_flipButton) {
        _flipButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_flipButton setBackgroundColor:[UIColor clearColor]];
        [_flipButton addTarget:self action:@selector(flipCard:) forControlEvents:UIControlEventTouchUpInside];
        //        [_practiceButton setTitle:@"Practice" forState:UIControlStateNormal];
        //        [_practiceButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    }
    return _flipButton;
}

#pragma mark - Setters

- (void)setWord:(LemniWord *)word
{
    _word = word;
    self.spelling.text = word.spelling;
    
    if (word.meaning) {
        self.practiceTextContent.text = word.meaning;
    }
    if (word.picture) {
        UIImage *image = [UIImage imageWithData:word.picture];
        self.practiceImageContent.image = image;
    }
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
    [self addSubview:self.practiceTextContent];
    [self addSubview:self.practiceImageContent];
    
    [self addSubview:self.flipButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.spelling.frame = self.bounds;
}

#pragma mark - Action Handlers

- (void)flipCard:(id)sender
{
    self.practiceImageContent.hidden = YES;
    self.practiceTextContent.hidden = YES;
    self.spelling.hidden = NO;
}


@end
