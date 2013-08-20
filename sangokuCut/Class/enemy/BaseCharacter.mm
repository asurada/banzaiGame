//
//  BaseCharacter.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/02.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "BaseCharacter.h"




@implementation BaseCharacter

@synthesize normalAction=_normalAction;
@synthesize injureAction =_injureAction;
@synthesize deadAction=_deadAction;
@synthesize attackAction=_attackAction;
@synthesize charDelegate;

-(BOOL)initSprite{
    _state = standby;
   // [self schedule:@selector(hogehoge) interval:10];
    return YES;
}


-(void)injure{
    if(_state != injure){
      _state = injure;
      [self stopAction];
      [self runAction:self.injureAction];
    }
}


-(void)backToNormal{
    if(_state != healthy){
        _state = healthy;
        [self runAction:self.normalAction];
    }
}


-(void)dead{
    if(_state != dead){
      _state = dead;
      [self runAction:self.deadAction];
    }
}

-(void)attack{
    if(_state != attack){
       _state = attack;
      [self stopAction];
      [self runAction:self.attackAction];
    }
  
}

-(void)moveUp{
    id moveTo = [CCMoveTo actionWithDuration:.9f position:ccp(self.position.x,self.position.y+95)];
    [self runAction:moveTo];
}



-(void)moveDown{
    id moveTo = [CCMoveTo actionWithDuration:.9f position:ccp(self.position.x,self.position.y-95)];
    [self runAction:moveTo];
}

/*

- (void)hogehoge
{
    //intervalで指定した値ごとに呼ばれる
    if(_state == standby){
        _state = healthy;
        id moveTo = [CCMoveTo actionWithDuration:.9f position:ccp(self.position.x,self.position.y+100)];
        [self runAction:moveTo];
        [self backToNormal];
    }else if(_state == healthy){
        _state = standby;
        id moveTo = [CCMoveTo actionWithDuration:.9f position:ccp(self.position.x,self.position.y-100)];
        [self runAction:moveTo];
    }else if(_state == attack){
        [self attack];
    }
    
    /*
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


-(state)getState{
    return _state;
}

-(void)setState:(state)stt{
    _state = stt;
}

-(void)hit{
    if(_hp > 0){
       _hp--;
       [self stopAction:self.attackAction];
       [self stopAction:self.normalAction];
       [self stopAction:self.injureAction];
       [self injure];
    }else if(_hp == 0 && _state != dead){
       [self stopAction:self.attackAction];
       [self stopAction:self.normalAction];
       [self stopAction:self.injureAction];
       [self dead];
    }
}

-(void)stopAction{
    [self stopAction:self.attackAction];
    [self stopAction:self.normalAction];
    [self stopAction:self.injureAction];

}

@end
