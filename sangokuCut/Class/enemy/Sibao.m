//
//  Sibao.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/09/23.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "Sibao.h"
#import "SimpleAudioEngine.h"

@implementation Sibao




+(id)spriteWithFile{
    return [super spriteWithSpriteFrameName:@"Sibao_normal_1.png"];
}


-(BOOL)initSprite{
    [super initSprite];
    _hp = 10;
    _injureHp = 2;
    _intervalSpaceMove = 125;
    _moveUpSpeed =.3f;
    _moveDownSpeed =.3f;
    _waitingTime = .8f;
    _name = @"Sibao";
    return YES;
    
}


-(void)injure{
    
    [super injure];
   
    
    
}

-(void)loadInjureAnim{
     self.hidSound = @"humanVoice_girl.caf";
     NSMutableArray *injureAnimFrames = [NSMutableArray array];
     for (int i=1; i<=12; i++) {
     [injureAnimFrames addObject:
     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
     [NSString stringWithFormat:@"Sibao_injured_%d.png",i]]];
     }
     self.injureAnim = [CCAnimation animationWithSpriteFrames:injureAnimFrames delay:0.033f];
    
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
    /*
    NSMutableArray *deadAnimFrames = [NSMutableArray array];
    for (int i=1; i<=56; i++) {
        [deadAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"Sibao_dead_%d.png",i]]];
    }
    self.deadAnim = [CCAnimation animationWithSpriteFrames:deadAnimFrames delay:0.033f];
     */
}


-(void)loadNormalAnim{
    NSMutableArray *normalAnimFrames = [NSMutableArray array];
    for (int i=1; i<=14; i++) {
        [normalAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"Sibao_normal_%d.png",i]]];
    }
    self.normalAnim = [CCAnimation animationWithSpriteFrames:normalAnimFrames delay:0.033];
    
}


-(void)finishInjure{
     [super moveDown];
}



-(void)dealloc{
    [super dealloc];
}




@end
