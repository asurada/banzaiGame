//
//  Logic.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/22.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "Logic.h"
#import "BaseCharacter.h"
#import "Coin.h"
#import "Siha.h"
#import "Siheng.h"
#import "HuangjinSiha.h"
#import "HuangjinSihei.h"
#import "HuangjinSiheng.h"
#import "BossZhangjiao.h"
#import "Sibao.h"
#import "Sihei.h"
#import "CCPhysicsSprite.h"
#import "Box2D.h"

@implementation Logic

@synthesize enemyBox = _enemyBox;
@synthesize layer = _layer;
@synthesize logic = _logic;
@synthesize coinBox = _coinBox;
@synthesize world = _world;
@synthesize charDelegate;

-(Logic*)iniLogic:(Logic *)lgc{
    self.logic = lgc;
    _enemyBox = [[NSMutableArray alloc] init];
    _coinBox =[[NSMutableArray alloc] init];
    return [super init];
}

-(void)loadEnmey{
    for(int index = 0; index < 9;index++){
       // BaseCharacter* enemy = ;[self createEnemey:index];
      [_enemyBox addObject:[NSNull null]];
    }
}


-(BaseCharacter *)createEnemy:(int)index{
    BaseCharacter* enemy = [self getEnemy];
    [enemy setState:standby];
    enemy.charDelegate = self;
    if([enemy initSprite]){
        enemy.position =  CGPointMake(50+(index%3)*110,-25+(index/3)*105);
        int z = 8-(index/3)*3;
        enemy.index = index;
        [_layer addChild:enemy z:z];
    }
    return enemy;
}


-(BaseCharacter *)createBoss:(BaseCharacter *)boss at:(int)index{
    [boss setState:standby];
    boss.charDelegate = self;
    if([boss initSprite]){
        [self setSpritePositon:boss at:index];
        [_layer addChild:boss];
    }
    return boss;
}

-(void)setSpritePositon:(BaseCharacter *)boss at:(int)index{
    if(boss != nil){
        boss.position =  CGPointMake(50+(index%3)*110,-25+(index/3)*105);
        boss.zOrder = 8-(index/3)*3;//
        boss.index = index;
    }
}





-(BaseCharacter*)getEnemy{
    int ran = arc4random()%7;
    NSLog(@"回目= %2d",ran);
    switch (ran) {
        case 0:
            return [Siheng spriteWithFile];
        case 1:
            return [Siha spriteWithFile];
        case 2:
            return [Sibao spriteWithFile];
        case 3:
            return [Sihei spriteWithFile];
        case 4:
            return [HuangjinSiha spriteWithFile];
        case 5:
            return [HuangjinSihei spriteWithFile];
        case 6:
            return [HuangjinSiheng spriteWithFile];
        case 7:
            return [BossZhangjiao spriteWithFile];
        default:
            return nil;
            break;
    }
}

-(void)onCharacterDead:(CGPoint)location sender:(CCSprite *)sender{
    int index = [_enemyBox indexOfObject:sender];
    NSLog(@"dead at %d",index);
    
    [_enemyBox replaceObjectAtIndex:index withObject:[NSNull null]];
}


-(void)onBeforeCharacterDead:(CCSprite *)sender{
    Coin *coin = [Coin spriteWithFile];
    if([coin initSprite]){
        coin.itemDelegate = self;
        coin.position = ccp(sender.position.x,sender.position.y);
        coin.world = self.world;
        [coin initPhysics];
        [coin setVelocityDirection:sender.scaleX];
        [_layer addChild:coin z:sender.zOrder+10];
        [_coinBox addObject:coin];
    }

    [charDelegate onBeforeCharacterDead:sender];
}


-(void)onInjureGirl:(CCSprite *)sender{
    [charDelegate onInjureGirl:sender];
}

-(void)onKillBoss:(CCSprite *)sender{
     [charDelegate onKillBoss:sender];
}

-(void)onInjureBoss:(CGPoint)location sender:(CCSprite *)sender bossBloodRate:(float)rate{
     [charDelegate onInjureBoss:location sender:sender bossBloodRate:rate];
}

-(void)onCoinDisappear:(CCSprite *)sender{
      NSLock *arrayLock = [[NSLock alloc] init];
      [arrayLock lock];
      int index = [_coinBox indexOfObject:sender];
        if(index >= 0){
          NSMutableArray *copy = [_coinBox mutableCopy];
          [copy removeObjectAtIndex:index];
          _coinBox = [copy mutableCopy];
          [copy release];

        }
       [arrayLock unlock];
}

-(int)showEnemey:(int)tickCnt{
    return 0;
}


@end
