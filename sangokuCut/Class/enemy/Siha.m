//
//  Siha.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/25.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "Siha.h"

@implementation Siha



+(id)spriteWithFile{
    return [super spriteWithSpriteFrameName:@"Siha_normal_1.png"];
}


-(BOOL)initSprite{
    [super initSprite];
    _hp = 1;
    _injureHp = 2;
    _intervalSpaceMove = 125;
    _intervalTimeMove =.5f;
    _name = @"siha";
    return YES;
    
}


-(void)loadInjureAnim{
    /*
    NSMutableArray *injureAnimFrames = [NSMutableArray array];
    for (int i=1; i<=10; i++) {
        [injureAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"Siha_injure_%d.png",i]]];
    }
    self.injureAnim = [CCAnimation animationWithSpriteFrames:injureAnimFrames delay:0.041f];
     */
}



-(void)loadAttackAnim{
    /*
    NSMutableArray *attackAnimFrames = [NSMutableArray array];
    for (int i=1; i<=12; i++) {
        [attackAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"Siha_attack_%d.png",i]]];
    }
    self.attackAnim = [CCAnimation animationWithSpriteFrames:attackAnimFrames delay:0.041f];
     */
}



-(void)loadDeadAnim{
    self.deadSound = @"fingerHit_7.caf";
    NSMutableArray *deadAnimFrames = [NSMutableArray array];
    for (int i=1; i<=56; i++) {
        [deadAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"Siha_dead_%d.png",i]]];
    }
    self.deadAnim = [CCAnimation animationWithSpriteFrames:deadAnimFrames delay:0.033f];
}


-(void)loadNormalAnim{
    NSMutableArray *normalAnimFrames = [NSMutableArray array];
    for (int i=1; i<=14; i++) {
        [normalAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"Siha_normal_%d.png",i]]];
    }
    self.normalAnim = [CCAnimation animationWithSpriteFrames:normalAnimFrames delay:0.033f];
    
}




-(void)dealloc{
    [super dealloc];
}


@end
