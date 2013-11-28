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
    return [super spriteWithSpriteFrameName:name];
}


-(BOOL)initSprite{
    
    id scaleUpAction =  [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:1 scaleX:1.0 scaleY:1.0] rate:2.0];
    id scaleDownAction = [CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:0.5 scaleX:0.8 scaleY:0.8] rate:2.0];
    CCSequence *scaleSeq = [CCSequence actions:scaleUpAction, scaleDownAction, nil];
    [self runAction:[CCRepeatForever actionWithAction:scaleSeq]];    
    return YES;
    
}




@end
