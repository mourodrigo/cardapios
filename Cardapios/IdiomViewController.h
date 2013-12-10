//
//  ViewController.h
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 24/11/13.
//  Copyright (c) 2013 mourodrigo. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface IdiomViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *outletImgLogo;

@property (weak, nonatomic) IBOutlet UIButton *outletBtnPortuguese;
- (IBAction)actionBtnPortuguese:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletBtnEnglish;
- (IBAction)actionBtnEnglish:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletBtnSpanish;
- (IBAction)actionBtnSpanish:(id)sender;

@end
