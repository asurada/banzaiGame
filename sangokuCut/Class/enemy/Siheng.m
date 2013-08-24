//
//  Siheng.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/25.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "Siheng.h"

@implementation Siheng



+(id)spriteWithFile{
    return [super spriteWithSpriteFrameName:@"zf_normal_1.png"];
}


-(BOOL)initSprite{
    [super initSprite];
    _hp = 4;
    _injureHp = 2;
    _intervalSpaceMove = 98;
    _intervalTimeMove =.5f;
    _name = @"zhangfei";
    return YES;
    
}


-(void)loadInjureAnim{
    NSMutableArray *injureAnimFrames = [NSMutableArray array];
    for (int i=1; i<=10; i++) {
        [injureAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"zf_injure_%d.png",i]]];
    }
    self.injureAnim = [CCAnimation animationWithSpriteFrames:injureAnimFrames delay:0.041f];
}



-(void)loadAttackAnim{
    NSMutableArray *attackAnimFrames = [NSMutableArray array];
    for (int i=1; i<=12; i++) {
        [attackAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"zf_attack_%d.png",i]]];
    }
    self.attackAnim = [CCAnimation animationWithSpriteFrames:attackAnimFrames delay:0.041f];
}



-(void)loadDeadAnim{
    NSMutableArray *deadAnimFrames = [NSMutableArray array];
    for (int i=1; i<=47; i++) {
        [deadAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"zf_dead_%d.png",i]]];
    }
    self.deadAnim = [CCAnimation animationWithSpriteFrames:deadAnimFrames delay:0.041f];
}


-(void)loadNormalAnim{
    NSMutableArray *normalAnimFrames = [NSMutableArray array];
    for (int i=1; i<=14; i++) {
        [normalAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"zf_normal_%d.png",i]]];
    }
    self.normalAnim = [CCAnimation animationWithSpriteFrames:normalAnimFrames delay:0.041f];
    
}




-(void)dealloc{
    [super dealloc];
}


@end
