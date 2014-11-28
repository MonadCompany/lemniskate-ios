//
//  AddCollectionViewController.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 20/11/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

@import UIKit;

@interface AddCollectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end
