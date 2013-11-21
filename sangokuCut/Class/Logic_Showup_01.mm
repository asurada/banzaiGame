//
//  Logic_Showup_01.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/22.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "Logic_Showup_01.h"
#import "BaseCharacter.h"
#import "BossZhangjiao.h"
#define KILLCOUNT ((int)30)

@implementation Logic_Showup_01



@synthesize enemyClearCount = _enemyClearCount;
@synthesize enemyMoveUpSpeed = _enemyMoveUpSpeed;
@synthesize enemyMoveDownSpeed = _enemyMoveDownSpeed;
@synthesize enemyWaitingTime = _enemyWaitingTime;
@synthesize bossWaitingTime = _bossWaitingTime;
@synthesize bossMoveUpSpeed = _bossMoveUpSpeed;
@synthesize bossMoveDownSpeed = _bossMoveDownSpeed;
@synthesize intervalTime = _intervalTime;
@synthesize enemyCount = _enemyCount;
bool stateMove;
bool bossAppear;
int cnt = 0;
BaseCharacter *boss;


int arr[9] = {
    0, 1, 2, 5, 4, 3, 6, 7, 8,
};


int matrix[9][4]={
    {3,1,0,0},{1,-1,3,0},{-1,3,0,0},{3,-3,-1,0},{1,-1,3,-3},{3,-3,1,0},{-3,1,0,0},{1,-1,-3,0}, {-1,-3,0,0},
};

int prePosition = -1;
int posDiff = 0;
int sequence = 0;

-(int)getPosition{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    if(prePosition == -1){
        prePosition = arc4random()%9;
        return prePosition;
    }else{
        int mainIndex =-1;
        for (int index = 0; index < 9; index++) {
            if(prePosition == arr[index]){
                mainIndex = index;
                break;
            }
        }
        for(int index = 0;index < 4;index++){
            if(posDiff > 0){
                if(matrix[mainIndex][index] > 0 && prePosition != 8){
                    [result addObject:[NSNumber numberWithInteger:matrix[mainIndex][index]]];
                }else if(prePosition == 8 && matrix[mainIndex][index] != 0){
                    [result addObject:[NSNumber numberWithInteger:matrix[mainIndex][index]]];
                }
                
            }else if(posDiff < 0){
                if(matrix[mainIndex][index] < 0 && prePosition != 0){
                    [result addObject:[NSNumber numberWithInteger:matrix[mainIndex][index]]];

                }else if(prePosition == 0 && matrix[mainIndex][index] != 0){
                    [result addObject:[NSNumber numberWithInteger:matrix[mainIndex][index]]];
                }
            }else{
                if(matrix[mainIndex][index] != 0){
                    [result addObject:[NSNumber numberWithInteger:matrix[mainIndex][index]]];
                }
            }
        }
        
        posDiff = [[result objectAtIndex:(arc4random()%([result count]))]integerValue];
        prePosition = prePosition + posDiff;
        return prePosition;
    }

    
}

-(id)init{
    
    self.enemyCount = KILLCOUNT;
    self.enemyMoveUpSpeed = .3;
    self.enemyMoveDownSpeed=.3;
    self.bossMoveUpSpeed=.3;
    self.bossMoveDownSpeed=.3;
    self.intervalTime= 20;
    self.enemyWaitingTime = .8;
    self.bossWaitingTime = 2;
    return [super init];
}

-(void)setSequence{
    
}


-(int)showEnemey:(int)tickCnt killed:(int)killedCnt{
    
    if(killedCnt == 9){
        sequence = arc4random()% 27 +1 ;
    }
    
    
    if(sequence > 0 && killedCnt > 9 && killedCnt < 20){
         self.intervalTime = 2;
    }else{
         self.intervalTime = 20;
    }
    BaseCharacter *enemy = nil;
    if(tickCnt >= self.intervalTime){
        int position = 0;
        tickCnt = 0;
        if(self.intervalTime > 2){
           position = arc4random()%9;
        }else{
            if(cnt > 9){
                cnt = 0;
            }
            position = [self getPosition]; //;arr[cnt];
            cnt++;
            sequence --;
        }
        if(killedCnt < self.enemyCount){//cnt < 14 &&
            NSLog(@"look at %d",position);
            enemy =[self.enemyBox objectAtIndex:position];
            if(enemy != nil && ![enemy isEqual:[NSNull null]] && [enemy getState] == standby && ![enemy isRunning]){
               [enemy removeFromParentAndCleanup:YES];
               enemy = [self createEnemy:position];
               [self.enemyBox replaceObjectAtIndex:position withObject:enemy];
               enemy.waitingTime = self.enemyWaitingTime;
               enemy.moveUpSpeed = self.enemyMoveUpSpeed;
               enemy.moveDownSpeed = self.enemyMoveDownSpeed;
               [enemy moveUp];
            }else if([enemy isEqual:[NSNull null]]){
               NSLog(@"insert at %d",position);
               enemy = [self createEnemy:position];
               [self.enemyBox replaceObjectAtIndex:position withObject:enemy];
                enemy.waitingTime = self.enemyWaitingTime;
                enemy.moveUpSpeed = self.enemyMoveUpSpeed;
                enemy.moveDownSpeed = self.enemyMoveDownSpeed;
               [enemy moveUp];
            }else{
                tickCnt = 20;
            }
        }else if(killedCnt >= self.enemyCount){
            if(!bossAppear){
              for (BaseCharacter *allEnemy in self.enemyBox) {
                 if(![allEnemy isEqual:[NSNull null]] && [allEnemy getState] == healthy){
                     [allEnemy moveDown];
                 }
              }
              bossAppear = YES;
            }else{
             [self showBoss];
            }
     }else{
        
     }
    }

     return tickCnt;

}


-(void)showBoss{
    if(bossAppear){
       if(boss == nil){
          boss = [BossZhangjiao spriteWithFile];
          boss = [self createBoss:boss at:3];
          [self.enemyBox addObject:boss];

       }
       if(boss != nil && [boss getState] == standby){
         [boss setState:standby];
         int ran = arc4random()%8;
         [self setSpritePositon:boss at:ran];
         boss.waitingTime = self.bossWaitingTime;
         boss.moveUpSpeed = self.bossMoveUpSpeed;
         boss.moveDownSpeed = self.bossMoveDownSpeed;
         [boss moveUp];
       }
    }
}


-(void)loadEnmey{
    [super loadEnmey];
}


-(void)bossAppear:(int)killedcnt{
    
}

@end
