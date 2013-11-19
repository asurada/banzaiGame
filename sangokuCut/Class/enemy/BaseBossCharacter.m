//
//  BaseBossCharacter.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/11/10.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "BaseBossCharacter.h"
#import "SimpleAudioEngine.h"

@implementation BaseBossCharacter

float preDirection = 0.0;

-(void)finishMoveDown{
    _state = standby;
    [self stopAction];
}

-(void)finishDead{
    [self unscheduleAllSelectors];
    _injureAnim = nil;
    _normalAnim = nil;;
    _deadAnim = nil;
    _attackAnim = nil;
    _normalAction = nil;
    _injureAction = nil;
    _deadAction = nil;
    _attackAction = nil;
    _upAction = nil;
    _downAction = nil;
    
    [_injureAnim release];
    [_normalAnim release];
    [_deadAnim release];
    [_attackAnim release];
    [_normalAction release];
    [_injureAction release];
    [_deadAction release];
    [_attackAction release];
    [_upAction release];
    [_downAction release];

    [self removeFromParentAndCleanup:YES];
    
}

-(void)dead:(float)direction{
    if(_state != dead){
        if(direction >= 0){
            self.scaleX = 1;
        }else{
            self.scaleX = -1;
        }
        _state = dead;
        [self stopAction];
         self.zOrder = 10-(self.index/3)*3;//
        [[SimpleAudioEngine sharedEngine] playEffect:self.deadSound];
        [self.charDelegate onBeforeCharacterDead:self];
        [self.charDelegate onKillBoss:self];
        id animation = [CCAnimate actionWithAnimation:self.deadAnim];
        id action = [CCRepeat actionWithAction:animation times:1];
        id callback = [CCCallFunc actionWithTarget:self selector:@selector(finishDead)];
        _deadAction = [[CCSequence actions:action,callback,nil]retain];
        [self runAction:_deadAction];
    }
}


-(void)injure:(float)direction{
    if(preDirection == 0 || ((float)preDirection*direction)<0){
        if(direction >= 0){
            self.scaleX = 1;
        }else{
            self.scaleX = -1;
        }
        if(_hp >0){
            _hp--;
        }
        preDirection = direction;
        _state = injure;
        [[SimpleAudioEngine sharedEngine] playEffect:self.hidSound];
        [self stopNormalAction];
        id injureAnimation = [CCAnimate actionWithAnimation:self.injureAnim];
        id injureRepeat = [CCRepeat actionWithAction:injureAnimation times:1];
        id injureCallback = [CCCallFunc actionWithTarget:self selector:@selector(finishInjure)];
        _injureAction = [[CCSequence actions:injureRepeat,injureCallback,nil]retain];
        
        [self runAction:_injureAction];
        [self.charDelegate onInjureBoss:self.position sender:self bossBloodRate:(float)_hp/(float)_allHp];
    }
    
}


-(void)finishInjure{
    [self normal];
}


-(void)stopNormalAction{
    [_normalAction stop];
    [_attackAction stop];
   // [_injureAction stop];
}



@end
