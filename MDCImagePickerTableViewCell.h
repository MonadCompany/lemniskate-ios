//
//  MDCImagePickerTableViewCell.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 15/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDCImagePickerDelegate.h"

@interface MDCImagePickerTableViewCell : UITableViewCell
@property (readonly, nonatomic, strong) UIImage *image;
@property (nonatomic, assign) id <MDCPhotoPickerDelegate> photoPickerDelegate;
@end
