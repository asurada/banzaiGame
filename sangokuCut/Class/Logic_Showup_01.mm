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

bool stateMove;
bool bossAppear;
int intervalTime = 0;
int cnt = 0;
BaseCharacter *boss;
@synthesize enemyClearCount;

int arr[14] = {
    0, 1, 2, 5, 4, 3, 6, 7, 8, 0, 2, 4, 6, 8
};



-(id)init{
    
    enemyCount = KILLCOUNT;
    enemyMoveUpSpeed = .2;
    enemyMoveDownSpeed=.3;
    bossMoveUpSpeed=.4;
    bossMoveDownSpeed=.3;
    intervalTime= 20;
    return [super init];
}


-(int)showEnemey:(int)tickCnt killed:(int)killedCnt{
    
    
    
    if(killedCnt > 10 && killedCnt < 20){
        intervalTime = 2;
    }else{
        intervalTime = 20;
    }
    BaseCharacter *enemy = nil;
    if(tickCnt >= intervalTime){
        int position = 0;
        tickCnt = 0;
        if(intervalTime > 2){
           position = arc4random()%9;
        }else{
            if(cnt > 13){
                cnt = 0;
            }
            position =arr[cnt];
            cnt++;
        }
        if(killedCnt < enemyCount){//cnt < 14 &&
            NSLog(@"look at %d",position);
            enemy =[self.enemyBox objectAtIndex:position];
            if(enemy != nil && ![enemy isEqual:[NSNull null]] && [enemy getState] == standby && ![enemy isRunning]){
               [enemy removeFromParentAndCleanup:YES];
               enemy = [self createEnemy:position];
               [self.enemyBox replaceObjectAtIndex:position withObject:enemy];
//                enemy.waitingTime = enemy.waitingTime;// - (float)(killedCnt/KILLCOUNT) *enemy.waitingTime *0.5;
//                enemy.moveUpSpeed = enemy.moveUpSpeed;// - (float)(killedCnt/KILLCOUNT) * enemy.moveUpSpeed*0.5;
//                enemy.moveDownSpeed = enemy.moveDownSpeed;// - (float)(killedCnt/KILLCOUNT) * enemy.moveDownSpeed*0.5;
               [enemy moveUp];
            }else if([enemy isEqual:[NSNull null]]){
               NSLog(@"insert at %d",position);
               enemy = [self createEnemy:position];
               [self.enemyBox replaceObjectAtIndex:position withObject:enemy];
//                enemy.waitingTime = enemy.waitingTime;// - (float)(killedCnt/KILLCOUNT) *enemy.waitingTime *0.5;
//                enemy.moveUpSpeed = enemy.moveUpSpeed;// - (float)(killedCnt/KILLCOUNT) * enemy.moveUpSpeed*0.5;
//                enemy.moveDownSpeed = enemy.moveDownSpeed;// - (float)(killedCnt/KILLCOUNT) * enemy.moveDownSpeed*0.5;
               [enemy moveUp];
            }else{
                tickCnt = 20;
            }
        }else if(killedCnt >= enemyCount){
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
         //boss.waitingTime = boss.waitingTime;//- (float)(boss.hp/boss.allHp) * boss.waitingTime *0.5;
         //boss.moveUpSpeed = boss.moveUpSpeed;//- (float)(boss.hp/KILLCOUNT) * boss.moveSpeed*0.5;
         //boss.moveDownSpeed = boss.moveDownSpeed ;
         [boss moveUp];
       }
    }
}

-(void)setIntervalTime:(float)time{
    enemyWaitingTime = time;
}

-(void)setEnemyMoveUpSpeed:(float)time{
    enemyMoveUpSpeed = time;
}

-(void)setEnemyMoveDownSpeed:(float)time{
    enemyMoveDownSpeed = time;
}

-(void)setBossMoveUpSpeed:(float)time{
    bossMoveUpSpeed = time;
}

-(void)setBossMoveDownSpeed:(float)time{
    bossMoveDownSpeed = time;
}

-(void)setEnemyCount:(int)count{
    enemyCount = count;
}


-(void)loadEnmey{
    [super loadEnmey];
}


-(void)bossAppear:(int)killedcnt{
    
}

@end
