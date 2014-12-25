//
//  NewLemniWordForm.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 09/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCNewLemniWordForm.h"
#import "MDCLabeledFieldTableViewCell.h"
#import "LemniWord.h"

@interface MDCNewLemniWordForm () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MDCLabeledFieldTableViewCell *spellingCell;
@property (nonatomic, strong) MDCLabeledFieldTableViewCell *meaningCell;

@end

@implementation MDCNewLemniWordForm

@synthesize word = _word;

#pragma mark - Getters

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.allowsSelection = NO;
    }
    return _tableView;
}

- (MDCLabeledFieldTableViewCell *)spellingCell {
    if (!_spellingCell) {
        _spellingCell = [[MDCLabeledFieldTableViewCell alloc] initWithLabel:@"Spelling"];
    }
    return _spellingCell;
}

- (MDCLabeledFieldTableViewCell *)meaningCell {
    if (!_meaningCell) {
        _meaningCell = [[MDCLabeledFieldTableViewCell alloc] initWithLabel:@"Meaning"];
    }
    return _meaningCell;
}

- (LemniWord *)word {
    _word.spelling = self.spellingCell.content;
    _word.meaning  = self.meaningCell.content;
    
    return _word;
}

#pragma mark - Setters

- (void)setWord:(LemniWord *)word {
    _word = word;

    self.spellingCell.content = word.spelling;
    self.meaningCell.content  = word.meaning;
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
    return @"";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: return 2;
        case 1: return 0;
        default: return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0: return self.spellingCell;
                case 1: return self.meaningCell;
                default: return nil;
            }

        case 1:
            switch (indexPath.row) {
                default: return nil;
            }

        default: return nil;
    }
}

@end
