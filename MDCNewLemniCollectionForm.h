//
// Created by Chebotaev Anton on 09/12/14.
// Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDCImagePickerDelegate.h"

@interface MDCNewLemniCollectionForm : UIView
@property (readonly, nonatomic, strong) NSString *name;
@property (readonly, nonatomic, strong) NSString *comment;
@property (nonatomic, weak) id <MDCImagePickerDelegate> delegate;
@end