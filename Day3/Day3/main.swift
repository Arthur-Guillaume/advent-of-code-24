//
//  main.swift
//  Day3
//
//  Created by Arthur Guillaume on 03/12/2024.
//

import Foundation
import MyLibrary

func clean(input: String) -> String {
    var isEnabled = true
    var remainingInput = input
    var enabledInput = ""
    while !remainingInput.isEmpty {
        enabledInput += removeDisabledParts(input: &remainingInput, isEnabled: isEnabled)
        isEnabled.toggle()
    }
    return enabledInput
}

func removeDisabledParts(input: inout String, isEnabled: Bool) -> String {
    let pattern = isEnabled ? "don't()" : "do()"
    if let range = input.range(of: pattern) {
      let substring = input[..<range.lowerBound]
        input = String(input[range.upperBound...])
        if isEnabled {
            return String(substring)
        }
    }
    else if isEnabled {
        let substring = input
        input = ""
        return substring
    }

    return ""
}

func extractValidOperations(rawInput: String) throws -> [String] {
    let regex = try Regex("mul\\(\\d{1,3},\\d{1,3}\\)")
    let matches = rawInput.matches(of: regex)
    return matches.map {
        String(rawInput[$0.range])
    }
}

func extractNumbers(operation: String) throws -> (Int, Int) {
    var operation = operation
    operation.removeFirst(4)
    operation.removeLast()
    let numbers = operation.split(separator: ",")
    guard numbers.count == 2, let lInt = Int(numbers[0]), let rInt = Int(numbers[1]) else {
        throw AdventOfCodeError.invalidData
    }
    return (lInt, rInt)
}

func main() {
    do {
        guard CommandLine.arguments.count == 2 else {
            throw AdventOfCodeError.incorrectParameters
        }

        let firstArgument = CommandLine.arguments[1]
        let fileContent = try FileReader.readFileContent(path: firstArgument)

        let enabledPart = clean(input: fileContent)
        let result = try extractValidOperations(rawInput: enabledPart)
            .map { try extractNumbers(operation: $0) }
            .reduce(0) { $0 + $1.0 * $1.1 }

        print("\(result)")
    } catch {
        print("Fatal error: \(error.localizedDescription)")
    }
}

main()
