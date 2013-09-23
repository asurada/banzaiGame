//
//  Sihei.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/09/23.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "Sihei.h"

@implementation Sihei




+(id)spriteWithFile{
 
    return [super spriteWithSpriteFrameName:@"Sihei_normal_1.png"];
}


-(BOOL)initSprite{
    [super initSprite];
    _hp = 1;
    _injureHp = 2;
    _intervalSpaceMove = 98;
    _intervalTimeMove =.5f;
    _name = @"Sihei";
    return YES;
    
}


-(void)loadInjureAnim{
    /*
     NSMutableArray *injureAnimFrames = [NSMutableArray array];
     for (int i=1; i<=12; i++) {
     [injureAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
     [NSString stringWithFormat:@"Siheng_injure_%d.png",i]]];
     }
     self.injureAnim = [CCAnimation animationWithSpriteFrames:injureAnimFrames delay:0.033f];
     */
}



-(void)loadAttackAnim{
    /*
     NSMutableArray *attackAnimFrames = [NSMutableArray array];
     for (int i=1; i<=12; i++) {
     [attackAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
     [NSString stringWithFormat:@"zf_attack_%d.png",i]]];
     }
     self.attackAnim = [CCAnimation animationWithSpriteFrames:attackAnimFrames delay:0.033];
     */
}



-(void)loadDeadAnim{
    self.hidSound = @"fingerHit_5.caf";
    NSMutableArray *deadAnimFrames = [NSMutableArray array];
    for (int i=1; i<=56; i++) {
        [deadAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"Sihei_dead_%d.png",i]]];
    }
    self.deadAnim = [CCAnimation animationWithSpriteFrames:deadAnimFrames delay:0.033f];
}


-(void)loadNormalAnim{
    NSMutableArray *normalAnimFrames = [NSMutableArray array];
    for (int i=1; i<=14; i++) {
        [normalAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"Sihei_normal_%d.png",i]]];
    }
    self.normalAnim = [CCAnimation animationWithSpriteFrames:normalAnimFrames delay:0.033];
    
}




-(void)dealloc{
    [super dealloc];
}




@end
