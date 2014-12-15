//
//  MDCImagePickerTableViewCell.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 15/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCImagePickerTableViewCell.h"
#import "DZNPhotoPickerController.h"

@interface MDCImagePickerTableViewCell () <UINavigationControllerDelegate, DZNPhotoPickerControllerDelegate>
@property (nonatomic, strong) UIButton *button;
@end


@implementation MDCImagePickerTableViewCell

#pragma mark - Getters

- (UIImage *)image {
    return nil;
}

#pragma mark - General Lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Initialize & Configure Button
        self.button = [[UIButton alloc] init];
        
        [self.button setTitle:@"Choose image" forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(addImageButtonTap:) forControlEvents:UIControlEventTouchDown];
        
        [self.contentView addSubview:self.button];
        
    }
    
    return self;
}

#pragma mark - Laying out subviews

- (void)layoutSubviews {
    if (self.image) {
        [self.button setFrame:self.contentView.frame];
    } else {
        [self.button setFrame:self.contentView.frame];
    }
}

#pragma mark - DZNPhotoPickerControllerDelegate/UINavigationControllerDelegate Lifecycle

- (void)photoPickerController:(DZNPhotoPickerController *)picker didFinishPickingPhotoWithInfo:(NSDictionary *)userInfo {
    NSLog(@"didFinishPickingPhotoWithInfo:%@", userInfo);
    [self.delegate hidePhotoPicker];
}

- (void)photoPickerController:(DZNPhotoPickerController *)picker didFailedPickingPhotoWithError:(NSError *)error {
    NSLog(@"didFailedPickingPhotoWithError:%@", error);
    [self.delegate hidePhotoPicker];
}

- (void)photoPickerControllerDidCancel:(DZNPhotoPickerController *)picker {
    NSLog(@"photoPickerControllerDidCancel:%@", picker);
    [self.delegate hidePhotoPicker];
}

#pragma mark - Action handlers

- (void)addImageButtonTap:(UIBarButtonItem *)sender
{
    DZNPhotoPickerController *picker = [[DZNPhotoPickerController alloc] init];
    picker.supportedServices = DZNPhotoPickerControllerService500px | DZNPhotoPickerControllerServiceFlickr;
    picker.allowsEditing = YES;
    picker.delegate = self;
    
    [self.delegate presentPhotoPicker:picker];
}


@end
