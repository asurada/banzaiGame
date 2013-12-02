//
//  DebugScene.m
//  sangokuCut
//
//  Created by Yan Wei on 2013/11/29.
//  Copyright (c) 2013年 厳 巍. All rights reserved.
//

#import "DebugScene.h"


@implementation DebugScene



@synthesize enemyCountInputField = _enemyCountInputField;
@synthesize enemyMoveUpInputField = _enemyMoveUpInputField;
@synthesize enemyMoveDownSpeedInputField = _enemyMoveDownSpeedInputField;
@synthesize enemyWaitingTimeInputField = _enemyWaitingTimeInputField;



+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	DebugScene *layer = [DebugScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
	// return the scene
	return scene;
}

-(id) init
{
    // always call "super" init
    // Apple recommends to re-assign "self" with the "super" return value
    if( (self=[super initWithColor:ccc4(0, 0, 0,255)])){
        
         _enemyCountInputField = [[UITextField alloc] initWithFrame:CGRectMake(100,100,150,30)];//设置文本框大小和位置
        [_enemyCountInputField setBackgroundColor:[UIColor yellowColor]];//背景色
        [_enemyCountInputField setTextAlignment:UITextAlignmentCenter];//水平居中
        _enemyCountInputField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//垂直居中
        [_enemyCountInputField setFont:[UIFont fontWithName:@"Bauhaus Md BT" size:22]];
        [_enemyCountInputField setText:@"CoreyGuo"];
        [_enemyCountInputField becomeFirstResponder];//弹出键盘
        //inputField.autocorrectionType = UITextAutocorrectionTypeNo;
        //inputField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _enemyCountInputField.returnKeyType = UIReturnKeyDone;
        [_enemyCountInputField setTextColor:[UIColor colorWithRed:96/255.0f green:55/255.0f blue:17/255.0f alpha:1]];
        _enemyCountInputField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
        //inputField.secureTextEntry = YES;  //如果是密码框时 ,加上这句
        _enemyCountInputField.delegate=self;
        [[[CCDirector sharedDirector] openGLView] addSubview:_enemyCountInputField];
        
        self.isTouchEnabled=YES;
    }
    return self;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField.text length] == 8) { //字符限制
        if ([string length] < 1) {  //用于相应退格事件
            textField.text = [textField.text substringToIndex:[textField.text length] - 1];  //如果用户点击退格，那么将文本内容去一位
        }
        return FALSE;  //返回FALSE，文本框就不会相应键盘上的输入，包括退格
    }
    return TRUE;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidEndEditing");//完成后要处理的事件
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [inputField resignFirstResponder];//表示关闭键盘
}

- (void) dealloc
{
    // in case you have something to dealloc, do it in this method
    // in this particular example nothing needs to be released.
    // cocos2d will automatically release all the children (Label)
    [_enemyCountInputField removeFromSuperview];
    [_enemyCountInputField release];
    
    // don't forget to call "super dealloc"
    [super dealloc];
}


@end
