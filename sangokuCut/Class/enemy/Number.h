//
//  Number.h
//  sangokuCut
//
//  Created by Yan Wei on 2013/11/28.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "CCSprite.h"
#import "cocos2d.h"

@interface Number : CCSprite{
    int curcount;
    int dstCount;
}

+(id)spriteWithFile:(NSString *)name;
-(BOOL)initSprite;
-(BOOL)showNum:(int)num;

@end
