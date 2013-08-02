//
//  PolygonSprite.m
//  CutCutCut
//
//  Created by Allen Benson G Tan on 5/20/12.
//  Copyright 2012 WhiteWidget Inc. All rights reserved.
//

#import "PolygonSprite.h"

@implementation PolygonSprite

@synthesize body = _body;
@synthesize original = _original;
@synthesize centroid = _centroid;
@synthesize entryPoint = _entryPoint;
@synthesize exitPoint = _exitPoint;
@synthesize sliceEntered = _sliceEntered;
@synthesize sliceExited = _sliceExited;
@synthesize sliceEntryTime = _sliceEntryTime;
@synthesize state = _state;
@synthesize type = _type;
@synthesize splurt = _splurt;

#pragma mark - Initialization
+(id)spriteWithFile:(NSString *)filename body:(b2Body *)body  original:(BOOL)original
{
    return [[[self alloc]initWithFile:filename body:body original:original] autorelease];
}
+(id)spriteWithTexture:(CCTexture2D *)texture body:(b2Body *)body  original:(BOOL)original
{
    return [[[self alloc]initWithTexture:texture body:body original:original] autorelease];
}
+(id)spriteWithWorld:(b2World *)world
{
    return [[[self alloc]initWithWorld:world] autorelease];
}
-(id)initWithFile:(NSString*)filename body:(b2Body*)body  original:(BOOL)original
{
    NSAssert(filename != nil, @"Invalid filename for sprite");
    CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage: filename];
    return [self initWithTexture:texture body:body original:original];
}
-(id)initWithTexture:(CCTexture2D*)texture body:(b2Body*)body original:(BOOL)original
{
    // gather all the vertices from our Box2D shape
    b2Fixture *originalFixture = body->GetFixtureList();
    b2PolygonShape *shape = (b2PolygonShape*)originalFixture->GetShape();
    int vertexCount = shape->GetVertexCount();
    NSMutableArray *points = [NSMutableArray arrayWithCapacity:vertexCount];
    for(int i = 0; i < vertexCount; i++) {
        CGPoint p = ccp(shape->GetVertex(i).x * PTM_RATIO, shape->GetVertex(i).y * PTM_RATIO);
        [points addObject:[NSValue valueWithCGPoint:p]];
    }
    
    if ((self = [super initWithPoints:points andTexture:texture]))
    {
        _sliceExited = NO;
        _sliceEntered = NO;
        _entryPoint.SetZero();
        _exitPoint.SetZero();
        _sliceExited = 0;
        _body = body;
        _body->SetUserData(self);
        _original = original;
        // gets the center of the polygon
        _centroid = self.body->GetLocalCenter();
        // assign an anchor point based on the center
        self.anchorPoint = ccp(_centroid.x * PTM_RATIO / texture.contentSize.width, 
                               _centroid.y * PTM_RATIO / texture.contentSize.height);
        _state = kStateIdle;
    }
    return self;
}
-(id)initWithWorld:(b2World *)world
{
    //nothing to do here
    return nil;
}

#pragma mark - Private Methods

/*
 * Creates a Box2D body that doesn't collide with anything
 */
-(b2Body*)createBodyForWorld:(b2World *)world position:(b2Vec2)position rotation:(float)rotation vertices:(b2Vec2*)vertices vertexCount:(int32)count density:(float)density friction:(float)friction restitution:(float)restitution
{
    b2BodyDef bodyDef;
    bodyDef.type = b2_kinematicBody;
    bodyDef.position = position;
    bodyDef.angle = rotation;
    b2Body *body = world->CreateBody(&bodyDef);
    
    b2FixtureDef fixtureDef;
    fixtureDef.density = density;
    fixtureDef.friction = friction;
    fixtureDef.restitution = restitution;
    fixtureDef.filter.categoryBits = 0;
    fixtureDef.filter.maskBits = 0;
    fixtureDef.isSensor = YES;
    
    b2PolygonShape shape;
    shape.Set(vertices, count);
    fixtureDef.shape = &shape;
    body->CreateFixture(&fixtureDef);
    
    return body;
}

#pragma mark - Public Methods

/*
 * Overloaded setPosition method to include the Box2D body in the position adjustment
 */
-(void)setPosition:(CGPoint)position
{
    [super setPosition:position];
    _body->SetTransform(b2Vec2(position.x/PTM_RATIO,position.y/PTM_RATIO), _body->GetAngle());
}

/*
 * Sets the category and mask bits to collide with itself
 */
-(void)activateCollisions
{
    b2Fixture *fixture = _body->GetFixtureList();
    b2Filter filter = fixture->GetFilterData();
    filter.categoryBits = 0x0001;
    filter.maskBits = 0x0001;
    fixture->SetFilterData(filter);
}

/*
 * Sets the category and mask bits to not collide with anything
 */
-(void)deactivateCollisions
{
    b2Fixture *fixture = _body->GetFixtureList();
    b2Filter filter = fixture->GetFilterData();
    filter.categoryBits = 0;
    filter.maskBits = 0;
    fixture->SetFilterData(filter);
}

/*
 * Returns the transform matrix according to physics values
 */
-(CGAffineTransform) nodeToParentTransform
{
    b2Vec2 pos  = _body->GetPosition();
    
    float x = pos.x * PTM_RATIO;
    float y = pos.y * PTM_RATIO;
    
    if ( _ignoreAnchorPointForPosition ) {
        x += _anchorPointInPoints.x;
        y += _anchorPointInPoints.y;
    }
    
    // Make matrix
    float radians = _body->GetAngle();
    float c = cosf(radians);
    float s = sinf(radians);
    
    if( ! CGPointEqualToPoint(_anchorPointInPoints, CGPointZero) ){
        x += c*-_anchorPointInPoints.x + -s*-_anchorPointInPoints.y;
        y += s*-_anchorPointInPoints.x + c*-_anchorPointInPoints.y;
    }
    
    // Rot, Translate Matrix
    _transform = CGAffineTransformMake( c,  s,
                                       -s,c,
                                       x,y );
    
    return _transform;
}

@end
