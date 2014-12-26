//
//  MDCLemniCollectionHeaderUIView.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 25/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "UIImageCategories.h"
#import "LemniCollection.h"
#import "MDCControlConstants.h"
#import "MDCCollectionWithHeaderForm.h"
#import "MDCWordTableViewCell.h"

@interface MDCCollectionWithHeaderForm ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) UILabel     *collectionName;
@property (nonatomic, strong) UILabel     *collectionComment;

@property (nonatomic, strong) UIButton    *practiceButton;

@end

@implementation MDCCollectionWithHeaderForm

#pragma mark - Initializations

- (instancetype)initWithFrame:(CGRect)frame
                   collection:(LemniCollection *)collection
                 dataDelegate:(MDCLemniCollectionDataDelegate) delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        // Set up background
        UIImageView *background = [UIImageView new];
        background.backgroundColor = MDCCollectionBackgroundColor;
        background.contentMode = UIViewContentModeScaleAspectFill;
        background.clipsToBounds = YES;
        
        UIImage *backgroundImage = [UIImage imageWithData:collection.background];
        [background setImage:[backgroundImage withColor:MDCSemiopaqueBalck]];

        self.background = background;
        [self addSubview:self.background];
        
        // Configure & add name label
        [self.collectionName setText:collection.name];
        [self addSubview:self.collectionName];
        
        // Configure & add comment label
        [self.collectionComment setText:collection.comment];
        [self addSubview:self.collectionComment];
        
        // Configure & add practice button
        [self addSubview:self.practiceButton];

        // Configure & add table
        self.tableView.delegate = delegate;
        self.tableView.dataSource = delegate;
        [self addSubview:self.tableView];
    }
    
    return self;
}

+ (instancetype)viewWithFrame:(CGRect)frame
                   collection:(LemniCollection *)collection
                 dataDelegate:(MDCLemniCollectionDataDelegate) delegate
{
    return [[self alloc] initWithFrame:frame collection:collection dataDelegate:delegate];
}

#pragma mark - Getters

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[MDCWordTableViewCell class] forCellReuseIdentifier:MDCWordTableCellViewReuseIdentifier];
    }
    return _tableView;
}

- (UIButton *)practiceButton {
    if (!_practiceButton) {
        _practiceButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _practiceButton.tintColor = [UIColor whiteColor];
        [_practiceButton setBackgroundColor:MDCPracticeButtonColor];
        [_practiceButton setTitle:@"Practice" forState:UIControlStateNormal];
        [_practiceButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_practiceButton addTarget:self.practiceDelegate action:@selector(startPractice:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _practiceButton;
}

- (UILabel *)collectionName {
    if (!_collectionName) {
        _collectionName = [[UILabel alloc] initWithFrame:CGRectZero];
        [_collectionName setTextAlignment:NSTextAlignmentLeft];
        [_collectionName setTextColor:MDCCollectionNameColor];
        [_collectionName setFont:MDCCollectionNameFont];
    }
    return _collectionName;
}

- (UILabel *)collectionComment {
    if (!_collectionComment) {
        _collectionComment = [[UILabel alloc] initWithFrame:CGRectZero];
        [_collectionComment setTextAlignment:NSTextAlignmentLeft];
        [_collectionComment setTextColor:MDCCollectionCommentColor];
        [_collectionComment setFont:MDCCollectionCommentFont];
        
    }
    return _collectionComment;
}

#pragma mark - UIView Lifecycle

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect sb = self.bounds;
    
    self.background.frame = CGRectMake(sb.origin.x, sb.origin.y, sb.size.width, MDCCollectionViewHeight);
    
    self.collectionName.frame = CGRectMake(sb.origin.x + 14.0,
                                           sb.origin.y + 12.0,
                                           sb.size.width,
                                           25.0);
    
    self.collectionComment.frame = CGRectMake(sb.origin.x + 14.0,
                                              sb.origin.y + 12.0 + 30.0,
                                              sb.size.width,
                                              25.0);
    float practiceButtonHeight = 43;
    self.practiceButton.frame = CGRectMake(sb.origin.x,
                                           MDCCollectionViewHeight,
                                           sb.size.width,
                                           practiceButtonHeight);
    
    self.tableView.frame = CGRectMake(sb.origin.x,
                                      sb.origin.y + MDCCollectionViewHeight + practiceButtonHeight,
                                      sb.size.width,
                                      sb.size.height - MDCCollectionViewHeight);
}

#pragma mark - Selectors

- (void)startPractice:(id)sender {
    [self.practiceDelegate startPractice:sender];
}

@end
