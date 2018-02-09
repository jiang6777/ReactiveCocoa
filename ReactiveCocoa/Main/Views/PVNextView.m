//
//  PVNextView.m
//  ReactiveCocoa
//
//  Created by Power on 2018/2/8.
//  Copyright © 2018年 Power. All rights reserved.
//

#import "PVNextView.h"

@implementation PVNextView


- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self _initViews];
	}
	return self;
}

- (void)_initViews
{
	self.nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
	[self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[self.nextBtn setBackgroundColor:[UIColor blueColor]];
	self.nextBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
	[self addSubview:self.nextBtn];
	
	[self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.mas_equalTo(self);
	}];
}
@end
