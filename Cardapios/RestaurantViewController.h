//
//  RestaurantViewController.h
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 15/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *uiTvRest;
- (IBAction)actionBtnVoltar:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navItem;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationLblItem;
@property (weak, nonatomic) IBOutlet UINavigationItem *navLblItem;
@property (weak, nonatomic) IBOutlet UILabel *outletLblTitle;

@end
