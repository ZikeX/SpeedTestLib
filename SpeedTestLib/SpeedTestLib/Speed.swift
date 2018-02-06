//
//  Speed.swift
//  SpeedTestLib
//
//  Created by dhaurylenka on 2/6/18.
//  Copyright © 2018 Exadel. All rights reserved.
//

import Foundation

struct Speed: CustomStringConvertible {
    private static let upUnit: Double = 1024
    
    enum Units: Int {
        case Kbps, Mbps, Gbps
        
        var description: String {
            switch self {
            case .Kbps: return "Kbps"
            case .Mbps: return "Mbps"
            case .Gbps: return "Gbps"
            }
        }
    }
    
    let value: Double
    let units: Units
    
    var pretty: Speed {
        return [Units.Kbps, .Mbps, .Gbps]
            .filter { units in
                units.rawValue >= self.units.rawValue
            }.reduce(self) { (result, nextUnits) in
                guard result.value > Speed.upUnit else {
                    return result
                }
                return Speed(value: result.value / Speed.upUnit, units: nextUnits)
            }
    }
    
    var description: String {
        return String(format: "%.3f", value) + " " + units.description
    }
}

extension Speed {
    init(bytes: Int64, seconds: TimeInterval) {
        let speedInB = Double(bytes) / seconds
        self.value = speedInB
        self.units = .Kbps
    }
}