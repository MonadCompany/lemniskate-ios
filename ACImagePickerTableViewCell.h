//
//  ACImagePickerTableViewCell.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 15/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDCControlConstants.h"
#import "DZNPhotoPickerController.h"

/// Allows to present VieControllers to choose pictures from internet
@protocol MDCPhotoPickerDelegate <NSObject>
- (void)presentChildViewController:(UIViewController *)viewController;
- (void)hidePhotoPicker;
- (NSString *)initialSearchTerm;
@end

@interface ACImagePickerTableViewCell : UITableViewCell
@property (nonatomic) CGSize cropSize;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) id <MDCPhotoPickerDelegate> photoPickerDelegate;
@end
