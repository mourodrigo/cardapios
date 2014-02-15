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

@end
