//
//  GHSubmitGuideCell.m
//  GaoHeng
//
//  Created by hua on 16/8/1.
//  Copyright © 2016年 heyudongfang. All rights reserved.
//

#import "GHSubmitGuideCell.h"
 
@implementation GHSubmitGuideCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {   // 初始化子控件
        [self setupView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;//设置cell无选中状态无
    }
    return self;
}

- (void)setupView {
    CGFloat width = 310;
    CGFloat height = (82-40)/3;

    
    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitButton.enabled =NO;
    self.submitButton.frame = CGRectMake(width -20-14, height, 20, 20);
    [self.submitButton setBackgroundImage:[UIImage imageNamed:@"yueke_noselect"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.submitButton];
   
 }
 
+(GHSubmitGuideCell *)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ident = @"gHSubmitGuideCell";
    
    GHSubmitGuideCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
   // if (!cell) {
        
        cell = [[GHSubmitGuideCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        
   // }
    return cell;
    
}


@end
