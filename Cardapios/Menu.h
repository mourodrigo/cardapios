//
//  Menu.h
//  Cardapios
//
//  Created by Rodrigo Bueno Tomiosso on 04/02/14.
//  Copyright (c) 2014 mourodrigo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Menu : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * idCategory;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * idRestaurant;
@property (nonatomic, retain) NSString * descr;
@property (nonatomic, retain) NSNumber * value;

@end
