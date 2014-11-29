//
//  LemniCollection.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 30/11/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LemniWord;

@interface LemniCollection : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSSet *words;
@end

@interface LemniCollection (CoreDataGeneratedAccessors)

- (void)addWordsObject:(LemniWord *)value;
- (void)removeWordsObject:(LemniWord *)value;
- (void)addWords:(NSSet *)values;
- (void)removeWords:(NSSet *)values;

@end
