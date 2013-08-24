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
    
    return YES;

}


-(void)gotCoin{
    id moveTo = [CCMoveTo actionWithDuration:.9f position:ccp(100,400)];
    [self runAction:[CCSequence actions:moveTo,nil]];
}



-(void)initPhysics{
    b2Fixture *_ballFixture;
    // Create ball body
    b2BodyDef ballBodyDef;
    ballBodyDef.type = b2_dynamicBody;
    ballBodyDef.position.Set(self.position.x/PTM_RATIO, self.position.y/PTM_RATIO);
    ballBodyDef.userData = self;
    b2Body * ballBody = _world->CreateBody(&ballBodyDef);
    
    // Create circle shape
    b2CircleShape circle;
    circle.m_radius = 8.0/PTM_RATIO;
    
    // Create shape definition and add to body
    b2FixtureDef ballShapeDef;
    ballShapeDef.shape = &circle;
    ballShapeDef.density = 10.0f;
    ballShapeDef.friction = 6.f;
    ballShapeDef.restitution = 1.0f;
    _ballFixture = ballBody->CreateFixture(&ballShapeDef);
    
    // b2Vec2 force = b2Vec2(10, 10);
    // ballBody->ApplyLinearImpulse(force, ballBodyDef.position);
    ballBody->SetAngularVelocity(1);
    ballBody->SetLinearVelocity(b2Vec2(12/PTM_RATIO,32/PTM_RATIO));
}

@end
