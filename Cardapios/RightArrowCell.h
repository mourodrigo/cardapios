//
//  RightArrowCell.h
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 14/01/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RightArrowCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *outletLblTitle;
@property (weak, nonatomic) IBOutlet UILabel *outletLblSubTitle;
@property (weak, nonatomic) IBOutlet UIImageView *outletImgArrow;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navItem;

@end
