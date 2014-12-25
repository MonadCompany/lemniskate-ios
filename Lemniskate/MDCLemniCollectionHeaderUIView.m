//
//  MDCLemniCollectionHeaderUIView.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 25/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCLemniCollectionHeaderUIView.h"
#import "UIImageCategories.h"
#import "LemniCollection.h"
#import "MDCControlConstants.h"

@interface MDCLemniCollectionHeaderUIView ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) UILabel     *collectionName;
@property (nonatomic, strong) UILabel     *collectionComment;

@property (nonatomic, strong) UIButton    *practiceButton;

@end

static NSString *const WCCellIdentifier = @"WCCellIdentifier";

@implementation MDCLemniCollectionHeaderUIView

#pragma mark - Initializations

- (instancetype)initWithFrame:(CGRect)frame
                   collection:(LemniCollection *)collection
                     delegate:(MDCLemniCollectionHeaderUIViewDelegate) delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        // Set up background
        UIImageView *background = [UIImageView new];
        background.backgroundColor = [UIColor blackColor];
        background.contentMode = UIViewContentModeScaleAspectFill;
        background.clipsToBounds = YES;
        
        UIImage *backgroundImage = [UIImage imageWithData:collection.background];
        [background setImage:[backgroundImage withColor:MDCSemiopaqueBalck]];

        self.background = background;
        [self addSubview:self.background];
        
        // Initialize & Configure Name Label
        self.collectionName = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.collectionName setText:collection.name];
        [self.collectionName setTextAlignment:NSTextAlignmentLeft];
        [self.collectionName setTextColor:[UIColor whiteColor]];
        [self.collectionName setFont:MDCCollectionNameFont];
        [self addSubview:self.collectionName];
        
        // Initialize & Configure Comment Label
        self.collectionComment = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.collectionComment setText:collection.comment];
        [self.collectionComment setTextAlignment:NSTextAlignmentLeft];
        [self.collectionComment setTextColor:MDCLighterWhite];
        [self.collectionComment setFont:MDCCollectionCommentFont];
        [self addSubview:self.collectionComment];
        
        // Initialize & Configure Practice Button
        self.practiceButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.practiceButton.layer.cornerRadius = 4;
        self.practiceButton.tintColor = [UIColor whiteColor];
        [self.practiceButton setBackgroundColor:[UIColor colorWithRed:126.0/256
                                                                green:211.0/256
                                                                 blue:33.0/256
                                                                alpha:1.0]];
        [self.practiceButton setTitle:@"Practice" forState:UIControlStateNormal];
        [self addSubview:self.practiceButton];

        // Add table
        self.tableView.delegate = delegate;
        self.tableView.dataSource = delegate;
        
        [self addSubview:self.tableView];
    }
    
    return self;
}

+ (instancetype)viewWithFrame:(CGRect)frame
                   collection:(LemniCollection *)collection
                     delegate:(MDCLemniCollectionHeaderUIViewDelegate) delegate
{
    return [[self alloc] initWithFrame:frame collection:collection delegate:delegate];
}

#pragma mark - Getters

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.allowsSelection = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:WCCellIdentifier];
    }
    return _tableView;
}

#pragma mark - Interface methods

- (void) reloadData {
    [self.tableView reloadData];
}

#pragma mark - UIView Lifecycle

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect sb = self.bounds;
    
    self.tableView.frame = CGRectMake(sb.origin.x,
                                      sb.origin.y + MDCCollectionViewHeight,
                                      sb.size.width,
                                      sb.size.height - MDCCollectionViewHeight);
    
    self.background.frame = CGRectMake(sb.origin.x, sb.origin.y, sb.size.width, MDCCollectionViewHeight);
    
    self.collectionName.frame = CGRectMake(sb.origin.x + 14.0,
                                           sb.origin.y + 12.0,
                                           sb.size.width,
                                           25.0);
    
    self.collectionComment.frame = CGRectMake(sb.origin.x + 14.0,
                                              sb.origin.y + 12.0 + 30.0,
                                              sb.size.width,
                                              25.0);
    float buttonWidth = 184/2;
    self.practiceButton.frame = CGRectMake(sb.size.width - buttonWidth - 14,
                                           sb.origin.y + 12.0,
                                           buttonWidth,
                                           25.0);
}


@end
