//
//  BaseCharacter.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/02.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "BaseCharacter.h"

@implementation BaseCharacter

-(BOOL)initSprite{
    _state = healthy;
   

    
    return YES;
}


-(void)injure{
    [self runAction:self.injureAction];
}


-(void)backToNormal{
    [self runAction:self.normalAction];
}


-(void)dead{
    [self runAction:self.deadAction];
}

-(void)attack{
    [self runAction:self.attackAction];
  
}



-(void)hit{
    if(_hp > 0){
       _hp--;
    }
    
    if(_hp <= _injureHp && _state != injure){
      _state = injure;
      [self stopAction:self.normalAction];
      [self injure];
      
    }else if(_hp == 0 && _state != dead){
      _state = dead;
      [self stopAction:self.normalAction];
      [self stopAction:self.injureAction];
      [self dead];
    }
}

@end
