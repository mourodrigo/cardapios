//
//  CityViewController.h
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 14/01/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityViewController : UIViewController //<UITableViewDataSource, UITableViewDelegate>
- (IBAction)actionBtnVoltar:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *uiTvCity;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navItem;
@property (weak, nonatomic) IBOutlet UINavigationItem *navLblItem;
@property (weak, nonatomic) IBOutlet UILabel *outletLblTitle;

@end
