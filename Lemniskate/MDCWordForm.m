//
//  NewLemniWordForm.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 09/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCWordForm.h"
#import "MDCTextFieldTableViewCell.h"
#import "MDCTextViewTableViewCell.h"
#import "MDCImagePickerTableViewCell.h"
#import "MDCAppDelegate.h"
#import "LemniWord.h"


@interface MDCWordForm () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MDCTextFieldTableViewCell *spellingCell;
@property (nonatomic, strong) MDCTextFieldTableViewCell *meaningCell;
@property (nonatomic, strong) MDCTextViewTableViewCell *usageCell;
@property (nonatomic, strong) MDCImagePickerTableViewCell  *imageCell;

@end

@implementation MDCWordForm

@synthesize word = _word;

#pragma mark - Getters

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.allowsSelection = NO;
    }
    return _tableView;
}

- (MDCTextFieldTableViewCell *)spellingCell
{
    if (!_spellingCell) {
        _spellingCell = [MDCTextFieldTableViewCell cellWithLabel:@"Spelling"];
    }
    return _spellingCell;
}

- (MDCTextFieldTableViewCell *)meaningCell
{
    if (!_meaningCell) {
        _meaningCell = [MDCTextFieldTableViewCell cellWithLabel:@"Meaning"];
    }
    return _meaningCell;
}

- (MDCTextViewTableViewCell *)usageCell
{
    if (!_usageCell) {
        _usageCell = [MDCTextViewTableViewCell cellWithLabel:@"Usage Example"];
    }
    return _usageCell;
}

- (MDCImagePickerTableViewCell *)imageCell
{
    if (!_imageCell) {
        _imageCell = [MDCImagePickerTableViewCell new];
        _imageCell.cropSize = CGSizeMake(500, 500);
    }
    return _imageCell;
}

- (LemniWord *)word
{
    _word.spelling = self.spellingCell.content;
    _word.meaning  = self.meaningCell.content;
    _word.usage    = self.usageCell.content;
    
    if (self.imageCell.image != nil) {
        _word.picture = UIImagePNGRepresentation(self.imageCell.image);
    }

    return _word;
}

#pragma mark - Setters

- (void)setWord:(LemniWord *)word {
    _word = word;
    self.spellingCell.content = word.spelling;
    self.meaningCell.content  = word.meaning;
    self.usageCell.content    = word.usage;
    
    if (word.picture) {
        UIImage *image = [UIImage imageWithData:word.picture];
        self.imageCell.image = image;
    }
}

- (void)setPhotoPickerDelegate:(id <MDCPhotoPickerDelegate>)delegate {
    self.imageCell.photoPickerDelegate = delegate;
}

- (void)setTextViewDelegate:(id<MDCTextViewTableViewCellDelegate>)delegate
{
    self.usageCell.delegate = delegate;
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0: return @"Info";
        case 1: return @"Usage Example";
        case 2: return @"Picture";
        default: return @"";
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0: return 2;
        case 1: return 1;
        case 2: return 1;
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
                default: return self.usageCell;
            }
            
        case 2:
            switch (indexPath.row) {
                default: return self.imageCell;
            }

        default: return nil;
    }
}

/* For image cell set higher height */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1: return MDCCollectionViewHeight;
        case 2: return MDCCollectionViewHeight;
        default: return UITableViewAutomaticDimension;
    }
}

@end
