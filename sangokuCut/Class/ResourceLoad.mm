//
//  ResourceLoad.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/22.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "ResourceLoad.h"
#import "cocos2d.h"

@implementation ResourceLoad

+(void)loadResource{
    
    [[CCTextureCache sharedTextureCache]addImage:@"coin.png"];
   
    //[[CCTextureCache sharedTextureCache]addImage:@"sheet_64x64_0006.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"num.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"getCoin.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"zhangfei_normal.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"zhangfei_injure.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"zhangfei_attack.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"zhangfei_dead.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"Girl_injure.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"Girl_normal.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"Siheng_normal.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"Siheng_injure.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"Siheng_dead.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"Siha_dead.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"Siha_normal.png"];
    
   
    [[CCTextureCache sharedTextureCache]addImage:@"Sibao_injured.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"Sibao_normal.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"Sihei_normal.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"Sihei_dead.png"];
    
    [[CCTextureCache sharedTextureCache]addImage:@"HuangjinSiha_dead.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"HuangjinSiha_normal.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"HuangjinSihei_dead.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"HuangjinSihei_normal.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"HuangjinSiheng_dead.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"HuangjinSiheng_normal.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"BossZhangjiao_dead.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"BossZhangjiao_injured.png"];
    [[CCTextureCache sharedTextureCache]addImage:@"BossZhangjiao_normal.png"];
    
    [[CCTextureCache sharedTextureCache]addImage:@"ResourceImage.png"];
    
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
    texture2D = [cache textureForKey:@"zhangfei_dead.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"zhangfei_dead.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"Girl_injure.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Girl_injure.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"Girl_normal.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Girl_normal.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"Siheng_normal.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Siheng_normal.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"Siheng_injure.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Siheng_injure.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"Siheng_dead.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Siheng_dead.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"Siha_dead.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Siha_dead.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"Siha_normal.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Siha_normal.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"ResourceImage.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"ResourceImage.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"HuangjinSiha_dead.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"HuangjinSiha_dead.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"HuangjinSiha_normal.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"HuangjinSiha_normal.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"HuangjinSihei_dead.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"HuangjinSihei_dead.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"HuangjinSihei_normal.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"HuangjinSihei_normal.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"HuangjinSiheng_dead.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"HuangjinSiheng_dead.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"HuangjinSiheng_normal.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"HuangjinSiheng_normal.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"BossZhangjiao_dead.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BossZhangjiao_dead.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"BossZhangjiao_injured.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BossZhangjiao_injured.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"BossZhangjiao_normal.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"BossZhangjiao_normal.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"Sibao_injured.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Sibao_injured.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"Sibao_normal.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Sibao_normal.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"Sihei_normal.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Sihei_normal.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"Sihei_dead.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"Sihei_dead.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"getCoin.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"getCoin.plist" texture:texture2D];
    texture2D = [cache textureForKey:@"num.png"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"num.plist" texture:texture2D];
  //  texture2D = [cache textureForKey:@"sheet_64x64_0006.png"];
    

    
    
    
    
    
    
}
@end
