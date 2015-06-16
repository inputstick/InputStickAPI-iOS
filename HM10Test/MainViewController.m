/*
 * Copyright (c) 2015 mw. All rights reserved.
 */
#import <CoreBluetooth/CoreBluetooth.h>
#import "MainViewController.h"


@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self
                                                               queue:dispatch_get_main_queue()];

    self.foundPeripherals = [[NSMutableArray alloc] init];

    //Kolejkownie FIFO do BT
    //1)  dostajemy pakiet bitów,
    //      kroimy na 18+16*n, gdzie n -> <0, 15>
    //2)  może dostawać nowe dane w trakcie przesyłania, limit RAM

    //Buffor Znaków
    //  Pilnuje by nie urządzenie nie przetwarzało więcej niż 32 raportów klawiatury
    //  Czytaj, pomniejszamy licznik o porwierdzone w odpowiedzi od urządzenia.

    //      PackageGenerator:
    //          Header (2 bajty)
    //          n * Pakiet: CRC (4 bajty), Commend (1 bajt), Parametr(1 bajt), Payload, Padding do 16
    //          Payload może być pusty dla niektórych komend.

    //Klawiatura
    //  Przyjmowanie stringa jako parametr
    //      Opcje:  Layout klawiatury (default: en-us)
    //              Powielanie raportów (mnożnik do przesyłanych raportów klawiatury, 1-n)
    //  Generuje 2-bajtowe raporty klawiatury dla buffora
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    NSString *messtoshow;

    switch (central.state) {
        case CBCentralManagerStateUnknown: {
            messtoshow = @"State unknown, update imminent.";
            break;
        }
        case CBCentralManagerStateResetting: {
            messtoshow = [NSString stringWithFormat:@"The connection with the system service was momentarily lost, update imminent."];
            break;
        }
        case CBCentralManagerStateUnsupported: {
            messtoshow = [NSString stringWithFormat:@"The platform doesn't support Bluetooth Low Energy"];
            break;
        }
        case CBCentralManagerStateUnauthorized: {
            messtoshow = [NSString stringWithFormat:@"The app is not authorized to use Bluetooth Low Energy"];
            break;
        }
        case CBCentralManagerStatePoweredOff: {
            messtoshow = [NSString stringWithFormat:@"Bluetooth is currently powered off."];
            break;
        }
        case CBCentralManagerStatePoweredOn: {
            messtoshow = [NSString stringWithFormat:@"Bluetooth is currently powered on and available to use."];

            NSDictionary *options = @{CBCentralManagerScanOptionAllowDuplicatesKey : @NO};
            [self.centralManager scanForPeripheralsWithServices:nil
                                                        options:options];
            //[mgr retrieveConnectedPeripherals];
            break;
        }
    }
    NSLog(messtoshow);
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    NSArray *identifiersArray = [self.foundPeripherals valueForKeyPath:@"identifier"];
    if ([identifiersArray containsObject:peripheral.identifier]) {
        return;
    }
    NSLog(@"Executed = %s", __PRETTY_FUNCTION__);
    [self.foundPeripherals addObject:peripheral];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"Cell"];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.foundPeripherals.count;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CBPeripheral *peripheral = self.foundPeripherals[(NSUInteger) indexPath.item];
    cell.textLabel.text = peripheral.name;
    cell.detailTextLabel.text = [peripheral.identifier UUIDString];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CBPeripheral *selectedPeripheral = self.foundPeripherals[(NSUInteger) indexPath.row];
    [self.centralManager connectPeripheral:selectedPeripheral options:nil];
    selectedPeripheral.delegate = self;
    self.connectedPeripheral = selectedPeripheral;
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    [peripheral discoverServices:nil];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    for (CBService *service in peripheral.services) {
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    NSLog(@"Executed = %s", __PRETTY_FUNCTION__);
    for (CBCharacteristic *characteristic in service.characteristics) {
        [peripheral discoverDescriptorsForCharacteristic:characteristic];
        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    NSLog(@"Executed = %s", __PRETTY_FUNCTION__);
    self.discoveredCharacteristic = characteristic;
//    for (int i = 0; i < 1000; ++i) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.02 * i * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self sendValueToSelectedPeripheral];
//        });
//    }
}

- (void)sendValueToSelectedPeripheral {
//    NSUInteger sizeOfBuffer = 4;
//    unsigned char *buffer = malloc(sizeOfBuffer);
//    buffer[0] = 0x55;
//    buffer[1] = 0x56;
//    buffer[2] = 0x57;
//    buffer[3] = 0x58;
//    NSData *dataToSend = [NSData dataWithBytes:buffer length:sizeOfBuffer];
//    NSData *dataToSend = [NSData dataWithBytes:(unsigned char[]) {0x55, 0x02, 0xC0, 0x41, 0x68, 0xFC, 0x21, 0x03, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00} length:34];
    NSData *dataToSend = [NSData dataWithBytes:(unsigned char[]) {0x55, 0x01, 0x00, 0x00, 0x00, 0x00, 0x2C, 0x06, 0x00, 0x04, 0x00, 0x05, 0x00, 0x28, 0x00, 0x00, 0x00, 0x00} length:18];
    [self.connectedPeripheral writeValue:dataToSend forCharacteristic:self.discoveredCharacteristic
                                    type:CBCharacteristicWriteWithoutResponse];
    NSLog(@"did write some shit");
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
//    NSLog(@"Executed = %s", __PRETTY_FUNCTION__);
    NSLog(@"value = %@", characteristic.value);

    //Parse InputStick status update
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"Executed = %s", __PRETTY_FUNCTION__);
}


@end
