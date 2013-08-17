//
//  Zhangfei.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/16.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "Zhangfei.h"

@implementation Zhangfei




+(id)spriteWithFile{

    return [super spriteWithFile:@"zhangfei_normal.png" rect:CGRectMake(0, 0, 256, 256)];
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
    
    
    id animation = [CCAnimate actionWithAnimation:deadAnim];
    id repeat = [CCRepeat actionWithAction:animation times:1];
    id callback = [CCCallFunc actionWithTarget:self selector:@selector(finishedAnimation)];
    self.deadAction = [CCSequence actions:repeat,nil];
    
    return YES;
    
    
}





@end
