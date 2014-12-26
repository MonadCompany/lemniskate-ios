//
//  MDCWordTableCellView.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 26/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LemniWord;

#define MDCWordTableCellViewReuseIdentifier (@"MDCWordTableCellViewReuseIdentifier")

@interface MDCWordTableViewCell : UITableViewCell
@property (nonatomic, strong) LemniWord *word;
@end
