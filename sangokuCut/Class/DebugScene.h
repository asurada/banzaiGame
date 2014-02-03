//
//  DebugScene.h
//  sangokuCut
//
//  Created by Yan Wei on 2013/11/29.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "BaseScene.h"
#import "CCLayer.h"
#import "CCScene.h"
#import "cocos2d.h"

@interface DebugScene : CCLayerColor<UITextFieldDelegate>{
    UITextField *_enemyCountInputField;
    UITextField *_enemyMoveUpInputField;
    UITextField *_enemyMoveDownSpeedInputField;
    UITextField *_enemyWaitingTimeInputField;
}

@property (nonatomic, retain) IBOutlet UITextField *enemyCountInputField;
@property (nonatomic, retain) IBOutlet UITextField *enemyMoveUpInputField;
@property (nonatomic, retain) IBOutlet UITextField *enemyMoveDownSpeedInputField;
@property (nonatomic, retain) IBOutlet UITextField *enemyWaitingTimeInputField;


+(CCScene *) scene;

@end
