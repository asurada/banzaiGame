//
//  Coin.h
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/17.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "cocos2d.h"


@interface Coin : CCSprite

@property (nonatomic, strong) CCAction *coinAction;


+(id)spriteWithFile;
-(BOOL)initSprite;

@end
