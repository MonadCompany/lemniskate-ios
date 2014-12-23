//
//  LemniWordPicture.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 24/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class LemniWord;

@interface LemniWordPicture : NSManagedObject

@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) LemniWord *word;

@end
