//
//  ViewController.h
//  WhiteBoard
//
//  Created by App Lab on 3/5/14.
//  Copyright (c) 2014 App Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingView.h"
#import "CustomFlowTextField.h"
@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet DrawingView *drawView;
@property (strong, nonatomic) IBOutlet CustomFlowTextField *textfield;

- (IBAction)changePathColor:(UIButton *)sender;
@end
