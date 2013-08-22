//
//  Logic.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/22.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "Logic.h"
#import "Zhangfei.h"
#import "Zombi.h"
#import "BaseCharacter.h"
#import "Coin.h"

@implementation Logic

@synthesize enemyBox = _enemyBox;
@synthesize layer = _layer;
@synthesize logic = _logic;


-(Logic*)iniLogic:(Logic *)lgc{
    self.logic = lgc;
    _enemyBox  = [[NSMutableArray alloc] init];
    return [super init];
}

-(void)loadEnmey{
    for(int index = 0; index < 9;index++){
      BaseCharacter* enemy =  [self getEnemy];
      enemy.charDelegate = self;
      if([enemy initSprite]){
        enemy.position =  CGPointMake(50+(index%3)*110,5+(index/3)*105);
        int z = 5-(index/3)*2;
        [_layer addChild:enemy z:z];
      }
      [_enemyBox addObject:enemy];
    }
    
}

-(BaseCharacter*)getEnemy{
    int ran =  rand()%2;
    switch (ran) {
        case 0:
            return [Zhangfei spriteWithFile];
            break;
        case 1:
            return [Zombi spriteWithFile];
            break;
            
        default:
            break;
    }
}

-(void)onCharacterDead:(CGPoint)location sender:(CCSprite *)sender{
    [sender removeFromParentAndCleanup:YES];
    sender = nil;
    [sender release];
    
    Coin *coin = [Coin spriteWithFile];
    if([coin initSprite]){
        coin.position = location;
        [_layer addChild:coin z:13];
    }
    [coin runAction:coin.coinAction];
}


-(int)showEnemey:(int)tickCnt{
    
}


@end
