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
    
    func solvePart1(_ input: [Substring]) {
        let elvesRations: Array<ElfRation> = getElfRations(input: input)
        let maximumCalories: Calories = getArrayOfRationTotalsFromElves(elvesRations).max()!
        print(maximumCalories)
    }
    
    func solvePart2(_ input: [Substring]) {
        let elvesRations: Array<ElfRation> = getElfRations(input: input)
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
        print(highest3CalorieElements.prefix(3).reduce(0, +))
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
