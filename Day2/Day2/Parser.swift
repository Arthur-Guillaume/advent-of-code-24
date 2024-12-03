//
//  Parser.swift
//  Day2
//
//  Created by Arthur Guillaume on 03/12/2024.
//

import MyLibrary

func parse(input: String) throws -> [[Int]] {
    try input.split(separator: "\n")
        .map { line in
            try line.split(separator: " ")
                .map { element in
                    guard let intValue = Int(element) else {
                        throw AdventOfCodeError.invalidData
                    }
                    return intValue
                }
        }
}
