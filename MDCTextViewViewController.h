//
//  MDCTextViewViewController.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 27/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MDCTextViewViewControllerDelegate <NSObject>
- (void)finishedEditing:(NSString *)content;
@end

@interface MDCTextViewViewController : UIViewController
@property (nonatomic, weak) id <MDCTextViewViewControllerDelegate> delegate;

// TODO: ask Alex, wtf?
// some race condition occurs when trying to set text to TextView through regular setter
- (instancetype)initWithText:(NSString *)text;
@end
