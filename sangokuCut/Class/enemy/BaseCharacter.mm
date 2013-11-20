//
//  BaseCharacter.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/02.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "BaseCharacter.h"
#import "SimpleAudioEngine.h"



@implementation BaseCharacter

@synthesize injureAnim=_injureAnim;
@synthesize normalAnim=_normalAnim;
@synthesize deadAnim=_deadAnim;
@synthesize attackAnim=_attackAnim;
@synthesize intervalSpaceMove = _intervalSpaceMove;
@synthesize moveUpSpeed = _moveUpSpeed;
@synthesize moveDownSpeed = _moveDownSpeed;
@synthesize waitingTime = _waitingTime;
@synthesize hidSound = _hidSound;
@synthesize deadSound = _deadSound;
@synthesize charDelegate;
@synthesize index =_index;
@synthesize hp =_hp;
@synthesize name = _name;
@synthesize allHp = _allHp;





-(BOOL)initSprite{
    _state = standby;
    [self loadNormalAnim];
    [self loadInjureAnim];
    [self loadDeadAnim];
    [self loadAttackAnim];
    [self setScaleX];
    original_Y = self.position.y;
    return YES;
}


-(void)setScaleX{
    int result = arc4random()%2;
    if(result == 1){
      self.scaleX = -1;
    }else{
      self.scaleX = 1;
    }
}

-(void)injure:(float)direction{
    [[SimpleAudioEngine sharedEngine] playEffect:self.hidSound];
    if(_state != injure){
        if(_hp >0){
          _hp--;
        }
        if(direction >= 0){
            self.scaleX = 1;
        }else{
            self.scaleX = -1;
        }

      _state = injure;
      [self stopAllActions];
      id injureAnimation = [CCAnimate actionWithAnimation:self.injureAnim];
      id injureRepeat = [CCRepeat actionWithAction:injureAnimation times:1];
      id injureCallback = [CCCallFunc actionWithTarget:self selector:@selector(finishInjure)];
      _injureAction = [[CCSequence actions:injureRepeat,injureCallback,nil]retain];
      [self runAction:_injureAction];
      [charDelegate onInjureGirl:self];
    }
}


-(void)normal{
    if(_state != healthy){
        _normalAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.normalAnim]];
        [self runAction:_normalAction];
        _state = healthy;
       
    }
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
       [charDelegate onBeforeCharacterDead:self];
       id animation = [CCAnimate actionWithAnimation:self.deadAnim];
       id action = [CCRepeat actionWithAction:animation times:1];
       id callback = [CCCallFunc actionWithTarget:self selector:@selector(finishDead)];
       _deadAction = [[CCSequence actions:action,callback,nil]retain];
       [self runAction:_deadAction];
    }
}

-(void)attack{
    if(_state != attack && _hasAttack){
       _state = attack;
      [self stopAction];
       _attackAction = [CCRepeatForever actionWithAction:
                             [CCAnimate actionWithAnimation:self.attackAnim]];
      [self runAction:_attackAction];
    }
  
}

-(void)moveUp{
    original_Y = self.position.y;
    _state = movingup;
    id moveTo = [CCMoveTo actionWithDuration:self.moveUpSpeed position:ccp(self.position.x,self.position.y+self.intervalSpaceMove)];
    id callback = [CCCallFunc actionWithTarget:self selector:@selector(finishMoveUp)];
    [self runAction:[CCSequence actions:moveTo,callback,nil]];
    [self schedule:@selector(moveDown) interval:self.waitingTime];
}




-(void)moveDown{
    if(_state != dead){
       _state = movingdown;
       self.zOrder = 7-(self.index/3)*3;
       [self unscheduleAllSelectors];
       id moveTo = [CCMoveTo actionWithDuration:self.moveDownSpeed position:ccp(self.position.x,original_Y)];
       id callback = [CCCallFunc actionWithTarget:self selector:@selector(finishMoveDown)];
       [self runAction:[CCSequence actions:moveTo,callback,nil]];
    }

}


-(void)finishMoveDown{
    [self stopAction];
    _state = standby;
    [self removeFromParentAndCleanup:YES];
}


-(void)finishMoveUp{
     [self normal];
    self.zOrder = 11-(self.index/3)*3;//
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
    [charDelegate onCharacterDead:self.position sender:self];
    [self removeFromParentAndCleanup:YES];
    
}


-(void)finishInjure{
    [self normal];
}





-(state)getState{
    return _state;
}

-(void)setState:(state)stt{
    _state = stt;
}

-(void)hit:(float)direction{
    if(_hp > 1){

       [self injure:direction];
    }else if(_hp == 1 && _state != dead){
       [self dead:direction];
    }
}

-(void)stopAction{
    [self stopAllActions];
}

-(void)stopNormalAction{
    [_normalAction stop];
    [_attackAction stop];
    [_injureAction stop];
}

@end
