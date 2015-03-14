//
// Created by Chebotaev Anton on 09/12/14.
// Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "ACCollectionForm.h"
#import "ACTextFieldTableViewCell.h"
#import "ACImagePickerTableViewCell.h"
#import "MDCControlConstants.h"

@interface ACCollectionForm () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ACTextFieldTableViewCell *nameCell;
@property (nonatomic, strong) ACTextFieldTableViewCell *commentCell;
@property (nonatomic, strong) ACImagePickerTableViewCell *imageCell;


@end

@implementation ACCollectionForm

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

- (ACTextFieldTableViewCell *)nameCell {
    if (!_nameCell) {
        _nameCell = [[ACTextFieldTableViewCell alloc] initWithLabel:@"Name"];
    }
    return _nameCell;
}

- (ACTextFieldTableViewCell *)commentCell {
    if (!_commentCell) {
        _commentCell = [[ACTextFieldTableViewCell alloc] initWithLabel:@"Comment"];
    }
    return _commentCell;
}

- (ACImagePickerTableViewCell *)imageCell {
    if (!_imageCell) {
        _imageCell = [ACImagePickerTableViewCell new];
        _imageCell.cropSize = CGSizeMake(MDCCollectionViewWidth, MDCCollectionViewHeight);
    }
    return _imageCell;
}

- (NSString *)name {
    return _nameCell.content;
}

- (NSString *)comment {
    return _commentCell.content;
}

- (UIImage *)background {
    return self.imageCell.image;
}

- (id <MDCPhotoPickerDelegate>)photoPickerDelegate {
    return self.imageCell.photoPickerDelegate;
}

#pragma mark - Setters

- (void)setPhotoPickerDelegate:(id <MDCPhotoPickerDelegate>)delegate {
    self.imageCell.photoPickerDelegate = delegate;
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
        case 1: return @"Background";
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
                case 0: return self.nameCell;
                case 1: return self.commentCell;
                default: return nil;
            }
            
        case 1:
            switch (indexPath.row) {
                case 0: return self.imageCell;
                default: return nil;
            }
            
        default: return nil;
    }
}

/* For image cell set higher height */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1: return MDCCollectionViewHeight;
        default: return UITableViewAutomaticDimension;
    }
}

@end