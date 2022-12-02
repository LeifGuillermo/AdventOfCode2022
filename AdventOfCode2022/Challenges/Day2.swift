//
//  Day2.swift
//  AdventOfCode2022
//
//  Created by Leif Guillermo on 12/1/22.
//

import Foundation

class Day2: DayProtocol {
    let sampleInput = "day2sample.txt"
    let dayInput = "day2input.txt"
    
    func readSampleInput() -> Array<Substring> {
        return InputReader().loadFileAsStringFromUrlString(sampleInput).split(separator: "\n", omittingEmptySubsequences: false)
    }
    
    func readDayInput() -> Array<Substring> {
        return InputReader().loadFileAsStringFromUrlString(dayInput).split(separator: "\n", omittingEmptySubsequences: false)
    }
    
    func day2() throws {
        let sampleInput: Array<Substring> = readSampleInput()
        let dayInput: Array<Substring> = readDayInput()
        
        try solve(sampleInput)
        try solve(dayInput)
    }
    
    func solve(_ input: Array<Substring>) throws {
        let rockPaperScissorRounds: [Array<Substring>] = convertNewlineEntriesToSubstringArraysSplitBySpaces(input)
        
        let score: Int = try part1(rockPaperScissorRounds)
        let part2score: Int = try part2(rockPaperScissorRounds)
        
        print("Part 1 Total Score: ", score)
        print("Part 2 Total Score: ", part2score)
    }
    
    func part1(_ rockPaperScissorRounds: [Array<Substring>]) throws -> Int{
        return try rockPaperScissorRounds.map {
            try calculatePointsGivenChoices(opponentChoice: String($0[0]), playerChoice: String($0[1]))
        }.reduce(0, +)
    }
    
    func part2(_ rockPaperScissorRounds: [Array<Substring>]) throws -> Int{
        return try rockPaperScissorRounds.map {
            try calculatePointsGivenStrategy(otherPlayerChoice: String($0[0]), playerStrategy: String($0[1]))
        }.reduce(0, +)
    }
}

fileprivate func calculatePointsGivenChoices(opponentChoice: String, playerChoice: String) throws -> Int {
    var points: Int = 0
    switch(playerChoice) {
    case PlayerChoice.rock.rawValue:
        points += ChoicePoints.rock.rawValue
    case PlayerChoice.paper.rawValue:
        points += ChoicePoints.paper.rawValue
    case PlayerChoice.scissors.rawValue:
        points += ChoicePoints.scissors.rawValue
    default:
        throw(UnknownChoice.unknownPlayerChoice(choice: playerChoice))
    }
    
    switch(opponentChoice) {
    case OpponentChoice.rock.rawValue:
        switch(playerChoice) {
        case PlayerChoice.rock.rawValue:
            points += OutcomeScore.draw.rawValue
        case PlayerChoice.paper.rawValue:
            points += OutcomeScore.win.rawValue
        case PlayerChoice.scissors.rawValue:
            points += OutcomeScore.loss.rawValue
        default:
            throw(UnknownChoice.unknownPlayerChoice(choice: playerChoice))
        }
    case OpponentChoice.paper.rawValue:
        switch(playerChoice) {
        case PlayerChoice.rock.rawValue:
            points += OutcomeScore.loss.rawValue
        case PlayerChoice.paper.rawValue:
            points += OutcomeScore.draw.rawValue
        case PlayerChoice.scissors.rawValue:
            points += OutcomeScore.win.rawValue
        default:
            throw(UnknownChoice.unknownPlayerChoice(choice: playerChoice))
        }
    case OpponentChoice.scissors.rawValue:
        switch(playerChoice) {
        case PlayerChoice.rock.rawValue:
            points += OutcomeScore.win.rawValue
        case PlayerChoice.paper.rawValue:
            points += OutcomeScore.loss.rawValue
        case PlayerChoice.scissors.rawValue:
            points += OutcomeScore.draw.rawValue
        default:
            throw(UnknownChoice.unknownPlayerChoice(choice: playerChoice))
        }
    default:
        throw(UnknownChoice.unknownOtherPlayerChoice(choice: playerChoice))
    }
    return points
}

fileprivate func calculatePointsGivenStrategy(otherPlayerChoice: String, playerStrategy: String) throws -> Int{
    switch(otherPlayerChoice) {
    case OpponentChoice.rock.rawValue:
        switch(playerStrategy) {
        case Outcome.loss.rawValue:
            return try calculatePointsGivenChoices(opponentChoice: otherPlayerChoice, playerChoice: PlayerChoice.scissors.rawValue)
        case Outcome.draw.rawValue:
            return try calculatePointsGivenChoices(opponentChoice: otherPlayerChoice, playerChoice: PlayerChoice.rock.rawValue)
        case Outcome.win.rawValue:
            return try calculatePointsGivenChoices(opponentChoice: otherPlayerChoice, playerChoice: PlayerChoice.paper.rawValue)
        default:
            throw(UnknownChoice.unknownPlayerChoice(choice: playerStrategy))
        }
    case OpponentChoice.paper.rawValue:
        switch(playerStrategy) {
        case Outcome.loss.rawValue:
            return try calculatePointsGivenChoices(opponentChoice: otherPlayerChoice, playerChoice: PlayerChoice.rock.rawValue)
        case Outcome.draw.rawValue:
            return try calculatePointsGivenChoices(opponentChoice: otherPlayerChoice, playerChoice: PlayerChoice.paper.rawValue)
        case Outcome.win.rawValue:
            return try calculatePointsGivenChoices(opponentChoice: otherPlayerChoice, playerChoice: PlayerChoice.scissors.rawValue)
        default:
            throw(UnknownChoice.unknownPlayerChoice(choice: playerStrategy))
        }
    case OpponentChoice.scissors.rawValue:
        switch(playerStrategy) {
        case Outcome.loss.rawValue:
            return try calculatePointsGivenChoices(opponentChoice: otherPlayerChoice, playerChoice: PlayerChoice.paper.rawValue)
        case Outcome.draw.rawValue:
            return try calculatePointsGivenChoices(opponentChoice: otherPlayerChoice, playerChoice: PlayerChoice.scissors.rawValue)
        case Outcome.win.rawValue:
            return try calculatePointsGivenChoices(opponentChoice: otherPlayerChoice, playerChoice: PlayerChoice.rock.rawValue)
        default:
            throw(UnknownChoice.unknownPlayerChoice(choice: playerStrategy))
        }
    default:
        throw(UnknownChoice.unknownOtherPlayerChoice(choice: playerStrategy))
    }
}

fileprivate enum OpponentChoice: String {
    case rock = "A"
    case paper = "B"
    case scissors = "C"
}

fileprivate enum PlayerChoice: String {
    case rock = "X"
    case paper = "Y"
    case scissors = "Z"
}

fileprivate enum Outcome: String {
    case loss = "X"
    case draw = "Y"
    case win = "Z"
}

fileprivate enum OutcomeScore: Int {
    case loss = 0
    case draw = 3
    case win = 6
}

fileprivate enum ChoicePoints: Int {
    case rock = 1
    case paper = 2
    case scissors = 3
}

fileprivate enum UnknownChoice: Error {
    case unknownPlayerChoice(choice: String)
    case unknownOtherPlayerChoice(choice: String)
}
