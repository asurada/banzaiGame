//
//  CoinEffect.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/11/25.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "CoinEffect.h"


@implementation CoinEffect


+(id)spriteWithFile{
    return [super spriteWithSpriteFrameName:@"coinGetEffect_1.png"];
}


-(BOOL)initSprite{
    
    NSMutableArray *normalAnimFrames = [NSMutableArray array];
    for (int i=1; i<=5; i++) {
        [normalAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"coinGetEffect_%d.png",i]]];
    }
    
    id coinAnim = [CCAnimation animationWithSpriteFrames:normalAnimFrames delay:0.041f];
    id coinAction = [CCAnimate actionWithAnimation:coinAnim];
    
    id callback = [CCCallFunc actionWithTarget:self selector:@selector(coinDisappear)];
    [self runAction:[CCSequence actions:coinAction,callback,nil]];
    return YES;
    
}

-(void)coinDisappear{
    [self removeFromParentAndCleanup:YES];
}


@end
