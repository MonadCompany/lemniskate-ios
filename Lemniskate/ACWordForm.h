//
//  NewLemniWordForm.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 09/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACImagePickerTableViewCell.h"
#import "ACTextViewTableViewCell.h"

@class LemniWord;

@interface ACWordForm : UIView
@property (nonatomic, strong) LemniWord *word;
@property (nonatomic, weak) id <MDCPhotoPickerDelegate> photoPickerDelegate;
@property (nonatomic, weak) id <MDCTextViewTableViewCellDelegate> textViewDelegate;
@end
