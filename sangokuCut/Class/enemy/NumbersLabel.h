//
//  NumbersLabel.h
//  sangokuCut
//
//  Created by 厳 巍 on 2013/11/30.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "CCSprite.h"

@interface NumbersLabel : CCSprite{
   int number;
   NSMutableArray* numList;
}


-(void)showNum:(int)num;

@end
