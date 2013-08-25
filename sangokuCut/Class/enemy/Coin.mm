//
//  Coin.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/17.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "Coin.h"
#import "CCPhysicsSprite.h"
#import "Box2D.h"

@implementation Coin

@synthesize world = _world;
@synthesize hasGot =_hasGot;
@synthesize itemDelegate;

+(id)spriteWithFile{
   return [super spriteWithSpriteFrameName:@"coin_0.png"];
}


-(BOOL)initSprite{

    NSMutableArray *normalAnimFrames = [NSMutableArray array];
    for (int i=0; i<=15; i++) {
        [normalAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"coin_%d.png",i]]];
    }
    
    CCAnimation *coinAnim = [CCAnimation animationWithSpriteFrames:normalAnimFrames delay:0.041f];
    
    self.coinAction = [CCRepeatForever actionWithAction:
                         [CCAnimate actionWithAnimation:coinAnim]];
    [self runAction:self.coinAction];
    [self schedule:@selector(coinDisappear) interval:5.3];
    return YES;

}


-(void)gotCoin{

    //id moveTo = [CCMoveTo actionWithDuration:.9f position:ccp(100,400)];
    //[self runAction:[CCSequence actions:moveTo,nil]];
    //ballShapeDef.density = 0.0f;
    //ballBody->SetLinearVelocity(b2Vec2(0/PTM_RATIO,1000/PTM_RATIO));
    if(!_hasGot){
      _hasGot = YES;
      [self coinDisappear];
    }
}



-(void)initPhysics{
    
    ballBodyDef.type = b2_dynamicBody;
    ballBodyDef.position.Set(self.position.x/PTM_RATIO, self.position.y/PTM_RATIO);
    ballBodyDef.userData = self;
    ballBody = _world->CreateBody(&ballBodyDef);
    
    // Create circle shape
    b2CircleShape circle;
    circle.m_radius = 8.0/PTM_RATIO;

    // Create shape definition and add to body
    ballShapeDef.shape = &circle;
    ballShapeDef.density = 10.0f;
    ballShapeDef.friction = 0.f;
    ballShapeDef.restitution = 0.6f;
    
    _ballFixture = ballBody->CreateFixture(&ballShapeDef);
    
    // b2Vec2 force = b2Vec2(10, 10);
    // ballBody->ApplyLinearImpulse(force, ballBodyDef.position);
    ballBody->SetAngularVelocity(0);
    ballBody->SetLinearVelocity(b2Vec2(0/PTM_RATIO,100/PTM_RATIO));
}


-(void)coinDisappear{
   // delete _world;
    _world->DestroyBody(ballBody);
    [itemDelegate onCoinDisappear:self];
    [self removeFromParentAndCleanup:YES];
    _ballFixture = nil;
    ballBody = nil;
    self.coinAction = nil;
    self.itemDelegate = nil;
}

@end
