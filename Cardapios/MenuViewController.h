//
//  MenuViewController.h
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 20/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *uitvmenu;
- (IBAction)actionBtnVoltar:(id)sender;

@end
