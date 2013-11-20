//
//  Logic_Showup_01.h
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/22.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "Logic.h"

@interface Logic_Showup_01 : Logic{
    int   _enemyClearCount;
    float _enemyMoveUpSpeed;
    float _enemyMoveDownSpeed;
    float _enemyWaitingTime;
    float _bossWaitingTime;
    float _bossMoveUpSpeed;
    float _bossMoveDownSpeed;
    float _intervalTime;
    int   _enemyCount;
    
}
@property (nonatomic, assign) int enemyClearCount;
@property (nonatomic, assign) float enemyMoveUpSpeed;
@property (nonatomic, assign) float enemyMoveDownSpeed;
@property (nonatomic, assign) float enemyWaitingTime;
@property (nonatomic, assign) float bossWaitingTime;
@property (nonatomic, assign) float bossMoveUpSpeed;
@property (nonatomic, assign) float bossMoveDownSpeed;
@property (nonatomic, assign) float intervalTime;
@property (nonatomic, assign) int enemyCount;




@end
