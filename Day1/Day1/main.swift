import Foundation
import MyLibrary

func parse(fileContent: String) throws -> ([Int], [Int]) {
    var lList = [Int]()
    var rList = [Int]()

    let lines = fileContent.split(separator: "\n")
    try lines.forEach { line in
        let numbers = line.split(separator: " ", omittingEmptySubsequences: true)
        guard
            numbers.count == 2,
            let lIntElement = Int(numbers[0]),
            let rIntElement = Int(numbers[1])
        else {
            throw MyLibrary.AdventOfCodeError.invalidData
        }
        lList.append(lIntElement)
        rList.append(rIntElement)
    }

    return (lList, rList)
}

func distance(leftList: [Int], rightList: [Int]) -> Int {

    let sortedLeftList = leftList.sorted()
    let sortedRightList = rightList.sorted()

    var totalDistance = 0

    for i in 0..<sortedLeftList.count {
        let leftElement = sortedLeftList[i]
        let rightElement = sortedRightList[i]
        let distance = abs(leftElement - rightElement)
        totalDistance += distance
    }

    return totalDistance
}

func similarityScore(leftList: [Int], rightList: [Int]) -> Int {
    var totalSimilarityScore = 0
    for i in 0..<leftList.count {
        let leftElement = leftList[i]
        let similarityScore = rightList.count { rightElement in
            leftElement == rightElement
        }
        totalSimilarityScore += (similarityScore * leftElement)
    }
    return totalSimilarityScore
}

func main(){
    do {
        guard CommandLine.arguments.count >= 2 else {
            throw AdventOfCodeError.incorrectParameters
        }

        let firstArgument = CommandLine.arguments[1]
        let fileContent = try FileReader.readFileContent(path: firstArgument)

        let (leftList, rightList) = try parse(fileContent: fileContent)

        let distance = distance(leftList: leftList, rightList: rightList)
        let similarityScore = similarityScore(leftList: leftList, rightList: rightList)

        print("Distance: \(distance)")
        print("Similarity score: \(similarityScore)")
    } catch {
        print("Fatal error: \(error.localizedDescription)")
    }
}

main()
