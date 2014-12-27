//
//  NewLemniWordForm.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 09/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDCImagePickerTableViewCell.h"
#import "MDCTextViewTableViewCell.h"

@class LemniWord;

@interface MDCWordForm : UIView
@property (nonatomic, strong) LemniWord *word;
@property (nonatomic, weak) id <MDCPhotoPickerDelegate> photoPickerDelegate;
@property (nonatomic, weak) id <MDCTextViewTableViewCellDelegate> textViewDelegate;
@end
