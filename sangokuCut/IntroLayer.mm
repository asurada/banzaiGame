//
//  IntroLayer.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/01.
//  Copyright 厳 巍 2013年. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "HelloWorldLayer.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

//
-(id) init
{
	if( (self=[super init])) {
		
        [[CCTextureCache sharedTextureCache]addImage:@"coin.png"];
        [[CCTextureCache sharedTextureCache]addImage:@"zhangfei_normal.png"];
        [[CCTextureCache sharedTextureCache]addImage:@"zhangfei_injure.png"];
        [[CCTextureCache sharedTextureCache]addImage:@"zhangfei_attack.png"];
        [[CCTextureCache sharedTextureCache]addImage:@"zhangfei_dead0.png"];
        [[CCTextureCache sharedTextureCache]addImage:@"zhangfei_dead1.png"];
        [[CCTextureCache sharedTextureCache]addImage:@"zhangfei_dead2.png"];
        [[CCTextureCache sharedTextureCache]addImage:@"zombi_lv1_dead.png"];
        [[CCTextureCache sharedTextureCache]addImage:@"zombi_lv1.png"];
        
        
        
        CCTextureCache *cache = [CCTextureCache sharedTextureCache];
        CCTexture2D* texture2D = [cache textureForKey:@"coin.png"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"coin.plist" texture:texture2D];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"bg.plist"];
        texture2D = [cache textureForKey:@"zhangfei_normal.png"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zhangfei_normal.plist" texture:texture2D];
        texture2D = [cache textureForKey:@"zhangfei_injure.png"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zhangfei_injure.plist" texture:texture2D];
        texture2D = [cache textureForKey:@"zhangfei_attack.png"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zhangfei_attack.plist" texture:texture2D];
        texture2D = [cache textureForKey:@"zhangfei_dead0.png"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zhangfei_dead0.plist" texture:texture2D];
        texture2D = [cache textureForKey:@"zhangfei_dead1.png"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zhangfei_dead1.plist"];
        texture2D = [cache textureForKey:@"zhangfei_dead2.png"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zhangfei_dead2.plist"];
        texture2D = [cache textureForKey:@"zombi_lv1_dead.png"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zombi_lv1_dead.plist"];
        texture2D = [cache textureForKey:@"zombi_lv1.png"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zombi_lv1.plist"];
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		CCSprite *background;
		
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
			background = [CCSprite spriteWithFile:@"Default.png"];
			background.rotation = 90;
		} else {
			background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
		}
		background.position = ccp(size.width/2, size.height/2);
		
		// add the label as a child to this Layer
		[self addChild: background];
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[HelloWorldLayer scene] ]];
}
@end
