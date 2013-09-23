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
@synthesize intervalTimeMove = _intervalTimeMove;
@synthesize hidSound = _hidSound;
@synthesize deadSound = _deadSound;
@synthesize charDelegate;

@synthesize name = _name;

-(BOOL)initSprite{
    _state = standby;
    [self loadNormalAnim];
    [self loadInjureAnim];
    [self loadDeadAnim];
    [self loadAttackAnim];
    return YES;
}


-(void)injure{
    [[SimpleAudioEngine sharedEngine] playEffect:self.hidSound];
    if(_state != injure){
      _state = injure;
      [self stopAction];
      id injureAnimation = [CCAnimate actionWithAnimation:self.injureAnim];
      id injureRepeat = [CCRepeat actionWithAction:injureAnimation times:1];
      id injureCallback = [CCCallFunc actionWithTarget:self selector:@selector(finishInjure)];
      _injureAction = [[CCSequence actions:injureRepeat,injureCallback,nil]retain];
      [self runAction:_injureAction];
    }
}


-(void)normal{
    if(_state != healthy){
        _state = healthy;
        _normalAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:self.normalAnim]];
        [self runAction:_normalAction];
    }
}


-(void)dead{
    [[SimpleAudioEngine sharedEngine] playEffect:self.deadSound];
    if(_state != dead){
       [self stopAction];
        [charDelegate onBeforeCharacterDead:self];
       self.zOrder = 16;
       _state = dead;
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
    _state = moving;
    id moveTo = [CCMoveTo actionWithDuration:self.intervalTimeMove position:ccp(self.position.x,self.position.y+self.intervalSpaceMove)];
    id callback = [CCCallFunc actionWithTarget:self selector:@selector(finishMoveUp)];
    [self runAction:[CCSequence actions:moveTo,callback,nil]];
    [self normal];
    [self schedule:@selector(moveDown) interval:5.3];
}




-(void)moveDown{
    [self unscheduleAllSelectors];
    _state = moving;
    id moveTo = [CCMoveTo actionWithDuration:self.intervalTimeMove position:ccp(self.position.x,self.position.y-self.intervalSpaceMove)];
    id callback = [CCCallFunc actionWithTarget:self selector:@selector(finishMoveDown)];
    [self runAction:[CCSequence actions:moveTo,callback,nil]];

}


-(void)finishMoveDown{
    _state = standby;
    [self stopAction];
}


-(void)finishMoveUp{
     [self normal];
  
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

-(void)hit{
    if(_hp > 1){
       _hp--;
       [_attackAction stop];
       [_injureAction stop];
       [_normalAction stop];
       [self injure];
    }else if(_hp == 1 && _state != dead){
       [_attackAction stop];
       [_injureAction stop];
       [_normalAction stop];
       [self dead];
    }
}

-(void)stopAction{
    [_attackAction stop];
    [_injureAction stop];
    [_normalAction stop];

}


@end
