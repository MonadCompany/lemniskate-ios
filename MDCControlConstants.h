//
//  MDCControlConstants.h
//  Lemniskate
//
//  Created by Chebotaev Anton on 24/12/14.
//  Copyright (c) 2014 MonadCompany. All rights reserved.
//

#ifndef Lemniskate_MDCControlConstants_h
#define Lemniskate_MDCControlConstants_h

// Collection View

#define MDCCollectionViewAspect 0.285
#define MDCCollectionViewWidth ([[UIScreen mainScreen] bounds].size.width)
#define MDCCollectionViewHeight (MDCCollectionViewWidth * MDCCollectionViewAspect)

#define MDCCollectionNameFont ([UIFont boldSystemFontOfSize:16.0f])
#define MDCCollectionCommentFont ([UIFont systemFontOfSize:14.0f])

#define MDCCollectionBackgroundColor ([UIColor blackColor])
#define MDCSemiopaqueBalck ([UIColor colorWithRed:0 green:0 blue:0 alpha:0.5])
#define MDCLessSemiopaqueBalck ([UIColor colorWithRed:0 green:0 blue:0 alpha:0.3])

#define MDCCollectionNameColor ([UIColor whiteColor])
#define MDCCollectionCommentColor ([UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1])

#define MDCPracticeButtonColor ([UIColor colorWithRed:126.0/256 green:211.0/256 blue:33.0/256 alpha:1.0])

#endif
