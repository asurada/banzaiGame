//
//  Coin.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/17.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "Coin.h"

@implementation Coin


+(id)spriteWithFile{
    
    return [super spriteWithFile:@"coin.png" rect:CGRectMake(0, 0, 64, 64)];
}


-(BOOL)initSprite{
    [super initSprite];
    _hp = 10;
    _injureHp = 4;
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zhangfei_normal.plist"];
    NSMutableArray *normalAnimFrames = [NSMutableArray array];
    for (int i=1; i<=14; i++) {
        [normalAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"sheet_%d.png",i]]];
    }
    
    CCAnimation *normalAnim = [CCAnimation animationWithSpriteFrames:normalAnimFrames delay:0.07f];
    
    self.normalAction = [CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:normalAnim]];
    
    
    
    return YES;
    
    
}




@end
