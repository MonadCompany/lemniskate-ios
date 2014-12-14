//
//  NewLemniWordForm.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 09/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCNewLemniWordForm.h"
#import "MDCLabeledFieldTableViewCell.h"

@interface MDCNewLemniWordForm () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MDCLabeledFieldTableViewCell *spellingCell;
@property (nonatomic, strong) MDCLabeledFieldTableViewCell *pronunciationCell;
@property (nonatomic, strong) MDCLabeledFieldTableViewCell *meaningCell;

@end

static NSString *const WCCellIdentifier = @"WCCellIdentifier";

@implementation MDCNewLemniWordForm

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

- (MDCLabeledFieldTableViewCell *)spellingCell {
    if (!_spellingCell) {
        _spellingCell = (MDCLabeledFieldTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:WCCellIdentifier];
        _spellingCell.label.text = @"Spelling";
    }
    return _spellingCell;
}

- (MDCLabeledFieldTableViewCell *)pronunciationCell {
    if (!_pronunciationCell) {
        _pronunciationCell = (MDCLabeledFieldTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:WCCellIdentifier];
        _pronunciationCell.label.text = @"Pronunce";
    }
    return _pronunciationCell;
}

- (MDCLabeledFieldTableViewCell *)meaningCell {
    if (!_meaningCell) {
        _meaningCell = (MDCLabeledFieldTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:WCCellIdentifier];
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
