//
//  AdventOfCodeError.swift
//  Common
//
//  Created by Arthur Guillaume on 03/12/2024.
//

import Foundation

public enum AdventOfCodeError: LocalizedError {
    case noFileFound
    case invalidData
    case incorrectParameters

    public var errorDescription: String? {
        switch self {
        case .incorrectParameters:
            "Parameters count is incorrect"
        case .invalidData:
            "Data format doesn't match the expected input"
        case .noFileFound:
            "Input file not found"
        }
    }
}
