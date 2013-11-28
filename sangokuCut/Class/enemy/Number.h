//
//  Number.h
//  sangokuCut
//
//  Created by Yan Wei on 2013/11/28.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "CCSprite.h"
#import "cocos2d.h"

@interface Number : CCSprite

+(id)spriteWithFile:(NSString *)name;
-(BOOL)initSprite;

@end
