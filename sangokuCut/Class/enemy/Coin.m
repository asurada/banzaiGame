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
   return [super spriteWithSpriteFrameName:@"coin_0.png"];
}


-(BOOL)initSprite{

    NSMutableArray *normalAnimFrames = [NSMutableArray array];
    for (int i=0; i<=15; i++) {
        [normalAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"coin_%d.png",i]]];
    }
    
    CCAnimation *coinAnim = [CCAnimation animationWithSpriteFrames:normalAnimFrames delay:0.041f];
    
    self.coinAction = [CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:coinAnim]];
    
  
    
    return YES;

}




@end
