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

int cnt;
-(int)showEnemey:(int)tickCnt{
    if(cnt == 0){
        stateMove = true;
    }else if (cnt == 9){
        stateMove = false;
    }
    if(tickCnt >=10) {
        tickCnt = 0;
        for (BaseCharacter *enemy in self.enemyBox) {
            if(stateMove){
                if([enemy getState] == standby){
                    [enemy moveUp];
                    cnt++;
                    return tickCnt;
                }
            }else{
                if([enemy getState] == healthy){
                    [enemy moveDown];
                    cnt--;
                    return tickCnt;
                }
                
            }
        }
    }    
    return tickCnt;
    
}

-(void)loadEnmey{
    [super loadEnmey];
}

@end
