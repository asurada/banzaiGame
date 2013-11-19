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
    movingup,
    movingdown,
    standby,
    healthy,
    attack,
    injure,
    dead,
} state;




@interface BaseCharacter : CCSprite{
    float _hp;
    float _allHp;
    float _injureHp;
    float _moveSpeed;
    float _waitingTime;
    float _intervalSpaceMove;
    int   _index;
    
    NSString *_name;
    id<CharacterDelegate> _charDelegate;
    state _state;
    bool _hasAttack;
    
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
    NSString *_hidSound;
    NSString *_deadSound;
}

@property (nonatomic, retain) CCAnimation *injureAnim;
@property (nonatomic, retain) CCAnimation *normalAnim;
@property (nonatomic, retain) CCAnimation *deadAnim;
@property (nonatomic, retain) CCAnimation *attackAnim;
@property (nonatomic, retain) NSString *hidSound;
@property (nonatomic, retain) NSString *deadSound;
@property (nonatomic, retain) id<CharacterDelegate> charDelegate;
@property (nonatomic, assign) float moveSpeed;
@property (nonatomic, assign) float waitingTime;
@property (nonatomic, assign) int index;
@property (nonatomic, assign) float intervalSpaceMove;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) float hp;
@property (nonatomic, assign) float allHp;

+(id)spriteWithFile;
-(BOOL)initSprite;

-(void)injure:(float)direction;
-(void)dead:(float)direction;
-(void)attack;
-(void)normal;
-(void)action;
-(void)hit:(float)direction;
-(void)moveUp;
-(void)moveDown;
-(void)loadNormalAnim;
-(void)loadInjureAnim;
-(void)loadDeadAnim;
-(void)loadAttackAnim;
-(void)finishDead;
-(void)stopAction;
-(state)getState;
-(void)setState:(state)stt;
-(void)stopNormalAction;




@end
