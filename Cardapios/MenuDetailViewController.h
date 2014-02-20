//
//  MenuDetailViewController.h
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 20/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuDetailViewController : UIViewController
- (IBAction)actionBtnHeart:(id)sender;
- (IBAction)actionBtnVoltar:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *outletNomeRest;
@property (weak, nonatomic) IBOutlet UITextView *txtDetailRest;
@property (weak, nonatomic) IBOutlet UIButton *outletValue;
@property (weak, nonatomic) IBOutlet UILabel *outletPrato;

@end
