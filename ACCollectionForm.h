//
// Created by Chebotaev Anton on 09/12/14.
// Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACImagePickerTableViewCell.h"

@interface ACCollectionForm : UIView
@property (readonly, nonatomic, strong) NSString *name;
@property (readonly, nonatomic, strong) NSString *comment;
@property (readonly, nonatomic, strong) UIImage  *background;
@property (nonatomic, weak) id <MDCPhotoPickerDelegate> photoPickerDelegate;
@end