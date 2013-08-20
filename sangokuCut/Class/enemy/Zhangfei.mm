//
//  Zhangfei.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/16.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "Zhangfei.h"

@implementation Zhangfei


@synthesize normalAction;
@synthesize injureAction;
@synthesize deadAction;
@synthesize attackAction;
@synthesize charDelegate;

+(id)spriteWithFile{

    return [super spriteWithFile:@"zhangfei_normal.png" rect:CGRectMake(0, 0, 256, 256)];
}


-(BOOL)initSprite{
    [super initSprite];
    _hp = 4;
    _injureHp = 2;
   


    NSMutableArray *attackAnimFrames = [NSMutableArray array];
    for (int i=1; i<=12; i++) {
        [attackAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"zf_attack_%d.png",i]]];
    }
    CCAnimation *attackAnim = [CCAnimation animationWithSpriteFrames:attackAnimFrames delay:0.041f];
    self.attackAction = [CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:attackAnim]];

    
    
    
    NSMutableArray *deadAnimFrames = [NSMutableArray array];
    for (int i=1; i<=47; i++) {
        [deadAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"zf_dead_%d.png",i]]];
    }
    
    CCAnimation *deadAnim = [CCAnimation animationWithSpriteFrames:deadAnimFrames delay:0.041f];
    id animation = [CCAnimate actionWithAnimation:deadAnim];
    id repeat = [CCRepeat actionWithAction:animation times:1];
    id callback = [CCCallFunc actionWithTarget:self selector:@selector(finishedAnimation)];
    self.deadAction = [[CCSequence actions:repeat,callback,nil]retain];
    
    
    NSMutableArray *normalAnimFrames = [NSMutableArray array];
    for (int i=1; i<=14; i++) {
        [normalAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"zf_normal_%d.png",i]]];
    }
    CCAnimation *normalAnim = [CCAnimation animationWithSpriteFrames:normalAnimFrames delay:0.041f];
    self.normalAction = [CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:normalAnim]];
    
    
    NSMutableArray *injureAnimFrames = [NSMutableArray array];
    for (int i=1; i<=10; i++) {
        [injureAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"zf_injure_%d.png",i]]];
    }
    
    CCAnimation *injureAnim = [CCAnimation animationWithSpriteFrames:injureAnimFrames delay:0.041f];
    
    id injureAnimation = [CCAnimate actionWithAnimation:injureAnim];
    id injureRepeat = [CCRepeat actionWithAction:injureAnimation times:1];
    id injureCallback = [CCCallFunc actionWithTarget:self selector:@selector(injureFinishedAnimation)];
    self.injureAction = [[CCSequence actions:injureRepeat,injureCallback,nil]retain];


    /*
    id moveTo = [CCMoveTo actionWithDuration:.9f position:ccp(self.position.x,self.position.y+100)];
    [self runAction:moveTo];
    [self backToNormal];
    */
    

    return YES;
    
    
}

/*
int tickCnt;
- (void)hogehoge
{

    //intervalで指定した値ごとに呼ばれる
    tickCnt ++;
    if(self){
      //[self unschedule:_cmd];
      id moveTo = [CCMoveTo actionWithDuration:.9f position:ccp(self.position.x,self.position.y-100)];
      [self runAction:moveTo];
        
    }else if(tickCnt == 4){
      [self attack];
    }

    if (tickCnt==10) {
        //20秒後からは３秒間隔で呼ばれるようになる
        [self unschedule:_cmd];
        [self schedule:@selector(hogehoge) interval:3.0f];
    }
    if (tickCnt==20) {
        //50秒後からは4秒間隔で呼ばれるようになる
        [self unschedule:_cmd];
        [self schedule:@selector(hogehoge) interval:4.0f];
    }
    
}
*/


-(void) finishedAnimation
{
   [self.charDelegate onCharacterDead:self.position sender:self];
   [self removeFromParentAndCleanup:YES];
}



-(void) injureFinishedAnimation
{
    [self backToNormal];

}

-(void)dealloc{
    [super dealloc];
}


@end
