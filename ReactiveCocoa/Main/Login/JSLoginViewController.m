//
//  JSLoginViewController.m
//  ReactiveCocoa
//
//  Created by Power on 2018/2/7.
//  Copyright © 2018年 Power. All rights reserved.
//

#import "JSLoginViewController.h"
#import "PVNextView.h"

@interface JSLoginViewController ()

@property (nonatomic, strong) id observer;

@end

@implementation JSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	WEAKSELF;
	//按钮事件监听
	[self.closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
	self.closeBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
		STRONGSELF;
		NSLog(@"关闭按钮点击");
		[strongSelf.phoneTextField resignFirstResponder];
		[strongSelf.passwordTextField resignFirstResponder];
		return [RACSignal empty];
	}];
	
	//通知中心事件
	self.observer = [[NSNotificationCenter defaultCenter]
					 addObserverForName:UIKeyboardWillShowNotification
					 object:nil
					 queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
//						 STRONGSELF;
						 NSLog(@"textField clicked");
						 
					 }];
	
	PVNextView *nextView = [[PVNextView alloc] initWithFrame:CGRectZero];
	[self.view addSubview:nextView];
	[nextView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.left.right.mas_equalTo(self.view);
		make.height.mas_equalTo(44);
	}];

	//监听按钮事件
	[[nextView.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
	 subscribeNext:^(id x) {
		 NSLog(@"下一步按钮点击");
//		 return [RACSignal empty];
	 }];
	
	//监听文本框文字的改变
	[_phoneTextField.rac_textSignal subscribeNext:^(id x) {
		NSLog(@"手机号码1:%@",x);
	}];
	[_phoneTextField.rac_textSignal subscribeNext:^(id x) {
		NSLog(@"手机号码2:%@",x);
	} completed:^{
		NSLog(@"输入完成");
	}];
	
	//页面处理多次请求，多个请求执行完成才刷新界面
	RACSignal *requestFirst = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			NSLog(@"第一个请求");
			[subscriber sendNext:@"第一个请求"];
			[subscriber sendCompleted];
		});
		return nil;
	}];
	RACSignal *requestSecond = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			NSLog(@"第二个请求");
			[subscriber sendNext:@"第二个请求"];
			[subscriber sendCompleted];
		});
		return nil;
	}];
	[self rac_liftSelector:@selector(updateUI:data2:) withSignalsFromArray:@[requestFirst,requestSecond]];
}

- (void)updateUI:(NSString *)data1 data2:(NSString *)data2
{
	NSLog(@"更新UI");
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self.observer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)closeVC:(UIButton *)sender {
}
- (IBAction)loginAction:(UIButton *)sender {
}

- (IBAction)registerAction:(UIButton *)sender {
}
@end
