//
//  ACCollectionTableViewCell.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 24/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LemniCollection;

@interface ACCollectionTableViewCell : UITableViewCell
- (instancetype)initWithCollection:(LemniCollection *)collection;
+ (instancetype)cellWithCollection:(LemniCollection *)collection;
@end
