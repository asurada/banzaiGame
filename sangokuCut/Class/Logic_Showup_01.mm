//
//  Logic_Showup_01.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/08/22.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "Logic_Showup_01.h"
#import "BaseCharacter.h"

@implementation Logic_Showup_01

bool stateMove;
int cnt = 0;




-(int)showEnemey:(int)tickCnt{
    int arr[] = {
        0, 1, 2, 5, 4, 3, 6, 7, 8, 0, 2, 4, 6, 8
    };

    BaseCharacter *enemy = nil;
    if(tickCnt >=10) {
        tickCnt = 0;
        if(cnt < 14){
          NSLog(@"look at %d",arr[cnt]);
          enemy =[self.enemyBox objectAtIndex:arr[cnt]];
          if(enemy != nil && ![enemy isEqual:[NSNull null]] && [enemy getState] == standby){
            [enemy moveUp]; 
          }else if([enemy isEqual:[NSNull null]]){
             NSLog(@"insert at %d",arr[cnt]);
             enemy = [self createEnemey:arr[cnt]];
             [self.enemyBox replaceObjectAtIndex:arr[cnt] withObject:enemy];
             [enemy moveUp];
          }
          cnt++;
        }else{
           cnt = 0;
        }
    }
    return tickCnt;
}

-(void)loadEnmey{
    [super loadEnmey];
}

@end
