//
// Created by Chebotaev Anton on 09/12/14.
// Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCNewLemniCollectionForm.h"
#import "MDCLabeledFieldTableViewCell.h"

@interface MDCNewLemniCollectionForm ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MDCLabeledFieldTableViewCell *nameCell;
@property (nonatomic, strong) MDCLabeledFieldTableViewCell *commentCell;

@end

static NSString *const WCCellIdentifier = @"WCCellIdentifier";

@implementation MDCNewLemniCollectionForm

#pragma mark - Getters

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.allowsSelection = NO;
        [_tableView registerClass:[MDCLabeledFieldTableViewCell class] forCellReuseIdentifier:WCCellIdentifier];
    }
    return _tableView;
}

- (MDCLabeledFieldTableViewCell *)nameCell {
    if (!_nameCell) {
        _nameCell = (MDCLabeledFieldTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:WCCellIdentifier];
        _nameCell.label.text = @"Name";
    }
    return _nameCell;
}

- (MDCLabeledFieldTableViewCell *)commentCell {
    if (!_commentCell) {
        _commentCell = (MDCLabeledFieldTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:WCCellIdentifier];
        _commentCell.label.text = @"Comment";
    }
    return _commentCell;
}

- (NSString *)name {
    return _nameCell.field.text;
}

- (NSString *)comment {
    return _commentCell.field.text;
}

#pragma mark - UIView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0: return self.nameCell;
        case 1: return self.commentCell;
        default: return nil; // dunno, should app drop dead?
    }
}

@end