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
#define KILLCOUNT ((int)50)

@implementation Logic_Showup_01

bool stateMove;
bool bossAppear;
int cnt = 0;
BaseCharacter *boss;
@synthesize enemyClearCount;




-(int)showEnemey:(int)tickCnt killed:(int)killedCnt{
    int arr[] = {
        0, 1, 2, 5, 4, 3, 6, 7, 8, 0, 2, 4, 6, 8
    };

    BaseCharacter *enemy = nil;
    if(tickCnt >= 20 - killedCnt/10 *1.5){
        tickCnt = 0;
        int position = arc4random()%9;
        //position = arr[cnt];
        if(cnt < 14 && killedCnt < KILLCOUNT){
            NSLog(@"look at %d",position);
            enemy =[self.enemyBox objectAtIndex:position];
            if(enemy != nil && ![enemy isEqual:[NSNull null]] && [enemy getState] == standby){
               [enemy removeFromParentAndCleanup:YES];
               enemy = [self createEnemy:position];
               [self.enemyBox replaceObjectAtIndex:position withObject:enemy];
               enemy.waitingTime = enemy.waitingTime - (float)(killedCnt/KILLCOUNT) *enemy.waitingTime *0.5;
               enemy.moveUpSpeed = enemy.moveUpSpeed - (float)(killedCnt/KILLCOUNT) * enemy.moveUpSpeed*0.5;
               enemy.moveDownSpeed = enemy.moveDownSpeed - (float)(killedCnt/KILLCOUNT) * enemy.moveDownSpeed*0.5;
               [enemy moveUp];
            }else if([enemy isEqual:[NSNull null]]){
               NSLog(@"insert at %d",position);
               enemy = [self createEnemy:position];
               [self.enemyBox replaceObjectAtIndex:position withObject:enemy];
               enemy.waitingTime = enemy.waitingTime - (float)(killedCnt/KILLCOUNT) *enemy.waitingTime *0.5;
               enemy.moveUpSpeed = enemy.moveUpSpeed - (float)(killedCnt/KILLCOUNT) * enemy.moveUpSpeed*0.5;
               enemy.moveDownSpeed = enemy.moveDownSpeed - (float)(killedCnt/KILLCOUNT) * enemy.moveDownSpeed*0.5;
               [enemy moveUp];
            }else{
                tickCnt = 20;
            }
          cnt++;
        }else if(killedCnt >= KILLCOUNT){
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
        }else if (cnt == 14){
            cnt = 0;
        }
        
     }else{
        
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
         boss.waitingTime = boss.waitingTime ;//- (float)(boss.hp/boss.allHp) * boss.waitingTime *0.5;
         boss.moveUpSpeed = boss.moveUpSpeed ;//- (float)(boss.hp/KILLCOUNT) * boss.moveSpeed*0.5;
         boss.moveDownSpeed = boss.moveDownSpeed ;
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
