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

@interface MDCImagePickerTableViewCell () <UINavigationControllerDelegate, DZNPhotoPickerControllerDelegate, UIImagePickerControllerDelegate>
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
    UIImage *image = userInfo[UIImagePickerControllerEditedImage];
    [self imageSelected:image];
}

- (void)photoPickerController:(DZNPhotoPickerController *)picker didFailedPickingPhotoWithError:(NSError *)error {
    NSLog(@"didFailedPickingPhotoWithError:%@", error);
    [self.photoPickerDelegate hidePhotoPicker];
}

- (void)photoPickerControllerDidCancel:(DZNPhotoPickerController *)picker {
    NSLog(@"photoPickerControllerDidCancel:%@", picker);
    [self.photoPickerDelegate hidePhotoPicker];
}

#pragma mark - UIImagePickerControllerDelegate

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    DZNPhotoEditorViewController *editor = [[DZNPhotoEditorViewController alloc] initWithImage:image];
    editor.cropMode = DZNPhotoEditorViewControllerCropModeCustom;
    editor.cropSize = self.cropSize;
    
    [editor setAcceptBlock:^(DZNPhotoEditorViewController *editor, NSDictionary *userInfo){
        NSLog(@"Local image selected");
        UIImage *image = userInfo[UIImagePickerControllerEditedImage];
        [self imageSelected:image];
    }];
    
    [editor setCancelBlock:^(DZNPhotoEditorViewController *editor){
        [picker popViewControllerAnimated:YES];
    }];
    
    // The view controller requieres to be nested in a navigation controller
    [picker pushViewController:editor animated:YES];
}

#pragma mark - Action handlers

- (void)addImageButtonTap:(UIBarButtonItem *)sender
{
    // contruct popup sheet
    UIAlertController *popup = [UIAlertController alertControllerWithTitle:nil
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    // construct and add Internet button
    UIAlertAction *remote = [UIAlertAction actionWithTitle:@"Internet" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        DZNPhotoPickerController *picker = [[DZNPhotoPickerController alloc] init];
        picker.initialSearchTerm = [self.photoPickerDelegate initialSearchTerm];
        picker.supportedServices = DZNPhotoPickerControllerServiceFlickr | DZNPhotoPickerControllerService500px;
        picker.allowsEditing = YES;
        picker.delegate = self;
    
        picker.cropMode = DZNPhotoEditorViewControllerCropModeCustom;
        picker.cropSize = self.cropSize;
    
        [self.photoPickerDelegate presentChildViewController:picker];
    }];
    [popup addAction:remote];

    // construct and add Gallery button
    UIAlertAction *local = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.delegate = self;
        [self.photoPickerDelegate presentChildViewController:pickerController];

    }];
    [popup addAction:local];

    // construct and add Camera button
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // present default image picker
    }];
    [popup addAction:camera];

    // construct and add Cancel button
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}];
    [popup addAction:cancel];

    [self.photoPickerDelegate presentChildViewController:popup];
}

#pragma mark - Shared Actions

- (void)imageSelected:(UIImage *)image
{
    self.pickedImage = image;
    [self.background setImage:self.pickedImage];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.photoPickerDelegate hidePhotoPicker];
}

@end
