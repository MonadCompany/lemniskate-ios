//
//  LabeledFieldTableViewCell.m
//  Lemniskate
//
//  Created by Chebotaev Anton on 29/11/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import "LabeledFieldTableViewCell.h"

@implementation LabeledFieldTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // Helpers
        CGSize size = self.contentView.frame.size;
        
        // Initialize Main Label
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(8.0, 8.0, size.width - 16.0, size.height - 16.0)];
        
        // Configure Main Label
        [self.label setFont:[UIFont boldSystemFontOfSize:24.0]];
        [self.label setTextAlignment:NSTextAlignmentCenter];
        [self.label setTextColor:[UIColor orangeColor]];
        [self.label setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
        
        // Add Main Label to Content View
        [self.contentView addSubview:self.label];
    }
    
    return self;
}

@end
