//
//  GHSubmitGuideCell.h
//  GaoHeng
//
//  Created by hua on 16/8/1.
//  Copyright © 2016年 heyudongfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHSubmitGuideCell : UITableViewCell
 
@property(nonatomic,strong)UIButton *submitButton;
 
+(GHSubmitGuideCell *)cellWithTableView:(UITableView *)tableView;
@end
