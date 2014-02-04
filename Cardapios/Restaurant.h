//
//  Restaurant.h
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 04/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Restaurant : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * american;
@property (nonatomic, retain) NSNumber * cash;
@property (nonatomic, retain) NSString * cellphone;
@property (nonatomic, retain) NSString * cep;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * cnpj;
@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSString * district;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * image1;
@property (nonatomic, retain) NSString * image2;
@property (nonatomic, retain) NSString * image3;
@property (nonatomic, retain) NSString * image4;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSString * logo;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * master;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * phone1;
@property (nonatomic, retain) NSString * phone2;
@property (nonatomic, retain) NSString * text_en;
@property (nonatomic, retain) NSString * text_es;
@property (nonatomic, retain) NSString * text_pt;
@property (nonatomic, retain) NSDate * timeClose;
@property (nonatomic, retain) NSDate * timeOpen;
@property (nonatomic, retain) NSDate * visa;

@end
