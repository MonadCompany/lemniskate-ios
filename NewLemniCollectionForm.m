//
// Created by Chebotaev Anton on 09/12/14.
// Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "NewLemniCollectionForm.h"
#import "LabeledFieldTableViewCell.h"

@interface NewLemniCollectionForm ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LabeledFieldTableViewCell *nameCell;
@property (nonatomic, strong) LabeledFieldTableViewCell *commentCell;

@end

static NSString *const WCCellIdentifier = @"WCCellIdentifier";

@implementation NewLemniCollectionForm

#pragma mark - Getters

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.allowsSelection = NO;
        [_tableView registerClass:[LabeledFieldTableViewCell class] forCellReuseIdentifier:WCCellIdentifier];
    }
    return _tableView;
}

- (LabeledFieldTableViewCell *)nameCell {
    if (!_nameCell) {
        _nameCell = (LabeledFieldTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:WCCellIdentifier];
        _nameCell.label.text = @"Name";
    }
    return _nameCell;
}

- (LabeledFieldTableViewCell *)commentCell {
    if (!_commentCell) {
        _commentCell = (LabeledFieldTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:WCCellIdentifier];
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
        [self.tableView setFrame:frame];
        [self addSubview:self.tableView];
    }
    return self;
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