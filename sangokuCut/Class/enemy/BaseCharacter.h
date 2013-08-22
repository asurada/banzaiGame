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
    moving,
    standby,
    healthy,
    attack,
    injure,
    dead,
} state;




@interface BaseCharacter : CCSprite{
    float _hp;
    float _injureHp;
    float _intervalTimeMove;
    float _intervalSpaceMove;
    
    NSString *_name;
    
    state _state;
    
    CCAnimation *_injureAnim;
    CCAnimation *_normalAnim;
    CCAnimation *_deadAnim;
    CCAnimation *_attackAnim;
    
   
    CCAction *_normalAction;
    CCAction *_injureAction;
    CCAction *_deadAction;
    CCAction *_attackAction;
    CCAction *_upAction;
    CCAction *_downAction;
}

@property (nonatomic, retain) CCAnimation *injureAnim;
@property (nonatomic, retain) CCAnimation *normalAnim;
@property (nonatomic, retain) CCAnimation *deadAnim;
@property (nonatomic, retain) CCAnimation *attackAnim;
@property (nonatomic, retain) id<CharacterDelegate> charDelegate;
@property (nonatomic, assign) float intervalTimeMove;
@property (nonatomic, assign) float intervalSpaceMove;
@property (nonatomic, retain) NSString *name;


+(id)spriteWithFile;
-(BOOL)initSprite;

-(void)injure;
-(void)dead;
-(void)attack;
-(void)normal;
-(void)action;
-(void)hit;
-(void)moveUp;
-(void)moveDown;

-(void)loadNormalAnim;
-(void)loadInjureAnim;
-(void)loadDeadAnim;
-(void)loadAttackAnim;

-(void)finishDead;

-(state)getState;
-(void)setState:(state)stt;




@end
