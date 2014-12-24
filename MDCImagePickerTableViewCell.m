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
@property (nonatomic, strong) UIImage *pickedImage;
@property (nonatomic, strong) UIImageView *background;
@end


@implementation MDCImagePickerTableViewCell

#pragma mark - Getters

- (UIImage *)image {
    return self.pickedImage;
}

#pragma mark - General Lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Initialize & Configure Background
        self.background = [UIImageView new];
        self.background.backgroundColor = [UIColor whiteColor];
        self.background.contentMode = UIViewContentModeScaleAspectFill;
        self.background.clipsToBounds = YES;
        [self.contentView addSubview:self.background];

        // Initialize & Configure Button
        self.button = [UIButton new];
        
        [self.button setTitle:@"Choose image" forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(addImageButtonTap:) forControlEvents:UIControlEventTouchDown];
        
        [self.contentView addSubview:self.button];
    }
    
    return self;
}

#pragma mark - Laying out subviews

- (void)layoutSubviews {
    CGRect frame = self.contentView.frame;
    [self.button setFrame:frame];
    [self.background setFrame:frame];
}

#pragma mark - DZNPhotoPickerControllerDelegate/UINavigationControllerDelegate Lifecycle

- (void)photoPickerController:(DZNPhotoPickerController *)picker didFinishPickingPhotoWithInfo:(NSDictionary *)userInfo {
    NSLog(@"didFinishPickingPhotoWithInfo:%@", userInfo);
    
    self.pickedImage = userInfo[UIImagePickerControllerEditedImage];
    [self.background setImage:self.pickedImage];
//    self.background.contentMode = UIViewContentModeScaleAspectFill;
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.photoPickerDelegate hidePhotoPicker];
}

- (void)photoPickerController:(DZNPhotoPickerController *)picker didFailedPickingPhotoWithError:(NSError *)error {
    NSLog(@"didFailedPickingPhotoWithError:%@", error);
    [self.photoPickerDelegate hidePhotoPicker];
}

- (void)photoPickerControllerDidCancel:(DZNPhotoPickerController *)picker {
    NSLog(@"photoPickerControllerDidCancel:%@", picker);
    [self.photoPickerDelegate hidePhotoPicker];
}

#pragma mark - Action handlers

- (void)addImageButtonTap:(UIBarButtonItem *)sender
{
    DZNPhotoPickerController *picker = [[DZNPhotoPickerController alloc] init];
    picker.supportedServices = DZNPhotoPickerControllerService500px | DZNPhotoPickerControllerServiceFlickr;
    picker.allowsEditing = YES;
    picker.delegate = self;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    picker.cropMode = DZNPhotoEditorViewControllerCropModeCustom;
    picker.cropSize = CGSizeMake(screenRect.size.width, screenRect.size.width * MDCCollectionViewAspect);
    
    [self.photoPickerDelegate presentPhotoPicker:picker];
}


@end
