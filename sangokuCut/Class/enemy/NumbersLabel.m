//
//  NumbersLabel.m
//  sangokuCut
//
//  Created by 厳 巍 on 2013/11/30.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "NumbersLabel.h"
#import "Number.h"

@implementation NumbersLabel


-(id)init{
    numList = [[NSMutableArray alloc]init];
   /// Number *numlabel = [Number spriteWithFile:@"num_0.png"];
   /// [numList addObject:numlabel];
   // [self addChild:numlabel];
    return [super init];
}

+(id)spriteWithFile:name{
    
    return [super spriteWithFile:name];
}



-(void)showNum:(int)num{
    number = num;
    //一旦 NSNumber型にキャストする
    NSNumber *numberValue = [[NSNumber alloc] initWithInt:num];
    
    //桁数を求める
    NSInteger digits = (int)log10([numberValue doubleValue]) + 1;

    if(num == 0){
        Number *numlabel = [Number spriteWithFile:@"num_0.png"];
        numlabel.position = ccp(numlabel.position.x, numlabel.position.y);
        [numList addObject:numlabel];
        [self addChild:numlabel];
        return;
    }
    
    for(int index = 0; index< digits;index++){
        if([numList count]<index+1){
            Number *numlabel = [Number spriteWithFile:@"num_1.png"];
            numlabel.position = ccp(numlabel.position.x + 20 * index, numlabel.position.y);
            [numList addObject:numlabel];
            [self addChild:numlabel];
        }
        int value = 0;
        if(index == 0){
            value = num/pow(10, digits-1);
        }else{
            value = ((int)(num/pow(10, digits-index-1)) % 10);
        }
        Number *numlabel = [numList objectAtIndex:index];
        [numlabel showNum:value];
    }
}

@end
