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
    return [super spriteWithSpriteFrameName:@"sheet_256x256_0.png"];
}


-(BOOL)initSprite{
    [super initSprite];
    _hp = 4;
    _injureHp = 2;
    _intervalSpaceMove = 98;
    _intervalTimeMove =.5f;
    _name = @"zombi";
    return YES;
    
}


-(void)loadInjureAnim{
    /*
    NSMutableArray *injureAnimFrames = [NSMutableArray array];
    for (int i=1; i<=10; i++) {
        [injureAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"zf_injure_%d.png",i]]];
    }
    self.injureAnim = [CCAnimation animationWithSpriteFrames:injureAnimFrames delay:0.041f];*/
}



-(void)loadAttackAnim{
    /*
    NSMutableArray *attackAnimFrames = [NSMutableArray array];
    for (int i=1; i<=12; i++) {
        [attackAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"zf_attack_%d.png",i]]];
    }
    self.attackAnim = [CCAnimation animationWithSpriteFrames:attackAnimFrames delay:0.041f];
     */
}



-(void)loadDeadAnim{
    NSMutableArray *deadAnimFrames = [NSMutableArray array];
    for (int i=0; i<=31; i++) {
        [deadAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"sheet_372x305_%d.png",i]]];
    }
    self.deadAnim = [CCAnimation animationWithSpriteFrames:deadAnimFrames delay:0.041f];
}


-(void)loadNormalAnim{
    NSMutableArray *normalAnimFrames = [NSMutableArray array];
    for (int i=0; i<=13; i++) {
        [normalAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"sheet_256x256_%d.png",i]]];
    }
    self.normalAnim = [CCAnimation animationWithSpriteFrames:normalAnimFrames delay:0.041f];
    
}




-(void)dealloc{
    [super dealloc];
}



@end
