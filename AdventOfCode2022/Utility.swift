//
//  Utility.swift
//  AdventOfCode2020
//
//  Created by Leif Guillermo on 10/23/22.
//

import Foundation

func convertSubstringArrayToIntArray(_ input: Array<Substring>) -> Array<Int> {
    return input.map {element in return Int(element) ?? 0}
}

func tabbedPrint(_ items: Any..., separator: String = " ", terminator: String = "\n", numTabs: Int = 1) {
    var tabs: String = ""
    var count = numTabs
    repeat {
        tabs.append("\t")
        count-=1
    } while count > 0
    
    print(tabs, terminator: "")
    print(items, separator: separator, terminator: terminator)
}

func convertNewlineEntriesToSubstringArraysSplitBySpaces(_ input: Array<Substring>) -> [Array<Substring>] {
    return input
        .map { return String($0).split(separator: " ") }
        .filter{ !$0.isEmpty }
}

extension StringProtocol {
    var asciiValues: [UInt8] { compactMap(\.asciiValue) }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

extension StringProtocol {
    func getSubSequenceAfter(_ start: Int, _ length: Int) -> SubSequence{
        return getSubSequence(start, start+length)
    }
    func getSubSequenceBetween(_ start: Int, _ end: Int) -> SubSequence{
        return getSubSequence(start, end)
    }
    func getSubSequenceBefore(_ at: Int, _ precedingLength: Int) -> SubSequence{
        return getSubSequence(at, at - precedingLength)
    }
    func getSubSequence(_ beginningIndex: Int, _ endIndex: Int) -> SubSequence {
        let startIndex = self.index(self.startIndex, offsetBy: beginningIndex)
        let endIndex = self.index(self.startIndex, offsetBy: endIndex)
        return self[startIndex..<endIndex]
    }
    func applyFuncToSubSequence(_ seqStart: Int, _ seqEnd: Int, _ function: (SubSequence) -> Any ) -> Any {
        return function(getSubSequence(seqStart, seqEnd))
    }
    func removeDuplicateCharacters() -> String {
        let selfSet = Set(self)
        return String(selfSet)
    }
}
