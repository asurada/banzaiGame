//
//  Number.m
//  sangokuCut
//
//  Created by Yan Wei on 2013/11/28.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "Number.h"

@implementation Number



+(id)spriteWithFile:name{
    return [super spriteWithFile:name];
}


-(BOOL)initSprite{
    curcount =-1;
    dstCount =-1;
    return YES;
}




-(BOOL)showNum:(int)num{
    dstCount = num;
    if(dstCount > curcount){
        curcount++;
        return [self showNumAnimation:curcount];
    }else if(dstCount < curcount){
        curcount = num;
        return [self showNumAnimation:curcount];
    }else{
        NSString *name = [NSString stringWithFormat:@"num_%d.png",num];
        [self setTexture:[[CCTextureCache sharedTextureCache] addImage:name]];
        return FALSE;
    }
   
    
    
}

-(BOOL)showNumAnimation:(int)num{
    NSString *name = [NSString stringWithFormat:@"num_%d.png",num];
    [self setTexture:[[CCTextureCache sharedTextureCache] addImage:name]];
    [self setScale:4];
    id scaleDownAction = [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:0.1 scaleX:0.5 scaleY:0.5] rate:1.0];
    id scaleDownNormal = [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:0.1 scaleX:1 scaleY:1] rate:1.0];
    CCSequence *scaleSeq = [CCSequence actions:scaleDownAction,scaleDownNormal, nil];
    id callback = [CCCallFunc actionWithTarget:self selector:@selector(showNextNum)];
    [self runAction:[CCSequence actions:scaleSeq,callback,nil]];
    return YES;

}



-(BOOL)showNextNum{
    if(dstCount > curcount){
        curcount++;
        return [self showNumAnimation:curcount];
    }else if(dstCount < curcount){
        curcount = dstCount;
        return [self showNumAnimation:curcount];
    }
    return NO;
   
}



@end
