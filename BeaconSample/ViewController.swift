//
//  ViewController.swift
//  BeaconSample
//
//  Created by Ryan Khalili on 3/6/15.
//  Copyright (c) 2015 CSR. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class ViewController: UIViewController, CBPeripheralManagerDelegate {

    let beaconID = "CSR beacon"
    let beaconUUID = "4B5B9305-BA7F-4E69-B985-FB505253D81F"
    
    var cbManager: CBPeripheralManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        cbManager = CBPeripheralManager( delegate: self, queue: nil )
    }
    
    func startAdvertisingAsBeacon() {
        let uuid = NSUUID( UUIDString: beaconUUID )
        let beaconRegion = CLBeaconRegion( proximityUUID: uuid, identifier: beaconID )
        beaconRegion.notifyEntryStateOnDisplay = true
        
        let peripheralData = beaconRegion.peripheralDataWithMeasuredPower( nil )
        cbManager.startAdvertising( peripheralData )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager!, error: NSError!) {
        
        println( "Now advertising as beacon!" )
    }
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
        switch peripheral.state {
            case CBPeripheralManagerState.Unknown:
                print( "Unknown" )
            case CBPeripheralManagerState.Resetting:
                print( "Resetting" )
            case CBPeripheralManagerState.Unsupported:
                print( "Unsupported" )
            case CBPeripheralManagerState.Unauthorized:
                print( "Unsupported" )
            case CBPeripheralManagerState.PoweredOn:
                print( "Powered On" )
                startAdvertisingAsBeacon()
            case CBPeripheralManagerState.PoweredOff:
                print( "Powered Off" )
            default:
                print( "Default" )
        }
    }
}

