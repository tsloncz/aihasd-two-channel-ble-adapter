//
//  AihasdTwoChannelBleAdapter
//  AihasdTwoChannelBleAdapter
//
//  Created by Tim Sloncz on 1/21/17.
//  Copyright © 2018 LyttleBit. All rights reserved.
//

import Foundation
import CoreBluetooth

// Builds data for communitaction with Aihasd Two Channel BLE Board
public class AihasdTwoChannelBleAdapter {
    
    // Board Info
    private let boardServiceUUID = 0xFFE0
    private let boardCharacterisicUUID = 0xFFE1
    private let boardPassword = "12345678"
    private var relayOneOnString = "c5043132333435363738aa"
    private var relayOneOffString = "c5063132333435363738aa"
    var onCharactoristic: CBCharacteristic!
    // CBService: 0x174e76780, isPrimary = YES, UUID = FFE0
    // identifier: 49B7B4B9-D104-486E-8F7B-A55C522CCAA9
    // Writes values to board
    
    // Board suppported commands
    public enum BoardCommand {
        case .relayOneOn
        case .relayTwoOff
        case .relayTwoOn
        case .relayTwoOff
    }
    
    private let byteOneRelayOneOn = UInt16(0xc504).bigEndian//NSData(bytes: [UInt16(0xc504).bigEndian], length: 2)
    private let byteOneRelayOneOff = UInt16(0xc506).bigEndian
    private let byteOneRelayTwoOn = UInt16(0xc505).bigEndian
    private let byteOneRelayTwoOff = UInt16(0xc507).bigEndian
    private let byteTheeFour = UInt16(0x3132).bigEndian
    private let byteFiveSix = UInt16(0x3334).bigEndian
    private let byteSevenEight = UInt16(0x3536).bigEndian//NSData(bytes: [UInt16(0x3435).bigEndian], length: 2)
    private let byteNineTen = UInt16(0x3738).bigEndian//NSData(bytes: [UInt16(0x3637).bigEndian], length: 2)
    private let finalByte = UInt16(0xaa)//NSData(bytes: [UInt16(0x38aa).bigEndian], length: 2)
    

    //MARK: Public functions
    
    public func writeDataFor(_ command: BoardCommand) -> Data {
        // Default to relayOneOn command
        var writeBytes = [byteOneRelayOneOn, byteTheeFour, byteFiveSix, byteSevenEight, byteNineTen, finalByte]
        switch command {
        case .fogOn:
            break
        case .fogOff:
            writeBytes[0] = byteOneRelayOneOff
        case .relayTwoOn:
            writeBytes[0] = byteOneRelayTwoOn
        case .relayTwoOff:
            writeBytes[0] = byteOneRelayTwoOff
        }
        return Data(bytes: &writeBytes, count: 11)
    }
}
