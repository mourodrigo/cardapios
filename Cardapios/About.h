//
//  About.h
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 22/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface About : UIViewController
@property (weak, nonatomic) IBOutlet UINavigationItem *navLblItem;
- (IBAction)actionBtnMsg:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *outletTxt;

- (IBAction)actionBtnVoltar:(id)sender;
@end
