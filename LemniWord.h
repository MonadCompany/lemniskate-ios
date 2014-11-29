//
//  LemniWord.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 30/11/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LemniCollection;

@interface LemniWord : NSManagedObject

@property (nonatomic, retain) NSString * spelling;
@property (nonatomic, retain) NSString * pronounciation;
@property (nonatomic, retain) NSString * meaning;
@property (nonatomic, retain) LemniCollection *collection;

@end
