# ReactiveCocoa
reactiveCocoa的使用基本介绍

Demo介绍了ReactiveCocoa的以下几个功能.
1、按钮事件的监听
方式一、//监听按钮事件
	[[nextView.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
	 subscribeNext:^(id x) {
		 NSLog(@"下一步按钮点击");
//		 return [RACSignal empty];
	 }];
方式二：
//按钮事件监听
	[self.closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside];
	self.closeBtn.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
		STRONGSELF;
		NSLog(@"关闭按钮点击");
		[strongSelf.phoneTextField resignFirstResponder];
		[strongSelf.passwordTextField resignFirstResponder];
		return [RACSignal empty];
	}];
  
  2、通知中心事件
  self.observer = [[NSNotificationCenter defaultCenter]
					 addObserverForName:UIKeyboardWillShowNotification
					 object:nil
					 queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
//						 STRONGSELF;
						 NSLog(@"textField clicked");
						 
					 }];
3、监听文本框文字的改变
[_phoneTextField.rac_textSignal subscribeNext:^(id x) {
		NSLog(@"手机号码1:%@",x);
	}];
 
 4、页面处理多次请求，多个请求执行完成才刷新界面
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
  
  - (void)updateUI:(NSString *)data1 data2:(NSString *)data2
{
	NSLog(@"更新UI");
}
