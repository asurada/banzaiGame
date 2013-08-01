//
//  PolygonSprite.h
//  CutCutCut
//
//  Created by Allen Benson G Tan on 5/20/12.
//  Copyright 2012 WhiteWidget Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Box2D.h"
#import "PRFilledPolygon.h"

#define PTM_RATIO 32

typedef enum _State
{
    kStateIdle = 0,
    kStateTossed
} State;

typedef enum _Type
{
    kTypeWatermelon = 0,
    kTypeStrawberry,
    kTypePineapple,
    kTypeGrapes,
    kTypeBanana,
    kTypeBomb
} Type;

@interface PolygonSprite : PRFilledPolygon {
    b2Body *_body;
    BOOL _original;
    b2Vec2 _centroid;
    BOOL _sliceEntered;
    BOOL _sliceExited;
    b2Vec2 _entryPoint;
    b2Vec2 _exitPoint;
    double _sliceEntryTime;
    State _state;
    Type _type;
    CCParticleSystemQuad *_splurt;
}

@property(nonatomic,assign)b2Body *body;
@property(nonatomic,readwrite)BOOL original;
@property(nonatomic,readwrite)b2Vec2 centroid;
@property(nonatomic,readwrite)BOOL sliceEntered;
@property(nonatomic,readwrite)BOOL sliceExited;
@property(nonatomic,readwrite)b2Vec2 entryPoint;
@property(nonatomic,readwrite)b2Vec2 exitPoint;
@property(nonatomic,readwrite)double sliceEntryTime;
@property(nonatomic,readwrite)State state;
@property(nonatomic,readwrite)Type type;
@property(nonatomic,assign)CCParticleSystemQuad *splurt;

-(id)initWithTexture:(CCTexture2D*)texture body:(b2Body*)body original:(BOOL)original;
-(id)initWithFile:(NSString*)filename body:(b2Body*)body original:(BOOL)original;
+(id)spriteWithFile:(NSString*)filename body:(b2Body*)body original:(BOOL)original;
+(id)spriteWithTexture:(CCTexture2D*)texture body:(b2Body*)body original:(BOOL)original;
-(id)initWithWorld:(b2World*)world;
+(id)spriteWithWorld:(b2World*)world;
-(b2Body*)createBodyForWorld:(b2World*)world position:(b2Vec2)position rotation:(float)rotation vertices:(b2Vec2*)vertices vertexCount:(int32)count density:(float)density friction:(float)friction restitution:(float)restitution;
-(void)activateCollisions;
-(void)deactivateCollisions;

@end
