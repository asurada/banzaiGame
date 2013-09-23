//
//  SceneStartup.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/09/01.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "SceneStartup.h"
#import "CCLayer.h"
#import "CCScene.h"
#import "cocos2d.h"
#import "HelloWorldLayer.h"


@implementation SceneStartup


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SceneStartup *layer = [SceneStartup node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}


-(id) init
{
	if( (self=[super init])) {
		// enable events
        
        //画面取得
        UIScreen *sc = [UIScreen mainScreen];
        
        //ステータスバー込みのサイズ
        CGRect rect = sc.bounds;
        NSLog(@"%.1f, %.1f", rect.size.width, rect.size.height);
        
        //ステータスバーを除いたサイズ
        rect = sc.applicationFrame;
        NSLog(@"%.1f, %.1f", rect.size.width, rect.size.height);
        CGSize screen = [[CCDirector sharedDirector] winSize];
        
        if(screen.width == 568){
           [self initBackground_iphone5]; 
        }else{
           [self initBackground_iphone4];
        }
        
        
        
        [self initHUD];
        
	}
    self.touchEnabled = YES;
	return self;
}


-(void)initHUD
{
    CGSize screen = [[CCDirector sharedDirector] winSize];
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"ResourceImage.png"];
    [self addChild:spriteSheet];
    
//    CCSprite *battleStart = [CCSprite spriteWithFile:@"Btn_battleStart.png"];
//    battleStart.position = ccp(screen.width/2,screen.height/2);
//    [self addChild:battleStart z:1];
    

    CCMenuItem * v1 = [CCMenuItemImage itemWithNormalImage:@"Icon_battle_nameBg.png" selectedImage:@"Icon_battle_nameBg.png" target:self selector:@selector(pushSpriteButton:)];
    v1.tag=11;
    CCMenu * menu  = [CCMenu menuWithItems:v1, nil];
    [menu alignItemsHorizontallyWithPadding:20];
    [menu setPosition:ccp(screen.width/2 - 50, screen.height/2 + 130)];
    [self addChild:menu];
    
    
    CCMenuItem * v2 = [CCMenuItemImage itemWithNormalImage:@"Icon_battle_nameBg.png" selectedImage:@"Icon_battle_nameBg.png" target:self selector:@selector(pushSpriteButton:)];
    v2.tag=11;
    CCMenu * menu2  = [CCMenu menuWithItems:v2, nil];
    [menu2 alignItemsHorizontallyWithPadding:20];
    [menu2 setPosition:ccp(screen.width/2 - 50, screen.height/2 + 70)];
    [self addChild:menu2];
    
    
    CCMenuItem * v3 = [CCMenuItemImage itemWithNormalImage:@"Icon_battle_nameBg.png" selectedImage:@"Icon_battle_nameBg.png" target:self selector:@selector(pushSpriteButton:)];
    v3.tag=11;
    CCMenu * menu3  = [CCMenu menuWithItems:v3, nil];
    [menu3 alignItemsHorizontallyWithPadding:20];
    [menu3 setPosition:ccp(screen.width/2 + 100, screen.height/2 + 100)];
    [self addChild:menu3];
    
    
}


-(void)initBackground_iphone5
{
    CGSize screen = [[CCDirector sharedDirector] winSize];
    int height = 0;
    int diff = 568.0 - screen.height;
    

    CCSprite *background_01 =[CCSprite spriteWithFile:@"Page_battle_v1_iPhone5.png"];// [CCSprite spriteWithFile:@"Bg_iPhone5_01.png"];
    background_01.position = ccp(screen.width/2,screen.height/2);//415
    [self addChild:background_01 z:0];
    
    /*
    height = background_01.contentSize.height;
    CCSprite *background_02 = [CCSprite spriteWithSpriteFrameName:@"Bg_iPhone5_02.png"];
    background_02.position = ccp(screen.width/2,screen.height + diff - height - background_02.contentSize.height/2);
    [self addChild:background_02 z:2];
    
    height = height + background_02.contentSize.height;
    CCSprite *background_03 = [CCSprite spriteWithSpriteFrameName:@"Bg_iPhone5_03.png"];
    background_03.position = ccp(screen.width/2,screen.height + diff - height - background_03.contentSize.height/2);
    [self addChild:background_03 z:4];
    
    height = height + background_03.contentSize.height;
    CCSprite *background_04 = [CCSprite spriteWithSpriteFrameName:@"Bg_iPhone5_04.png"];
    background_04.position = ccp(screen.width/2,screen.height + diff - height - background_04.contentSize.height/2);
    [self addChild:background_04 z:6];
    */
}


-(void)initBackground_iphone4
{
    CGSize screen = [[CCDirector sharedDirector] winSize];    
    
    CCSprite *background_01 =[CCSprite spriteWithFile:@"Page_battle_v1_iPhone4s.png"];// [CCSprite spriteWithFile:@"Bg_iPhone5_01.png"];
    background_01.position = ccp(screen.width/2,screen.height/2);//415
    [self addChild:background_01 z:0];
    
}

- (void)pushSpriteButton:(id)sender
{
    switch([sender tag]){
        case 11:
            //CCLOG(@"spriteButtonUseSelector_pushed");
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[HelloWorldLayer scene] ]];
            break;
        case 22:
            CCLOG(@"spriteButtonUseBlock_pushed");
            break;
        default:
            CCLOG(@"???");
            break;
    }
}



@end
