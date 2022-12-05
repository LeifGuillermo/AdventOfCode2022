//
//  Day5.swift
//  AdventOfCode2022
//
//  Created by Leif Guillermo on 12/5/22.
//

import Foundation

class Day5: DayProtocol {
    var sampleInput: String = "day5sample.txt"
    var dayInput: String = "day5input.txt"
    
    func day5() {
        let sampleInput: [Substring] = readSampleInput()
        let dayInput: [Substring] = readDayInput()
        solvePart1(sampleInput)
        solvePart1(dayInput)
        solvePart2(sampleInput)
        solvePart2(dayInput)
    }
    
    func solvePart1(_ input: [Substring]) {
        let cargoInstructionTuple = separateCargoFromInstructions(input)
        let formattedCargo = createCargoDataStructure(cargoInstructionTuple.0, cargoInstructionTuple.1)
        let formattedNumericInstructions = formatInstructions(cargoInstructionTuple.2)
        let cargoResult = runInstructionsOnCargo(instructions: formattedNumericInstructions, cargo: formattedCargo)
        printTopCargo(cargoResult)
    }
    
    func solvePart2(_ input: [Substring]) {
        let cargoInstructionTuple = separateCargoFromInstructions(input)
        let formattedCargo = createCargoDataStructure(cargoInstructionTuple.0, cargoInstructionTuple.1)
        let formattedNumericInstructions = formatInstructions(cargoInstructionTuple.2)
        let cargoResult = runInstructionsOnCargoPart2(instructions: formattedNumericInstructions, cargo: formattedCargo)
        printTopCargo(cargoResult)
    }
    
    func printTopCargo(_ cargo: Dictionary<Character, [Character]>) {
        let topCargo: [Character] = cargo.sorted(by: {$0.key < $1.key}).map{$1.first!}
        print(String(topCargo))
    }
    
    func runInstructionsOnCargo(instructions: [[String]], cargo: Dictionary<Character, [Character]>) -> Dictionary<Character, [Character]>{
        var resultCargo = cargo
        let repetitionIndex = 0
        let moveFromIndex = 1
        let moveToIndex = 2
        
        instructions.forEach { instruction in
            let moveFrom: Character = String(instruction[moveFromIndex]).first!
            let moveTo: Character = String(instruction[moveToIndex]).first!
            let repetitions: Int = Int(instruction[repetitionIndex])!
            resultCargo = transferCargoPart1(moveFrom: moveFrom, moveTo: moveTo, repetitions: repetitions, cargo: resultCargo)
        }
        
        return resultCargo
    }
    
    func runInstructionsOnCargoPart2(instructions: [[String]], cargo: Dictionary<Character, [Character]>) -> Dictionary<Character, [Character]>{
        var resultCargo = cargo
        let repetitionIndex = 0
        let moveFromIndex = 1
        let moveToIndex = 2
        
        instructions.forEach { instruction in
            let moveFrom: Character = String(instruction[moveFromIndex]).first!
            let moveTo: Character = String(instruction[moveToIndex]).first!
            let repetitions: Int = Int(instruction[repetitionIndex])!
            resultCargo = transferCargoPart2(moveFrom: moveFrom, moveTo: moveTo, repetitions: repetitions, cargo: resultCargo)
        }
        
        return resultCargo
    }
    
    func transferCargoPart2(moveFrom: Character, moveTo: Character, repetitions: Int, cargo: Dictionary<Character, [Character]>) -> Dictionary<Character, [Character]>{
        var resultCargo = cargo
        var reps = repetitions
        var tempArray: [Character] = []
        repeat {
            let crate: Character = resultCargo[moveFrom]!.removeFirst()
            tempArray.insert(crate, at: tempArray.count)
            reps -= 1
        } while (reps > 0)
        resultCargo[moveTo]!.insert(contentsOf: tempArray, at: 0)
        return resultCargo
    }
    
    
    func transferCargoPart1(moveFrom: Character, moveTo: Character, repetitions: Int, cargo: Dictionary<Character, [Character]>) -> Dictionary<Character, [Character]>{
        var resultCargo = cargo
        var reps = repetitions
        repeat {
            let crate: Character = resultCargo[moveFrom]!.removeFirst()
            resultCargo[moveTo]!.insert(crate, at: 0)
            reps -= 1
        } while (reps > 0)
        return resultCargo
    }
    
    func createCargoDataStructure(_ cargo: [Substring], _ columns: Substring) -> Dictionary<Character, [Character]> {
        let cargoColumnMapping: Dictionary<Int, Character> = getCargoColumnMapping(columns)
        
        var cargoDataStructure: Dictionary<Character, [Character]> = [:]
        cargoColumnMapping.values.forEach { (value: Character) in
            cargoDataStructure[value] = []
        }
        
        cargo.forEach { cargoLine in
            cargoLine.enumerated().forEach { (idx, lineChar) in
                if(lineChar.isLetter) {
                    let index = cargoColumnMapping[idx]
                    cargoDataStructure[index!]!.append(lineChar)
                }
            }
        }
        
        return cargoDataStructure
    }
    
    func getCargoColumnMapping(_ columns: Substring) -> Dictionary<Int, Character> {
        var cargoColumnMapping: Dictionary<Int, Character> = [:]
        columns.enumerated().forEach { (idx, col) in
            if(col.isNumber){ cargoColumnMapping[idx] = col }
        }
        return cargoColumnMapping
    }
    
    func formatInstructions(_ instructions: [Substring]) -> [[String]] {
        let instructionComponentArray: [[String]] = instructions.map { String($0).components(separatedBy: " ") }
        return instructionComponentArray.map { instructionComponents in
            instructionComponents.filter { component in
                Int(component) != Optional.none
            }
        }
    }
    
    func separateCargoFromInstructions(_ input: [Substring]) -> ([Substring], Substring ,[Substring]) {
        var isInstructions = false
        var cargo: [Substring] = []
        var instructions: [Substring] = []
        for line in input {
            if(isInstructions) {
                instructions.append(line)
            } else {
                if line.isEmpty {
                    isInstructions = true
                    continue
                }
                cargo.append(line)
            }
        }
        
        return (cargo.dropLast(), cargo.popLast()!, instructions.filter{!$0.isEmpty})
    }
}
