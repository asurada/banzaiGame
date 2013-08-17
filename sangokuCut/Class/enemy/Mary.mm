//
//  Mary.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/16.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "Mary.h"

@implementation Mary


+(id)spriteWithFile{
    return [super spriteWithFile:@"mary_normal.png" rect:CGRectMake(0, 0, 256, 256)];
}


-(BOOL)initSprite{
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Girl_normal.plist"];
    NSMutableArray *normalAnimFrames = [NSMutableArray array];
    for (int i=1; i<=13; i++) {
        [normalAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"sheet_256x256_%d.png",i]]];
    }
    
    CCAnimation *normalAnim = [CCAnimation animationWithSpriteFrames:normalAnimFrames delay:0.07f];
    
    self.normalAction = [CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:normalAnim]];
    
    
    
    
    
  
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Girl_injure.plist"];
    NSMutableArray *injureAnimFrames = [NSMutableArray array];
    for (int i=0; i<=19; i++) {
        [injureAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"sheet_256x256_%d.png",i]]];
    }
    
    CCAnimation *injureAnim = [CCAnimation animationWithSpriteFrames:injureAnimFrames delay:0.07f];
    
    self.injureAction = [CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:injureAnim]];
    
    
    
      /*
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zhangfei_attack.plist"];
    NSMutableArray *attackAnimFrames = [NSMutableArray array];
    for (int i=1; i<=12; i++) {
        [attackAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"sheet_%d.png",i]]];
    }
    
    CCAnimation *attackAnim = [CCAnimation animationWithSpriteFrames:attackAnimFrames delay:0.07f];
    
    self.attackAction = [CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:attackAnim]];
    
    
    
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zhangfei_dead0.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zhangfei_dead1.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zhangfei_dead2.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zhangfei_dead3.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zhangfei_dead4.plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zhangfei_dead5.plist"];
    NSMutableArray *deadAnimFrames = [NSMutableArray array];
    for (int i=1; i<=47; i++) {
        [deadAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"sheet_%d.png",i]]];
    }
    
    CCAnimation *deadAnim = [CCAnimation animationWithSpriteFrames:deadAnimFrames delay:0.07f];
    
    self.deadAction = [CCRepeatForever actionWithAction:
                       [CCAnimate actionWithAnimation:deadAnim]];
    
    */
    
    return YES;
    
    
}




@end
