//
//  CCButton.h
//  sangokuCut
//
//  Created by 厳 巍 on 2013/09/01.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "cocos2d.h"

enum {
    buttonEvent_TouchDown,
    buttonEvent_TouchUpInside
};

@interface CCButton : CCNode <CCTouchOneByOneDelegate> {
    NSMutableDictionary*    targetAndActionDic;
}

+ (id)buttonWithNormalSprite: (CCSprite*)normalSprite selectedSprite:(CCSprite*)selectedSprite target:(id)target action:(SEL)action forEvent:(int)event;

- (void)setTarget:(id)target action:(SEL)action forEvent:(int)event;

@end
