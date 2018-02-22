//
//  ViewController.m
//  WhiteBoard
//
//  Created by App Lab on 3/5/14.
//  Copyright (c) 2014 App Lab. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
{
  //记录其imag
        UIImageView *img;    //操作的视图
        CGRect oldFrame;
}
@end

@implementation ViewController
- (void)viewDidLoad{
    [super viewDidLoad];
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroungHit:)];
    tapGes.delegate = self;
    [self.view addGestureRecognizer:tapGes];//textfield 点击消失
    [self addGestureRecognizerToView:_textfield];
    
    {//模拟图片
        img = [[UIImageView alloc]initWithFrame:CGRectMake(60, 100, 281, 99)];
        [img setImage:[UIImage imageNamed:@"logo.jpg"]];
        oldFrame = img.frame;
        img.userInteractionEnabled = YES;
        [self addGestureRecognizerToView:img];
        [self.view addSubview:img];
    }
    
}

#pragma mark - 处理所有手势
// 正确姿势
- (void) addGestureRecognizerToView:(UIView *)view
{
    // 根据需求选择要添加的手势
    // 旋转手势
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [view addGestureRecognizer:rotationGesture];
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGesture];
    
    // 移动手势
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGesture];
}

#pragma mark 处理旋转
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGesture
{
    UIView *view = rotationGesture.view;
    if (rotationGesture.state == UIGestureRecognizerStateBegan || rotationGesture.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGesture.rotation);
        [rotationGesture setRotation:0];
        //log下查看view.transform是怎么处理原理
        
    }
}

- (void) pinchView:(UIPinchGestureRecognizer *)pinchGesture
{
    
    UIView *view = pinchGesture.view;
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan || pinchGesture.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGesture.scale, pinchGesture.scale);
        if (img.frame.size.width <= oldFrame.size.width ) {
            [UIView beginAnimations:nil context:nil]; // 开始动画
            [UIView setAnimationDuration:0.5f]; // 动画时长
            /**
             *  固定一倍
             */
            view.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
            [UIView commitAnimations]; // 提交动画
        }
        if (img.frame.size.width > 3 * oldFrame.size.width) {
            [UIView beginAnimations:nil context:nil]; // 开始动画
            [UIView setAnimationDuration:0.5f]; // 动画时长
            /**
             *  固定三倍
             */
            view.transform = CGAffineTransformMake(3, 0, 0, 3, 0, 0);
            [UIView commitAnimations]; // 提交动画
        }
        NSLog(@"%@",NSStringFromCGAffineTransform(view.transform)) ;
        
        pinchGesture.scale = 1;
    }
}

#pragma mark 处理拖拉
-(void)panView:(UIPanGestureRecognizer *)panGesture
{
    UIView *view = panGesture.view;
    if (panGesture.state == UIGestureRecognizerStateBegan || panGesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGesture translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGesture setTranslation:CGPointZero inView:view.superview];
    }
}

#pragma mark - 线条


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(motion == UIEventSubtypeMotionShake)
    {
        [_drawView clear];
    }
}

- (IBAction)changePathColor:(UIButton *)sender
{
    if(sender.tag == 1)
    {
        [_drawView setPathColor:[UIColor blueColor]];
    }
    else if(sender.tag == 2)
    {
        [_drawView setPathColor:[UIColor greenColor]];
    }
    else if(sender.tag == 3)
    {
        [_drawView setPathColor:[UIColor purpleColor]];
    }
    else if(sender.tag == 4)
    {
        [_drawView setPathColor:[UIColor redColor]];
    }
    else if(sender.tag == 5)
    {
        [_drawView setPathColor:[UIColor yellowColor]];	
    }
}
#pragma mark - textfield
- (void)onBackgroungHit:(id)sender {
        [_textfield resignFirstResponder];
}
@end
