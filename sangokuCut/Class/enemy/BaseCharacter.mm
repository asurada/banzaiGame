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

-(state)getState{
    return _state;
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
