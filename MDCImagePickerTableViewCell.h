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
@property (readonly, nonatomic, strong) UIImage *image; //TODO: refactor to use MDCPicture (see data model)
@property (nonatomic, assign) id <MDCImagePickerDelegate> delegate;
@end
