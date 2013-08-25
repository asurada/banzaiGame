//
//  ItemDelegate.h
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/25.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ItemDelegate <NSObject>
@optional

- (void)onCoinGot:(CCSprite *)sender;
- (void)onCoinDisappear:(CCSprite *)sender;


@end
