//
//  Search.h
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 17/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Search : UIViewController <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *uiTVSearch;
@property (weak, nonatomic) IBOutlet UISearchBar *outletSearchBar;
@property (weak, nonatomic) IBOutlet UIButton *outletBtnRest;
- (IBAction)actionBtnRest:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletBtnMenu;
- (IBAction)actionBtnMenu:(id)sender;
- (IBAction)actionBtnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationItem *outletNavItem;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navItem;
@property (weak, nonatomic) IBOutlet UINavigationItem *navLblItem;

@end
