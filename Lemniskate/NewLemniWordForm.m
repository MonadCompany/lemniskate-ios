//
//  NewLemniWordForm.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 09/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "NewLemniWordForm.h"
#import "LabeledFieldTableViewCell.h"

@interface NewLemniWordForm ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) LabeledFieldTableViewCell *spellingCell;
@property (nonatomic, strong) LabeledFieldTableViewCell *pronunciationCell;
@property (nonatomic, strong) LabeledFieldTableViewCell *meaningCell;

@end

static NSString *const WCCellIdentifier = @"WCCellIdentifier";

@implementation NewLemniWordForm

#pragma mark - Getters

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.allowsSelection = NO;
        [_tableView registerClass:[LabeledFieldTableViewCell class] forCellReuseIdentifier:WCCellIdentifier];
    }
    return _tableView;
}

- (LabeledFieldTableViewCell *)spellingCell {
    if (!_spellingCell) {
        _spellingCell = (LabeledFieldTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:WCCellIdentifier];
        _spellingCell.label.text = @"Spelling";
    }
    return _spellingCell;
}

- (LabeledFieldTableViewCell *)pronunciationCell {
    if (!_pronunciationCell) {
        _pronunciationCell = (LabeledFieldTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:WCCellIdentifier];
        _pronunciationCell.label.text = @"Pronunce";
    }
    return _pronunciationCell;
}

- (LabeledFieldTableViewCell *)meaningCell {
    if (!_meaningCell) {
        _meaningCell = (LabeledFieldTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:WCCellIdentifier];
        _meaningCell.label.text = @"Meaning";
    }
    return _meaningCell;
}


- (NSString *)spelling {
    return self.spellingCell.field.text;
}

- (NSString *)pronunciation {
    return self.pronunciationCell.field.text;
}

- (NSString *)meaning {
    return self.meaningCell.field.text;
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: return @"Basic Info";
        case 1: return @"Additional data";
        default: return @"";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: return 2;
        case 1: return 1;
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0: return self.spellingCell;
                case 1: return self.pronunciationCell;
                default: return nil;
            }

        case 1:
            switch (indexPath.row) {
                case 0: return self.meaningCell;
                default: return nil;
            }

        default: return nil;
    }
}

@end
