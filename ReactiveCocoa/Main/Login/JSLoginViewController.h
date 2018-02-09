//
//  JSLoginViewController.h
//  ReactiveCocoa
//
//  Created by Power on 2018/2/7.
//  Copyright © 2018年 Power. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
- (IBAction)loginAction:(UIButton *)sender;
- (IBAction)registerAction:(UIButton *)sender;

@end
