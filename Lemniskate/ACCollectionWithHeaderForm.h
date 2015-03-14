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
typedef id <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate> MDCLemniCollectionDataDelegate;

@protocol MDCCollectionPracticeDelegate <NSObject>
- (void)startPractice:(id)sender;
@end

@interface ACCollectionWithHeaderForm : UIView

@property (nonatomic, assign) id <MDCCollectionPracticeDelegate> practiceDelegate;

- (instancetype)initWithFrame:(CGRect)frame
                   collection:(LemniCollection *)collection
                 dataDelegate:(MDCLemniCollectionDataDelegate) delegate;

+ (instancetype)viewWithFrame:(CGRect)frame
                   collection:(LemniCollection *)collection
                 dataDelegate:(MDCLemniCollectionDataDelegate) delegate;

- (UITableView *)tableView;

@end