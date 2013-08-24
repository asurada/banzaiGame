//
//  Coin.h
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/17.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"

#define PTM_RATIO 32


@interface Coin : CCSprite{
      b2World *_world;
      b2Fixture *_ballFixture;
      b2BodyDef ballBodyDef;
      b2Body * ballBody;
      b2FixtureDef ballShapeDef;
}

@property (nonatomic, strong) CCAction *coinAction;

@property(nonatomic,assign)b2World *world;

+(id)spriteWithFile;
-(BOOL)initSprite;
-(void)gotCoin;
-(void)initPhysics;

@end
