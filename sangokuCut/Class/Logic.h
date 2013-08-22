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

@interface Logic : NSObject<CharacterDelegate>{
    int cnt;
    NSMutableArray *_enemyBox;
    CCLayer *_layer;
    Logic *_logic;
    bool isMyTurn;

}

@property(nonatomic,retain)NSMutableArray *enemyBox;
@property(nonatomic,retain)CCLayer *layer;
@property(nonatomic,retain)Logic *logic;

-(Logic*)iniLogic:(Logic *)logic;
-(int)showEnemey:(int)tickCnt;
-(void)loadEnmey;


@end
