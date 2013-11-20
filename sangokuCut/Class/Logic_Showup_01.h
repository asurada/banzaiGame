//
//  Logic_Showup_01.h
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/22.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "Logic.h"

@interface Logic_Showup_01 : Logic{
    int enemyClearCount;
    float enemyMoveUpSpeed;
    float enemyMoveDownSpeed;
    float enemyWaitingTime;
    float bossWaitingTime;
    float bossMoveUpSpeed;
    float bossMoveDownSpeed;
    float intervalTime;
    int enemyCount;
    
}
@property (nonatomic, assign) int enemyClearCount;
-(void)setIntervalTime:(float)time;
-(void)setEnemyMoveUpSpeed:(float)time;
-(void)setEnemyMoveDownSpeed:(float)time;
-(void)setBossMoveUpSpeed:(float)time;
-(void)setBossMoveDownSpeed:(float)time;
-(void)setEnemyCount:(int)count;
@end
