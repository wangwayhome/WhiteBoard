//
//  CustomFlowTextField.m
//  WhiteBoard
//
//  Created by wangwayhome on 2018/2/22.
//  Copyright © 2018年 App Lab. All rights reserved.
//

#import "CustomFlowTextField.h"

@implementation CustomFlowTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesMoved:touches withEvent:event];
    
    UITouch * touch = [touches anyObject];
    //本次触摸点
    CGPoint current = [touch locationInView:self];
    //上次触摸点
    CGPoint previous = [touch previousLocationInView:self];
    //未移动的中心点
    CGPoint center = self.center;
    //移动之后的中心点(未移动的点+本次触摸点-上次触摸点)
    center.x += current.x - previous.x;
    center.y += current.y - previous.y;
    //更新位置
    self.center = center;
    
    

}

@end
