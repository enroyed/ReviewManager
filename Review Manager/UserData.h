//
//  UserData.h
//  Review Manager
//
//  Created by enroyed on 7/25/12.
//  Copyright (c) 2012 enroyed. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : NSObject{
    NSString *rating;
    NSString *userName;
    NSString *userEmail;
    NSString *userCity;
    NSString *userPhone;
    NSString *userComment;
    NSString *answers;
    NSString *a1,*a2,*a3,*a4,*a5;
    
}

@property(nonatomic) NSString *rating,*a1,*a2,*a3,*a4,*a5;
@property(nonatomic) NSString *userName,*userEmail,*userCity,*userPhone,*userComment;
@property(nonatomic) NSString *answers;


@end
