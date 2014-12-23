//
//  LemniWord.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 24/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LemniCollection, LemniWordPicture, LemniWordUsage;

@interface LemniWord : NSManagedObject

@property (nonatomic, retain) NSString * meaning;
@property (nonatomic, retain) NSString * pronunciation;
@property (nonatomic, retain) NSString * spelling;
@property (nonatomic, retain) LemniCollection *collection;
@property (nonatomic, retain) NSSet *pictures;
@property (nonatomic, retain) NSSet *usages;
@end

@interface LemniWord (CoreDataGeneratedAccessors)

- (void)addPicturesObject:(LemniWordPicture *)value;
- (void)removePicturesObject:(LemniWordPicture *)value;
- (void)addPictures:(NSSet *)values;
- (void)removePictures:(NSSet *)values;

- (void)addUsagesObject:(LemniWordUsage *)value;
- (void)removeUsagesObject:(LemniWordUsage *)value;
- (void)addUsages:(NSSet *)values;
- (void)removeUsages:(NSSet *)values;

@end
