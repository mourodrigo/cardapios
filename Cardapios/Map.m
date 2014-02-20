//
//  Map.m
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 19/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import "Map.h"
#import <MapKit/MapKit.h>
#import "AppDelegate.h"

@implementation Map{
    AppDelegate *delegate;
    NSDictionary *info;
}
@synthesize outletmap;

-(void)viewDidLoad{
     delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    info= [[delegate sqliteDoQuery:[NSString stringWithFormat:@"Select * from ZRESTAURANT where Z_PK = %d", delegate.idRestSelected]] objectAtIndex:0];
    [self atualizaPontosMapa];
}


-(void)atualizaPontosMapa{
    //NSLog(@"annotations %@", outletMapaPrincipal.annotations);
    [outletmap removeAnnotations:outletmap.annotations];
    NSLog(@"info %@", info)
    ;
    
    
        CLLocationCoordinate2D coord = {[[info objectForKey:@"ZLATITUDE"] floatValue],[[info objectForKey:@"ZLONGITUDE"] floatValue]};
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setTitle:[NSString stringWithFormat:@"%@",[info objectForKey:@"ZNAME"]]];
        [annotation setCoordinate:coord];
        
        
        [outletmap addAnnotation:annotation];
    
    
    outletmap.showsUserLocation = TRUE;
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in outletmap.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0.1, 0.1);
        zoomRect = MKMapRectUnion(zoomRect, pointRect);
        
    }
    //adicionado 2000 para afastar o mapa dos pontos em questão
    zoomRect = MKMapRectMake(zoomRect.origin.x-4000, zoomRect.origin.y-4000, zoomRect.size.width+4000*2, zoomRect.size.height+4000*2);
    
  
   ;
    [outletmap setVisibleMapRect:zoomRect animated:YES];
}

- (IBAction)actionBtnSair:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    NSLog(@"updated user location");
    [self atualizaPontosMapa];
}

@end
