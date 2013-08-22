//
//  HelloWorldLayer.h
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/01.
//  Copyright 厳 巍 2013年. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "CCBlade.h"
#import "Zhangfei.h"
#import "BaseCharacter.h"
#import "CharacterDelegate.h"
#import "Logic_Showup_01.h"

//Pixel to metres ratio. Box2D uses metres as the unit for measurement.
//This ratio defines how many pixels correspond to 1 Box2D "metre"
//Box2D is optimized for objects of 1x1 metre therefore it makes sense
//to define the ratio so that your most common object type is 1x1 metre.
#define PTM_RATIO 32

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate,CharacterDelegate>
{
	CCTexture2D *spriteTexture_;	// weak ref
	b2World* world;					// strong ref
	GLESDebugDraw *m_debugDraw;		// strong ref
    
    
    //variables for the blade effect
    CCArray *_blades;
    CCBlade *_blade;
    float _deltaRemainder;
    
    //particle effect for the blade
    CCParticleSystemQuad *_bladeSparkle;
    
    
    //the sprite cache
    CCArray *_cache;
    
    CCSprite *_zombiIcon;
    CCSprite *_coinIcon;
    CCSprite *_bossIcon;
    
    
    CCLabelAtlas *_zombiLabel;
	CCLabelAtlas *_coinLabel;
    
  //  Zhangfei *zf;
    CCSprite *hit;
    
    CCAnimation *hitAnim;
    
    NSMutableArray *enemyBox;
    BaseCharacter *hitTarget;
    
    Logic_Showup_01 *logic;
    
    
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
