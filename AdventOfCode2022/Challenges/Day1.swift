//
//  Day1.swift
//  AdventOfCode2022
//
//  Created by Leif Guillermo on 12/1/22.
//

import Foundation

fileprivate typealias Calories = Int

class Day1: DayProtocol {
    let sampleInput = "day1sample.txt"
    let dayInput = "day1input.txt"
    
    func readSampleInput() -> Array<Substring> {
        return InputReader().loadFileAsStringFromUrlString(sampleInput).split(separator: "\n", omittingEmptySubsequences: false)
    }
    
    func readDayInput() -> Array<Substring> {
        return InputReader().loadFileAsStringFromUrlString(dayInput).split(separator: "\n", omittingEmptySubsequences: false)
    }
    
    init() {}

    func day1() {
        let sampleInput: Array<Substring> = readSampleInput()
        runSolution(sampleInput, InputType.sampleInput.rawValue)

        let dayInput = readDayInput()
        runSolution(dayInput, InputType.dayInput.rawValue)
    }
    
    func runSolution(_ input: Array<Substring>, _ inputType: String) {
        print("Solution for \(inputType):")
        let elvesRations: Array<ElfRation> = getElfRations(input: input)
        
        // part 1
        let maximumCalories: Calories = getArrayOfRationTotalsFromElves(elvesRations).max()!
        tabbedPrint("Highest-calorie ration: ", maximumCalories)

        // part 2
        findHighest3ElfCalories(elvesRations)
    }
    
    fileprivate func getArrayOfRationTotalsFromElves(_ elvesRations: Array<ElfRation>) -> Array<Calories> {
        return elvesRations.map {
            elfRation -> Calories in elfRation.totalCalories
        }
    }
    
    fileprivate func findHighest3ElfCalories(_ elvesRations: Array<ElfRation>) {
        let calorieTotals: Array<Calories>  = getArrayOfRationTotalsFromElves(elvesRations)
        let highest3CalorieElements: Array<Calories> = calorieTotals.sorted(by: >)
        tabbedPrint("Sum of top three highest-calorie rations: ", highest3CalorieElements.prefix(3).reduce(0, +))
    }
    
    fileprivate func getElfRations(input: Array<Substring>) -> Array<ElfRation> {
        var elvesRations: Array<ElfRation> = Array<ElfRation>()
        var currentElfRation = ElfRation()
        
        for elem in input {
            if(elem.isEmpty) {
                elvesRations.append(currentElfRation)
                currentElfRation = ElfRation()
            } else {
                currentElfRation.addRation(ration: Calories(elem)!)
            }
        }
        return elvesRations
    }
}

fileprivate class ElfRation {
    private var rations: Array<Int> = Array<Int>()
    fileprivate var totalCalories: Calories {
        return rations.reduce(0,+)
    }
    
    init() {}
    
    fileprivate func addRation(ration: Calories) {
        rations.append(ration)
    }
}
