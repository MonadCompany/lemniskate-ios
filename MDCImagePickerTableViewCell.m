//
//  MDCImagePickerTableViewCell.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 15/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "MDCImagePickerTableViewCell.h"
#import "DZNPhotoPickerController.h"
#import "MDCControlConstants.h"

@interface MDCImagePickerTableViewCell () <UINavigationControllerDelegate, DZNPhotoPickerControllerDelegate>
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIImage *pickedImage;
@property (nonatomic, strong) UIImageView *background;
@end


@implementation MDCImagePickerTableViewCell

#pragma mark - Getters

- (UIImage *)image
{
    return self.pickedImage;
}

- (UIImageView *)background
{
    if (!_background) {
        _background = [UIImageView new];
        _background.backgroundColor = [UIColor whiteColor];
        _background.contentMode = UIViewContentModeScaleAspectFill;
        _background.clipsToBounds = YES;
    }
    return _background;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton new];
        [_button setTitle:@"Choose image" forState:UIControlStateNormal];
        [_button setTitleColor:MDCPlaceholderLabelColor forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(addImageButtonTap:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

#pragma mark - Seters

- (void)setImage:(UIImage *)image {
    self.pickedImage = image;
    [self.background setImage:image];
}

#pragma mark - General Lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];    
    if (self) {
        // Hide separator
        self.layoutMargins = UIEdgeInsetsZero;
        self.separatorInset = UIEdgeInsetsMake(0,1e7,0,0);
        
        [self.contentView addSubview:self.background];
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
    UIAlertController *popup = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *remote = [UIAlertAction actionWithTitle:@"Internet" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        DZNPhotoPickerController *picker = [[DZNPhotoPickerController alloc] init];
        picker.supportedServices = DZNPhotoPickerControllerServiceFlickr;// | DZNPhotoPickerControllerService500px;
        picker.allowsEditing = YES;
        picker.delegate = self;
    
        picker.cropMode = DZNPhotoEditorViewControllerCropModeCustom;
        picker.cropSize = self.cropSize;
    
        [self.photoPickerDelegate presentPhotoPicker:picker];
    }];
    [popup addAction:remote];

    UIAlertAction *local = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // present default image picker
    }];
    [popup addAction:local];

    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // present default image picker
    }];
    [popup addAction:camera];

    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}];
    [popup addAction:cancel];

    [self.photoPickerDelegate presentActionSheet:popup];
    
}


@end
