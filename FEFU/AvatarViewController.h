//
//  AvatarViewController.h
//  FEFU
//
//  Created by Илья on 19.11.15.
//  Copyright © 2015 FARPOST. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvatarViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *picture;

@property (nonatomic, strong) UIImage *pictureValue;

@end
