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
    if(tickCnt >=10 ){
        tickCnt = 0;
        if(cnt < 14 && killedCnt < 10){
            NSLog(@"look at %d",arr[cnt]);
            enemy =[self.enemyBox objectAtIndex:arr[cnt]];
            if(enemy != nil && ![enemy isEqual:[NSNull null]] && [enemy getState] == standby){
              [enemy removeFromParentAndCleanup:YES];
              enemy = [self createEnemy:arr[cnt]];
              [self.enemyBox replaceObjectAtIndex:arr[cnt] withObject:enemy];
              [enemy moveUp];
            }else if([enemy isEqual:[NSNull null]]){
               NSLog(@"insert at %d",arr[cnt]);
               enemy = [self createEnemy:arr[cnt]];
               [self.enemyBox replaceObjectAtIndex:arr[cnt] withObject:enemy];
               [enemy moveUp];
            }
          cnt++;
        }else if(killedCnt >= 10){
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
