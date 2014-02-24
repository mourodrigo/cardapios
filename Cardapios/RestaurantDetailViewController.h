//
//  RestaurantDetailViewController.h
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 15/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantDetailViewController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *lblTitle;
@property (weak, nonatomic) IBOutlet UIScrollView *outletScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *outletImgViewLogo;
@property (weak, nonatomic) IBOutlet UILabel *outletLblName;
@property (weak, nonatomic) IBOutlet UILabel *outletLblType;
@property (weak, nonatomic) IBOutlet UILabel *outletLblCity;
@property (weak, nonatomic) IBOutlet UILabel *outletLblEmail;
@property (weak, nonatomic) IBOutlet UIImageView *outletImgView;
@property (weak, nonatomic) IBOutlet UILabel *outletLblAbout;
@property (weak, nonatomic) IBOutlet UITextView *outletTxtAbout;
@property (weak, nonatomic) IBOutlet UILabel *outletLblTime;
@property (weak, nonatomic) IBOutlet UILabel *outletLblTimeDetail;
@property (weak, nonatomic) IBOutlet UILabel *outletLblCards;
@property (weak, nonatomic) IBOutlet UIImageView *outletImgAmex;
@property (weak, nonatomic) IBOutlet UIImageView *outletImgMaster;
@property (weak, nonatomic) IBOutlet UIImageView *outletImgVisa;
@property (weak, nonatomic) IBOutlet UIButton *outletBtnMenu;
- (IBAction)actionBtnMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletBtnStar;
- (IBAction)actionBtnStar:(id)sender;
- (IBAction)actionBtnVoltar:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletBtnCall;
- (IBAction)actionBtnCall:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *outletBtnRoute;
- (IBAction)actionBtnRoute:(id)sender;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navItem;
@property (weak, nonatomic) IBOutlet UINavigationItem *navLblItem;
@property (weak, nonatomic) IBOutlet UILabel *outletLblTitle;
@property (weak, nonatomic) IBOutlet UILabel *outletLblCall;
@property (weak, nonatomic) IBOutlet UILabel *outletLblRoute;
@property (strong, nonatomic) IBOutlet UIButton *outletDireita;
- (IBAction)actionDireita:(id)sender;
- (IBAction)actionEsquerda:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *outletEsquerda;
@end
