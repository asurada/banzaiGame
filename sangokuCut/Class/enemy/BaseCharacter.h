//
//  BaseCharacter.h
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/02.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "CCSprite.h"
#import "cocos2d.h"
#import "CharacterDelegate.h"


typedef enum {
    standby,
    healthy,
    injure,
    dead,
} state;



@interface BaseCharacter : CCSprite{
    float _hp;
    float _injureHp;
    state _state;
    

}

@property (nonatomic, strong) CCAction *normalAction;
@property (nonatomic, strong) CCAction *injureAction;
@property (nonatomic, strong) CCAction *deadAction;
@property (nonatomic, strong) CCAction *attackAction;
@property (nonatomic, strong) id<CharacterDelegate> charDelegate;


+(id)spriteWithFile;
-(BOOL)initSprite;

-(void)injure;
-(void)dead;
-(void)attack;
-(void)backToNormal;
-(void)action;
-(void)hit;




@end
