//
//  Day1.swift
//  AdventOfCode2022
//
//  Created by Leif Guillermo on 12/1/22.
//

import Foundation

class Day1 {
    private let sampleInput = "day1_sample.txt"
    private let dayInput = "day1input.txt"
    
    private func readSampleInput() -> Array<Substring> {
        return InputReader().loadFileAsStringFromUrlString(sampleInput).split(separator: "\n", omittingEmptySubsequences: false)
    }
    
    private func readDayInput() -> Array<Substring> {
        return InputReader().loadFileAsStringFromUrlString(dayInput).split(separator: "\n", omittingEmptySubsequences: false)
    }
    
    init() {}

    func day1() {
//        let input: Array<Substring> = readSampleInput()
        let input: Array<Substring> = readDayInput()
        let elvesRations: Array<ElfRation> = getElfRations(input: input)
        
        let maximumCalories: Int = getArrayOfRationTotalsFromElves(elvesRations).max()!
        
        print("Max Calories: ", maximumCalories)

        day1Part2(elvesRations)
        
        
    }
    
    func getArrayOfRationTotalsFromElves(_ elvesRations: Array<ElfRation>) -> Array<Int> {
        return elvesRations.map {
            elfRation -> Int in elfRation.totalCalories
        }
    }
    
    // find top 3 calories from elves
    func day1Part2(_ elvesRations: Array<ElfRation>) {
        let calorieTotals: Array<Int>  = getArrayOfRationTotalsFromElves(elvesRations)
        let top3: Array<Int> = calorieTotals.sorted(by: >)
        print("Total of top 3: ", top3.prefix(3).reduce(0, +))
    }
    
    func getElfRations(input: Array<Substring>) -> Array<ElfRation> {
        var elvesRations: Array<ElfRation> = Array<ElfRation>()
        var currentElfRation = ElfRation()
        
        for elem in input {
            if(elem.isEmpty) {
                elvesRations.append(currentElfRation)
                currentElfRation = ElfRation()
            } else {
                currentElfRation.addRation(ration: Int(elem)!)
            }
        }
        return elvesRations
    }
}

class ElfRation {
    private var rations: Array<Int> = Array<Int>()
    fileprivate var totalCalories: Int {
        return rations.reduce(0,+)
    }
    
    init() {}
    
    fileprivate func addRation(ration: Int) {
        rations.append(ration)
    }
}
