//
//  main.swift
//  Day2
//
//  Created by Arthur Guillaume on 03/12/2024.
//

import Foundation
import MyLibrary

func isSafe(report: [Int]) throws -> Bool {
    guard report.count >= 2 else {
        throw AdventOfCodeError.invalidData
    }

    var errorCount = 0

    for i in 1..<report.count - 1 {
        let current = report[i]
        let next = report[i + 1]
        let previous = report[i - 1]

        let currentDiff = current - next
        let previousDiff = previous - current

        if currentDiff * previousDiff <= 0 || abs(currentDiff) > 3 || abs(previousDiff) > 3 {
            return false
        }
    }

    return true
}

func isNearlySafe(report: [Int]) throws -> Bool {
    if try isSafe(report: report) {
        return true
    } else {
        for i in 0..<report.count {
            var reportCopy = report
            reportCopy.remove(at: i)
            if try isSafe(report: reportCopy) {
                return true
            }
        }
        return false
    }
}

func main() {
    do {
        guard CommandLine.arguments.count == 2 else {
            throw AdventOfCodeError.incorrectParameters
        }

        let firstArgument = CommandLine.arguments[1]
        let fileContent = try FileReader.readFileContent(path: firstArgument)

        let matrix = try parse(input: fileContent)
        let safeReportsCount = try matrix.map(isSafe(report:)).count { $0 }
        let nearlySafeReportsCount = try matrix.map(isNearlySafe(report:)).count { $0 }

        print("\(safeReportsCount) reports are safe")
        print("\(nearlySafeReportsCount) reports are nearly safe")
    } catch {
        print("Fatal error: \(error.localizedDescription)")
    }
}

main() 
