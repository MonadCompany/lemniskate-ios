//
//  NewLemniWordForm.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 09/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewLemniWordForm : UIView <UITableViewDataSource, UITableViewDelegate>
@property (readonly, nonatomic, strong) NSString *spelling;
@property (readonly, nonatomic, strong) NSString *pronunciation;
@property (readonly, nonatomic, strong) NSString *meaning;
@end
