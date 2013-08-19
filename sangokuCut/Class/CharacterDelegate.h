//
//  CharacterDelegate.h
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/18.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CharacterDelegate<NSObject>
@optional

- (void)onCharacterDead:(CGPoint)location sender:(CCSprite *)sender;
@end
