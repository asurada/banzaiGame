//
//  Zombi.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/16.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "Zombi.h"

@implementation Zombi



+(id)spriteWithFile{
    return [super spriteWithFile:@"zombi_normal.png" rect:CGRectMake(0, 0, 256, 256)];
}


-(BOOL)initSprite{
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zombi_lv1.plist"];
    NSMutableArray *normalAnimFrames = [NSMutableArray array];
    for (int i=1; i<=13; i++) {
        [normalAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"sheet_256x256_%d.png",i]]];
    }
    
    CCAnimation *normalAnim = [CCAnimation animationWithSpriteFrames:normalAnimFrames delay:0.07f];
    
    self.normalAction = [CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:normalAnim]];
    
    
    
    /*
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zhangfei_injure.plist"];
    NSMutableArray *injureAnimFrames = [NSMutableArray array];
    for (int i=1; i<=10; i++) {
        [injureAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"sheet_%d.png",i]]];
    }
    
    CCAnimation *injureAnim = [CCAnimation animationWithSpriteFrames:injureAnimFrames delay:0.07f];
    
    self.injureAction = [CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:injureAnim]];
    
    
    
    
    
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
    
    */
    
    

    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zombi_lv1_dead.plist"];
    NSMutableArray *deadAnimFrames = [NSMutableArray array];
    for (int i=0; i<=31; i++) {
        [deadAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"sheet_372x305_%d.png",i]]];
    }
    
    CCAnimation *deadAnim = [CCAnimation animationWithSpriteFrames:deadAnimFrames delay:0.07f];
    
    self.deadAction = [CCRepeatForever actionWithAction:
                       [CCAnimate actionWithAnimation:deadAnim]];
    
    
    
    return YES;
    
    
}




@end
