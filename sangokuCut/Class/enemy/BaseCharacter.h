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
    attack,
    injure,
    dead,
} state;



@interface BaseCharacter : CCSprite{
    float _hp;
    float _injureHp;
    state _state;
    
    CCAction *_normalAction;
    CCAction *_injureAction;
    CCAction *_deadAction;
    CCAction *_attackAction;
}

@property (nonatomic, retain) CCAction *normalAction;
@property (nonatomic, retain) CCAction *injureAction;
@property (nonatomic, retain) CCAction *deadAction;
@property (nonatomic, retain) CCAction *attackAction;
@property (nonatomic, retain) id<CharacterDelegate> charDelegate;


+(id)spriteWithFile;
-(BOOL)initSprite;

-(void)injure;
-(void)dead;
-(void)attack;
-(void)backToNormal;
-(void)action;
-(void)hit;
-(void)moveUp;
-(void)moveDown;
-(state)getState;
-(void)setState:(state)stt;




@end
