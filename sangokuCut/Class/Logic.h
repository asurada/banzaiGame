//
//  Logic.h
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/22.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CharacterDelegate.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "BaseCharacter.h"
@interface Logic : NSObject<CharacterDelegate>{
    int cnt;
    NSMutableArray *_enemyBox;
    NSMutableArray *_coinBox;
    CCLayer *_layer;
    Logic *_logic;
    bool isMyTurn;

}

@property(nonatomic,retain)NSMutableArray *enemyBox;
@property(nonatomic,retain)NSMutableArray *coinBox;
@property(nonatomic,retain)CCLayer *layer;
@property(nonatomic,retain)Logic *logic;
@property(nonatomic,assign)b2World *world;

-(Logic*)iniLogic:(Logic *)logic;
-(int)showEnemey:(int)tickCnt;
-(void)loadEnmey;
-(BaseCharacter *)createEnemey:(int)index;

@end
