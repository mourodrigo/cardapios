//
//  Map.h
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 19/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface Map : UIViewController <MKMapViewDelegate>
- (IBAction)actionBtnSair:(id)sender;
@property (weak, nonatomic) IBOutlet MKMapView *outletmap;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *navItem;
@property (weak, nonatomic) IBOutlet UILabel *outletLblTitle;

@end
