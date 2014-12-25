//
//  MDCLemniCollectionHeaderUIView.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 25/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class LemniCollection;
typedef id <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate> MDCLemniCollectionHeaderUIViewDelegate;

@interface MDCLemniCollectionHeaderUIView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                   collection:(LemniCollection *)collection
                     delegate:(MDCLemniCollectionHeaderUIViewDelegate) delegate;

+ (instancetype)viewWithFrame:(CGRect)frame
                   collection:(LemniCollection *)collection
                     delegate:(MDCLemniCollectionHeaderUIViewDelegate) delegate;

- (void)reloadData;

@end
