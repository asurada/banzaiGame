//
//  HelloWorldLayer.mm
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/01.
//  Copyright 厳 巍 2013年. All rights reserved.
//

// Import the interfaces
#import "HelloWorldLayer.h"

// Not included in "cocos2d.h"
#import "CCPhysicsSprite.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "CCBlade.h"
#import "PolygonSprite.h"
#import "Coin.h"
#import "EnemyData.h"
#import "CCButton.h"
#import "SceneStartup.h"
#import "SimpleAudioEngine.h"
#import "NumbersLabel.h"


enum {
	kTagParentNode = 1,
};


#pragma mark - HelloWorldLayer

@interface HelloWorldLayer()
-(void) initPhysics;
-(void) addNewSpriteAtPosition:(CGPoint)p;


@property (nonatomic, strong) CCAction *hitAction;

@end



@implementation HelloWorldLayer

CGRect particularSpriteRect;
CGRect halfParticularSpriteRect;
CGRect original;
NSMutableArray * bloods;
int bloodCount = 5;
bool isCutting = false;
const CGPoint WSSCGPointNull = {(CGFloat)NAN, (CGFloat)NAN};
CGPoint prePoint = WSSCGPointNull;
float preDirect = 0.0;




+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];

	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
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
        
        
        // init physics
		[self initPhysics];
  
        logic = [[[Logic_Showup_01 alloc]init]iniLogic:nil];
        logic.layer = self;
        logic.world = world;
        logic.charDelegate = self;
        
        
        [self initBackground_iphone5];
       
       
        CGSize winSize = [[CCDirector sharedDirector] winSize];

  
        
        // initialize the blade effect
        _deltaRemainder = 0.0;
        _blades = [[CCArray alloc] initWithCapacity:3];
        CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:@"Deco_shine_v1.png"];
        
        for (int i = 0; i < 3; i++)
        {
            CCBlade *blade = [CCBlade bladeWithMaximumPoint:30];
            blade.autoDim = YES;
            blade.texture = texture;
            [self addChild:blade z:14];
            [_blades addObject:blade];
        }
        
        
        // initialize the blade sparkle particle effect
        _bladeSparkle = [CCParticleSystemQuad particleWithFile:@"blade_sparkle.plist"];
        [_bladeSparkle stopSystem];
        [self addChild:_bladeSparkle z:14];
        [self initHUD];
        [self schedule:@selector(hogehoge) interval:0.1f];
        
        [logic loadEnmey];
        
        self.touchEnabled = YES;
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"bgMusic_loop_5.caf" loop:YES];
        [self scheduleUpdate];
	}
    

    self.touchEnabled = YES;
    
	return self;
}

-(void) dealloc
{
	delete world;
	world = NULL;
	
	delete m_debugDraw;
	m_debugDraw = NULL;
	
	[super dealloc];
}





-(void)updateInfo{
    
}


-(void) initPhysics
{
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	b2Vec2 gravity;
	gravity.Set(0.0f, -40.0f);
	world = new b2World(gravity);
	
	
	// Do we want to let bodies sleep?
	world->SetAllowSleeping(true);
	
	world->SetContinuousPhysics(true);
	
	m_debugDraw = new GLESDebugDraw( PTM_RATIO );
	world->SetDebugDraw(m_debugDraw);
	
	uint32 flags = 0;
	flags += b2Draw::e_shapeBit;
	//		flags += b2Draw::e_jointBit;
	//		flags += b2Draw::e_aabbBit;
	//		flags += b2Draw::e_pairBit;
	//		flags += b2Draw::e_centerOfMassBit;
	m_debugDraw->SetFlags(flags);		
	
	
	// Define the ground body.
	b2BodyDef groundBodyDef;
	groundBodyDef.position.Set(0, 0); // bottom-left corner
	
	// Call the body factory which allocates memory for the ground body
	// from a pool and creates the ground box shape (also from a pool).
	// The body is also added to the world.
	b2Body* groundBody = world->CreateBody(&groundBodyDef);
	
	// Define the ground box shape.
	b2EdgeShape groundBox;		
	
	// bottom
	
	groundBox.Set(b2Vec2(0,0), b2Vec2(s.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// top
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO));
	groundBody->CreateFixture(&groundBox,0);
	
	// left
	groundBox.Set(b2Vec2(0,s.height/PTM_RATIO), b2Vec2(0,0));
	groundBody->CreateFixture(&groundBox,0);
	
	// right
	groundBox.Set(b2Vec2(s.width/PTM_RATIO,s.height/PTM_RATIO), b2Vec2(s.width/PTM_RATIO,0));
	groundBody->CreateFixture(&groundBox,0);
}

-(void) draw
{
	//
	// IMPORTANT:
	// This is only for debug purposes
	// It is recommend to disable it
	//
	[super draw];
	
	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
	
	kmGLPushMatrix();
	
	world->DrawDebugData();	
	
	kmGLPopMatrix();
    
    if(!CGRectIsEmpty(particularSpriteRect)){
       // glEnable(GL_LINE_SMOOTH);
      //  glColor4ub(255, 255, 255, 255);
      //  glLineWidth(2);
      //  CGPoint vertices2[] = { original.origin, particularSpriteRect.origin};
     //ccDrawPoly(vertices2, 4, YES);

      ccDrawColor4B(255, 255,255, 255);
      ccDrawRect(particularSpriteRect.origin, ccpAdd(particularSpriteRect.origin, (ccp(particularSpriteRect.size.width,particularSpriteRect.size.height))));
      //ccDrawRect(particularSpriteRect.origin,ccp(particularSpriteRect.origin.x+particularSpriteRect.size.width, particularSpriteRect.origin.y+particularSpriteRect.size.height));
    }
    
//    if(!CGRectIsEmpty(particularSpriteRect)){
//       CGContextRef ctx = UIGraphicsGetCurrentContext();
//       CGContextSetRGBFillColor(ctx, 1.0, 0.0, 0.0, 1.0);
//       CGContextFillRect(ctx, particularSpriteRect);
//    }
}

int tickCnt;


- (void)hogehoge
{
    tickCnt++;
    tickCnt = [logic showEnemey:tickCnt killed:enemyCount];
 
}




-(void) addNewSpriteAtPosition:(CGPoint)p
{
	CCLOG(@"Add sprite %0.2f x %02.f",p.x,p.y);
	// Define the dynamic body.
	//Set up a 1m squared box in the physics world
	b2BodyDef bodyDef;
	bodyDef.type = b2_dynamicBody;
	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
	b2Body *body = world->CreateBody(&bodyDef);
	
	// Define another box shape for our dynamic body.
	b2PolygonShape dynamicBox;
	dynamicBox.SetAsBox(.5f, .5f);//These are mid points for our 1m box
	
	// Define the dynamic body fixture.
	b2FixtureDef fixtureDef;
	fixtureDef.shape = &dynamicBox;	
	fixtureDef.density = 1.0f;
	fixtureDef.friction = 0.3f;
	body->CreateFixture(&fixtureDef);
	

	CCNode *parent = [self getChildByTag:kTagParentNode];
	
	//We have a 64x64 sprite sheet with 4 different 32x32 images.  The following code is
	//just randomly picking one of the images
	int idx = (CCRANDOM_0_1() > .5 ? 0:1);
	int idy = (CCRANDOM_0_1() > .5 ? 0:1);
	CCPhysicsSprite *sprite = [CCPhysicsSprite spriteWithTexture:spriteTexture_ rect:CGRectMake(32 * idx,32 * idy,32,32)];
	[parent addChild:sprite];
	
	[sprite setPTMRatio:PTM_RATIO];
	[sprite setB2Body:body];
	[sprite setPosition: ccp( p.x, p.y)];
}




-(void) update: (ccTime) dt
{
	//It is recommended that a fixed time step is used with Box2D for stability
	//of the simulation, however, we are using a variable time step here.
	//You need to make an informed choice, the following URL is useful
	//http://gafferongames.com/game-physics/fix-your-timestep/
	
	int32 velocityIterations = 8;
	int32 positionIterations = 1;
	
	// Instruct the world to perform a single step of simulation. It is
	// generally best to keep the time step and iterations fixed.
	world->Step(dt, velocityIterations, positionIterations);
	
    for(b2Body *b = world->GetBodyList(); b; b=b->GetNext()) {
        if (b->GetUserData() != NULL) {
            CCSprite *ballData = (CCSprite *)b->GetUserData();
            ballData.position = ccp(b->GetPosition().x * PTM_RATIO,
                                    b->GetPosition().y * PTM_RATIO);
            ballData.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
            
        }
    }
    

    
}





/*
 * Initializes everything in the background
 */
-(void)initBackground_iphone5
{
    CGSize screen = [[CCDirector sharedDirector] winSize];
    int height = 0;
    int diff = 568.0 - screen.height;
    
    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"bg.png"];
    [self addChild:spriteSheet];
    // add the background image
    CCSprite *background_01 =[CCSprite spriteWithSpriteFrameName:@"layer_1.png"];// [CCSprite spriteWithFile:@"Bg_iPhone5_01.png"];
    background_01.position = ccp(screen.width/2,screen.height + diff - background_01.contentSize.height/2);//415
    [self addChild:background_01 z:0];

    height = background_01.contentSize.height;
    CCSprite *background_02 = [CCSprite spriteWithSpriteFrameName:@"layer_2.png"];
    background_02.position = ccp(screen.width/2,screen.height + diff - height - background_02.contentSize.height/2);
    [self addChild:background_02 z:3];
    
    height = height + background_02.contentSize.height;
    CCSprite *background_03 = [CCSprite spriteWithSpriteFrameName:@"layer_3.png"];
    background_03.position = ccp(screen.width/2,screen.height + diff - height - background_03.contentSize.height/2);
    [self addChild:background_03 z:6];
    
    height = height + background_03.contentSize.height;
    CCSprite *background_04 = [CCSprite spriteWithSpriteFrameName:@"layer_4.png"];
    background_04.position = ccp(screen.width/2,screen.height + diff - height - background_04.contentSize.height/2);
    [self addChild:background_04 z:9];

}

#pragma mark - Controls

/*
 * The touch start logic
 */
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches){
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        
        // move the start and end of the ray cast to the touch
        //startPoint = location;
        //_endPoint = location;
        
        // get an unused blade and move it to the touch
        CCBlade *blade;
        CCARRAY_FOREACH(_blades, blade)
        {
            if (blade.path.count == 0)
            {
                _blade = blade;
                [_blade push:location];
                break;
            }
        }
        
        // move the sparkle to the touch
        _bladeSparkle.position = location;
        [_bladeSparkle resetSystem];
 
        [self hit:touch at:location];
        
   
    }
}


-(void) hitFinishedAnimation:(CCSprite *)mHit
{

    [mHit removeFromParent];
    mHit = nil;
    [mHit release];
}




/*
 * The touch moved logic
 */
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches){
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        /*
        // end point follows the touch
        _endPoint = location;
        
        // ray cast every 5 points of movement
        if (ccpLengthSQ(ccpSub(_startPoint, _endPoint)) > 25)
        {
            // ray cast twice because a fixture can only be intersected in one direction once per ray cast
            world->RayCast(_raycastCallback,
                           b2Vec2(_startPoint.x / PTM_RATIO, _startPoint.y / PTM_RATIO),
                           b2Vec2(_endPoint.x / PTM_RATIO, _endPoint.y / PTM_RATIO));
            
            world->RayCast(_raycastCallback,
                           b2Vec2(_endPoint.x / PTM_RATIO, _endPoint.y / PTM_RATIO),
                           b2Vec2(_startPoint.x / PTM_RATIO, _startPoint.y / PTM_RATIO));
            
            // adjust the start point after the ray cast
            _startPoint = _endPoint;
        }
        */
        // add a point to the blade
        [_blade push:location];
        
        //ccTime deltaTime = _timeCurrent - _timePrevious;
        //_timePrevious = _timeCurrent;
        
        // calculate the velocity (distance / time)
        CGPoint oldPosition = _bladeSparkle.position;
        
        // sparkle follows the touch
        _bladeSparkle.position = location;
        
       
  
        [self hit:touch at:location];


        
        /*
        // play the sound if velocity is past a certain value
        if (ccpDistance(_bladeSparkle.position, oldPosition) / deltaTime > 1000)
        {
            if (!_swoosh.isPlaying)
            {
                // play sound only if it is not playing
                [_swoosh play];
            }
        }*/
    }
}



-(void)onBeforeCharacterDead:(CCSprite *)sender{
    enemyCount++;
    [_zombiLabel setString:[NSString stringWithFormat:@"%d",enemyCount]];
    
}

-(void)onInjureGirl:(CCSprite *)sender{
    if(bloods!= nil && [bloods count] >0){
       CCSprite *blood = [bloods objectAtIndex:[bloods count]-1];
       [bloods removeObject:blood];
       [blood removeFromParentAndCleanup:YES];
       if([bloods count] == 0){
        
      }
    }
    
 }


-(void)onInjureBoss:(CGPoint)location sender:(CCSprite *)sender bossBloodRate:(float)rate{
   // _bossBlood.contentSize.width = _bossBlood.contentSize.width*rate;
    [_bossBlood setScaleX:rate];
    _bossBlood.position = ccp(_bossIcon.position.x + _bossBlood.contentSize.width*rate/2 + 20,_bossIcon.position.y );

}



-(void)onKillBoss:(CCSprite *)sender{
    [_bossBlood setScaleX:0];
}


-(void)hit:(UITouch *)touch at:(CGPoint )location{
    float direction = 0;
    if(WSSCGPointIsNull(prePoint)){
        prePoint = location;
    }else{
        direction = location.x-prePoint.x;
        prePoint = location;
    }
    
    for (BaseCharacter *enemy in logic.enemyBox) {
      if([enemy isEqual:[NSNull null]]){
         continue;
      }
      CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
      particularSpriteRect = CGRectMake(enemy.position.x-27, enemy.position.y-50, 54,80);
      halfParticularSpriteRect = CGRectMake(enemy.position.x-27, enemy.position.y-50, 27,80);
     // original = CGRectMake(enemy.position.x-27, enemy.position.y-50, 0,0);
      if (CGRectContainsPoint(particularSpriteRect, touchLocation)) {
          if(enemy!= nil &&
           ![enemy isEqual:[NSNull null]]&&
            [enemy hp]>0 &&
            [enemy getState] != dead &&
            [enemy getState] != standby &&
            [enemy getState] != movingup &&
            [enemy getState] != movingdown &&!isCutting){
              isCutting = YES;
            if(direction != 0){
               [enemy hit:direction];
                if(preDirect == 0.0){
                  [self playHit:enemy];
                }else if(((float)preDirect * direction)<0){
                  [self playHit:enemy];
                }
              
            }else{
                if(CGRectContainsPoint(halfParticularSpriteRect, touchLocation)){
                   [enemy hit:1];
                }else{
                   [enemy hit:-1];
                }
                [self playHit:enemy];
            }
            preDirect = direction;
         }else{
            
         }
      }else{
        isCutting = NO;
      }
   }
    
    
    NSLog(@"coinBox count: %d",logic.coinBox.count);
    for (int index=0; index<logic.coinBox.count; index++) {
      Coin *coin = [logic.coinBox objectAtIndex:index];
      coin.charDelegate = self;
      CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
      CGRect particularSpriteRect = CGRectMake(coin.position.x, coin.position.y, coin.contentSize.width,coin.contentSize.height);
      if (CGRectContainsPoint(particularSpriteRect, touchLocation)) {
         [coin gotoCoin: ccp(26,510)];
          //[_coinLabel setString:[NSString stringWithFormat:@"%d",coinCount]];
         return;
      }
   }
}

-(void)playHit:(BaseCharacter *)enemy{
    hit = [CCSprite spriteWithFile:@"hit_normal.png"];
    hit.position = enemy.position;//ccp(enemy.position.x,enemy.position.y);
    [self addChild:hit z:15];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"hit.plist"];
    NSMutableArray *hitAnimFrames = [NSMutableArray array];
    for (int i=0; i<=4; i++) {
        [hitAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"sheet_256x256_%d.png",i]]];
    }
    
    hitAnim = [CCAnimation animationWithSpriteFrames:hitAnimFrames delay:0.07f];
    id hitAnimation = [CCAnimate actionWithAnimation:hitAnim];
    id repeat = [CCRepeat actionWithAction:hitAnimation times:1];
    id callback = [CCCallFuncO actionWithTarget:hit selector:@selector(removeFromParentAndCleanup:) object:[CCNode node]];
    id sequence = [CCSequence actions:repeat, callback,nil];
    [hit runAction:sequence];
}


/*
 * The touch end logic
 */
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

	//Add a new body/atlas sprite at the touched location
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
        
        // remove all entry and exit points from all polygons
        // [self clearSlices];
        
        // fade the blade
        [_blade dim:YES];
        
        // sparkle effect stops
        [_bladeSparkle stopSystem];
        isCutting = NO;
        prePoint = WSSCGPointNull;
        preDirect = 0;
        
	}
}





// Add these methods
-(void)initHUD
{
    CGSize screen = [[CCDirector sharedDirector] winSize];
    
    /*
    CCSprite *pasueIcon = [CCSprite spriteWithFile:@"btn_pause.png"];
    CCSprite *selectedSprite = [CCSprite spriteWithFile:@"btn_pause.png"];
    CCButton *button =[CCButton buttonWithNormalSprite:pasueIcon selectedSprite:selectedSprite target:self action:@selector(touchUpInSide:) forEvent:buttonEvent_TouchUpInside];
    [button setTarget:self action:@selector(touchDown:) forEvent:buttonEvent_TouchDown];
    button.position = ccp(screen.width - pasueIcon.contentSize.width/2-5, screen.height - pasueIcon.contentSize.height/2-5);
    [self addChild:button];*/
    
    CCMenuItem * pasueIcon = [CCMenuItemImage itemWithNormalImage:@"btn_pause.png" selectedImage:@"btn_pause.png" target:self selector:@selector(pushSpriteButton:)];
    pasueIcon.tag=11;
    CCMenu * menu  = [CCMenu menuWithItems:pasueIcon, nil];
    [menu alignItemsHorizontallyWithPadding:20];
    [menu setPosition:ccp(screen.width - pasueIcon.contentSize.width/2-5, screen.height - pasueIcon.contentSize.height/2-5)];
    [self addChild:menu];
    
    

    
    //CCSprite *pasueIcon = [CCSprite spriteWithFile:@"btn_pause.png"];
    //pasueIcon.position = ccp(screen.width - pasueIcon.contentSize.width/2-5, screen.height - pasueIcon.contentSize.height/2-5);
    //[self addChild:pasueIcon];
     bloods = [[NSMutableArray alloc]init];
    for (int i = 0; i < 3; i++)
    {
        CCSprite *blood = [CCSprite spriteWithFile:@"Icon_heart.png"];
        blood.position = ccp(screen.width-pasueIcon.contentSize.width*1.5-blood.contentSize.width/2-(blood.contentSize.width+2)*i,screen.height-blood.contentSize.height/2-5);
        [bloods addObject:blood];
        [self addChild:blood z:12];
    }
    
    
    _zombiIcon = [CCSprite spriteWithFile:@"Icon_zombie.png"];
    _zombiIcon.position = ccp(_zombiIcon.contentSize.width/2+10,screen.height-_zombiIcon.contentSize.height/2-5);
    [self addChild:_zombiIcon z:12];
    

    CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"numpic.png"];
    [self addChild:spriteSheet];

    
    _coinIcon = [CCSprite spriteWithFile:@"Icon_coin.png"];//:@"Icon_coin.png"
    _coinIcon.position = ccp(_coinIcon.contentSize.width/2+10,_zombiIcon.position.y - _coinIcon.contentSize.height-5);
    [self addChild:_coinIcon z:12];
    
    
    _bossIcon = [CCSprite spriteWithFile:@"Icon_boss.png"];
    _bossIcon.position = ccp(_bossIcon.contentSize.width/2+10,_coinIcon.position.y - _bossIcon.contentSize.height-5);
    [self addChild:_bossIcon z:12];
    

    
    _bossBloodBg = [CCSprite spriteWithFile:@"Loading_bloodBg.png"];
    _bossBloodBg.position = ccp(_bossIcon.position.x + _bossBloodBg.contentSize.width/2+20,_bossIcon.position.y );
    [self addChild:_bossBloodBg z:12];
    
    _bossBlood = [CCSprite spriteWithFile:@"Loading_blood.png"];
    _bossBlood.position = ccp(_bossIcon.position.x + _bossBlood.contentSize.width/2+20,_bossIcon.position.y );
    [self addChild:_bossBlood z:12];
    
    
    [self createLabel];
    
}


- (void)pushSpriteButton:(id)sender
{
    switch([sender tag]){
        case 11:
            CCLOG(@"spriteButtonUseSelector_pushed");
            [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[SceneStartup scene] ]];
            break;
        case 22:
            CCLOG(@"spriteButtonUseBlock_pushed");
            break;
        default:
            CCLOG(@"???");
            break;
    }
}


-(void)onGotCoint:(CCSprite *)sender{
    coinCount++;
    [number showNum:coinCount];
    id scaleUpAction =  [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:0.2 scaleX:1.4 scaleY:1.4] rate:2.0];
    id scaleDownAction = [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:0.1 scaleX:0.8 scaleY:0.8] rate:2.0];
    id scaleUpAction2 =  [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:0.1 scaleX:1 scaleY:1] rate:2.0];
    CCSequence *scaleSeq = [CCSequence actions:scaleUpAction, scaleDownAction, scaleUpAction2, nil];
    [_coinIcon runAction:scaleSeq];
}


-(void)onCoinDisappear:(CCSprite *)sender{
   

}

-(void) createLabel
{
	if( _zombiLabel) {
		CCTexture2D *texture = [_zombiLabel texture];
		[_zombiLabel release];
		//[_coinLabel release];
		[[CCTextureCache sharedTextureCache ] removeTexture:texture];
		_zombiLabel = nil;
		//_coinLabel = nil;
	}

    
	CCTexture2DPixelFormat currentFormat = [CCTexture2D defaultAlphaPixelFormat];
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
	_zombiLabel =  [[CCLabelAtlas alloc]  initWithString:@"0" charMapFile:@"numbers.png" itemWidth:20 itemHeight:32 startCharMap:'.'];
	//_coinLabel =  [[CCLabelAtlas alloc]  initWithString:@"0" charMapFile:@"numbers.png" itemWidth:20 itemHeight:32 startCharMap:'.'];

 
	[CCTexture2D setDefaultAlphaPixelFormat:currentFormat];
    _zombiLabel.position = ccp(_zombiIcon.position.x+20,_zombiIcon.position.y-15);
    //_coinLabel.position = ccp(_coinIcon.position.x+20,_coinIcon.position.y-15);
    
    
    number = [[NumbersLabel alloc]init];
    [self addChild:number z:14];
    number.position = ccp(_coinIcon.position.x+30,_coinIcon.position.y);
    [number showNum:0];
  
    [self addChild:_zombiLabel z:14];
 //   [self addChild:_coinLabel z:14];
	
}

BOOL WSSCGPointIsNull( CGPoint point ){
    return std::isnan(point.x) && std::isnan(point.y);
}


#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

@end
