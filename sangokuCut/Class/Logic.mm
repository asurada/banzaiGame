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
#import "Mary.h"
#import "CCPhysicsSprite.h"
#import "Box2D.h"

@implementation Logic

@synthesize enemyBox = _enemyBox;
@synthesize layer = _layer;
@synthesize logic = _logic;
@synthesize coinBox = _coinBox;
@synthesize world = _world;

-(Logic*)iniLogic:(Logic *)lgc{
    self.logic = lgc;
    _enemyBox  = [[NSMutableArray alloc] init];
    _coinBox =[[NSMutableArray alloc] init];
    return [super init];
}

-(void)loadEnmey{
    for(int index = 0; index < 9;index++){
      BaseCharacter* enemy = [self createEnemey:index];
      [_enemyBox addObject:enemy];
    }
}


-(BaseCharacter *)createEnemey:(int)index{
    BaseCharacter* enemy = [self getEnemy];
    [enemy setState:standby];
    enemy.charDelegate = self;
    if([enemy initSprite]){
        enemy.position =  CGPointMake(50+(index%3)*110,(index/3)*105);
        int z = 5-(index/3)*2;
        [_layer addChild:enemy z:z];
    }
    return enemy;
}

-(BaseCharacter*)getEnemy{
    int ran =  arc4random()%3;
    NSLog(@"回目= %2d",ran);
    switch (ran) {
        case 0:
            return [Zhangfei spriteWithFile];
            break;
        case 1:
            return [Zhangfei spriteWithFile];
            return [Zombi spriteWithFile];
            break;
        case 2:
            
            return [Zhangfei spriteWithFile];
            return [Mary spriteWithFile];
            
        default:
            return nil;
            break;
    }
}

-(void)onCharacterDead:(CGPoint)location sender:(CCSprite *)sender{
    int index = [_enemyBox indexOfObject:sender];
    NSLog(@"dead at %d",index);
    [_enemyBox replaceObjectAtIndex:index withObject:[NSNull null]];
    [sender removeFromParentAndCleanup:YES];
    sender = nil;
    [sender release];
   
    Coin *coin = [Coin spriteWithFile];
    if([coin initSprite]){
        coin.position = ccp(location.x,location.y+40);
        coin.world = self.world;
        [coin initPhysics];
        [_layer addChild:coin z:sender.zOrder+10];
        [_coinBox addObject:coin];
    }

}


-(int)showEnemey:(int)tickCnt{
    return 0;
}


@end
