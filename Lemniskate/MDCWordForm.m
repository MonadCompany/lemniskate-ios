//
//  NewLemniWordForm.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 09/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCWordForm.h"
#import "MDCLabeledFieldTableViewCell.h"
#import "MDCImagePickerTableViewCell.h"
#import "MDCAppDelegate.h"
#import "LemniWord.h"
#import "LemniWordPicture.h"


@interface MDCWordForm () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) MDCLabeledFieldTableViewCell *spellingCell;
@property (nonatomic, strong) MDCLabeledFieldTableViewCell *meaningCell;
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

- (MDCImagePickerTableViewCell *)imageCell {
    if (!_imageCell) {
        _imageCell = [MDCImagePickerTableViewCell new];
        _imageCell.cropSize = CGSizeMake(500, 500);
    }
    return _imageCell;
}

- (LemniWord *)word {
    _word.spelling = self.spellingCell.content;
    _word.meaning  = self.meaningCell.content;
    
    if (self.imageCell.image != nil) {
        LemniWordPicture *picture = nil;
        if (_word.pictures.count == 0) {
            MDCAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"LemniWordPicture"
                                                      inManagedObjectContext:delegate.managedObjectContext];
            picture = (LemniWordPicture *)[[NSManagedObject alloc] initWithEntity:entity
                                                 insertIntoManagedObjectContext:delegate.managedObjectContext];
            [_word addPicturesObject:picture];
        } else {
            picture = [_word.pictures anyObject];
        }
        
        picture.data = UIImagePNGRepresentation(self.imageCell.image);
    }

    return _word;
}

#pragma mark - Setters

- (void)setWord:(LemniWord *)word {
    _word = word;
    self.spellingCell.content = word.spelling;
    self.meaningCell.content  = word.meaning;
    
    if (word.pictures.count > 0) {
        LemniWordPicture *picture = (LemniWordPicture *)[word.pictures anyObject];
        UIImage *image = [UIImage imageWithData:picture.data];
        self.imageCell.image = image;
    }
}

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: return @"Info";
        case 1: return @"Picture";
        default: return @"";
    }
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
                case 1: return self.meaningCell;
                default: return nil;
            }

        case 1:
            switch (indexPath.row) {
                default: return self.imageCell;
            }

        default: return nil;
    }
}

@end
