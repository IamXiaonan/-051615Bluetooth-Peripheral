//
//  ViewController.m
//  -051615Bluetooth-Peripheral
//
//  Created by Xiaonan Wang on 5/16/15.
//  Copyright (c) 2015 Xiaonan Wang. All rights reserved.
//

#import "ViewController.h"
#define kServiceUUID @"6BC6543C-2398-4E4A-AF28-E4E0BF58D6BC"
#define kCharacteristicUUID @"9D69C18C-186C-45EA-A7DA-6ED7500E9C97"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    _peripheral = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
    
    
    //The services and characteristics of a peripheral are identified by 128-bit Bluetooth-special UUIDs, which are represented in the CB framework by CBUUID objects.
    //Bluetooth Special Interest Group has predefined the 16-bit UUID for convenience.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate
- (void)setupService {
    // Creates the characteristic UUID
    CBUUID *serviceUUID = [CBUUID UUIDWithString:kServiceUUID];
    CBUUID *characteristicUUID = [CBUUID UUIDWithString:kCharacteristicUUID];
    NSString *str = @"test";
    NSData *myValue = [str dataUsingEncoding:NSUTF8StringEncoding];
    CBMutableCharacteristic *myCharacteristic = [[CBMutableCharacteristic alloc]initWithType:characteristicUUID properties:CBCharacteristicPropertyRead value:myValue permissions:CBAttributePermissionsReadable];
    CBMutableService *myService = [[CBMutableService alloc] initWithType:serviceUUID primary:YES];
    myService.characteristics = @[myCharacteristic];
    [_peripheral addService:myService];
    [_peripheral startAdvertising:@{CBAdvertisementDataServiceUUIDsKey:@[myService.UUID]}];
}


-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    switch (peripheral.state) {
        case CBPeripheralManagerStatePoweredOn:
            [self setupService];
            break;
        default:
            [_LogBoard setText:(@"Peripheral Manager did change state")];
            break;
    }}

-(void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error{
    if (error) {
        NSString *errorde = [error localizedDescription];
        [_LogBoard setText:errorde];
    }else{
        [_LogBoard setText:(@"no error add")];
    }
}

-(void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral error:(NSError *)error{
    if (error) {
        [_LogBoard setText:[error localizedDescription]];
    }else{
        [_LogBoard setText:(@"no error")];
    }
}

@end
