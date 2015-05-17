//
//  ViewController.h
//  -051615Bluetooth-Peripheral
//
//  Created by Xiaonan Wang on 5/16/15.
//  Copyright (c) 2015 Xiaonan Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController : UIViewController<CBPeripheralManagerDelegate>

@property (nonatomic) CBPeripheralManager *peripheral;
@property (weak, nonatomic) IBOutlet UILabel *LogBoard;


@end

