//
//  LemniWord.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 26/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LemniCollection;

@interface LemniWord : NSManagedObject

@property (nonatomic, retain) NSString * meaning;
@property (nonatomic, retain) NSString * pronunciation;
@property (nonatomic, retain) NSString * spelling;
@property (nonatomic, retain) NSString * usage;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) LemniCollection *collection;

@end
