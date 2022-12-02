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
        let splitLines: [Array<Substring>] = convertNewlineEntriesToSubstringArraysSplitBySpaces(input)
        
        let score: Int = try part1(splitLines)
        let part2score: Int = try part2(splitLines)
        
        print("Part 1 Total Score: ", score)
        print("Part 2 Total Score: ", part2score)
    }
    
    func part1(_ splitLines: [Array<Substring>]) throws -> Int{
        return try splitLines.map {
            try determineWinningPlayer(otherPlayerChoice: String($0[0]), playerChoice: String($0[1]))
        }.reduce(0, +)
    }
    
    func part2(_ splitLines: [Array<Substring>]) throws -> Int{
        return try splitLines.map {
            try playerPointsForPart2(otherPlayerChoice: String($0[0]), playerChoice: String($0[1]))
        }.reduce(0, +)
    }
}

func determineWinningPlayer(otherPlayerChoice: String, playerChoice: String) throws -> Int {
    var points: Int = 0
    switch(playerChoice) {
    case PlayerRPS.rock.rawValue:
        points += ChoicePoints.rock.rawValue
    case PlayerRPS.paper.rawValue:
        points += ChoicePoints.paper.rawValue
    case PlayerRPS.scissors.rawValue:
        points += ChoicePoints.scissors.rawValue
    default:
        throw(UnknownChoice.unknownPlayerChoice(choice: playerChoice))
    }
    
    switch(otherPlayerChoice) {
    case OponentRPS.rock.rawValue:
        switch(playerChoice) {
        case PlayerRPS.rock.rawValue:
            points += ScoreAddition.draw.rawValue
        case PlayerRPS.paper.rawValue:
            points += ScoreAddition.win.rawValue
        case PlayerRPS.scissors.rawValue:
            points += ScoreAddition.loss.rawValue
        default:
            throw(UnknownChoice.unknownPlayerChoice(choice: playerChoice))
        }
    case OponentRPS.paper.rawValue:
        switch(playerChoice) {
        case PlayerRPS.rock.rawValue:
            points += ScoreAddition.loss.rawValue
        case PlayerRPS.paper.rawValue:
            points += ScoreAddition.draw.rawValue
        case PlayerRPS.scissors.rawValue:
            points += ScoreAddition.win.rawValue
        default:
            throw(UnknownChoice.unknownPlayerChoice(choice: playerChoice))
        }
    case OponentRPS.scissors.rawValue:
        switch(playerChoice) {
        case PlayerRPS.rock.rawValue:
            points += ScoreAddition.win.rawValue
        case PlayerRPS.paper.rawValue:
            points += ScoreAddition.loss.rawValue
        case PlayerRPS.scissors.rawValue:
            points += ScoreAddition.draw.rawValue
        default:
            throw(UnknownChoice.unknownPlayerChoice(choice: playerChoice))
        }
    default:
        throw(UnknownChoice.unknownOtherPlayerChoice(choice: playerChoice))
    }
    return points
}

func playerPointsForPart2(otherPlayerChoice: String, playerChoice: String) throws -> Int{
    switch(otherPlayerChoice) {
    case OponentRPS.rock.rawValue:
        switch(playerChoice) {
        case Outcome.loss.rawValue:
            return try determineWinningPlayer(otherPlayerChoice: otherPlayerChoice, playerChoice: PlayerRPS.scissors.rawValue)
        case Outcome.draw.rawValue:
            return try determineWinningPlayer(otherPlayerChoice: otherPlayerChoice, playerChoice: PlayerRPS.rock.rawValue)
        case Outcome.win.rawValue:
            return try determineWinningPlayer(otherPlayerChoice: otherPlayerChoice, playerChoice: PlayerRPS.paper.rawValue)
        default:
            throw(UnknownChoice.unknownPlayerChoice(choice: playerChoice))
        }
    case OponentRPS.paper.rawValue:
        switch(playerChoice) {
        case Outcome.loss.rawValue:
            return try determineWinningPlayer(otherPlayerChoice: otherPlayerChoice, playerChoice: PlayerRPS.rock.rawValue)
        case Outcome.draw.rawValue:
            return try determineWinningPlayer(otherPlayerChoice: otherPlayerChoice, playerChoice: PlayerRPS.paper.rawValue)
        case Outcome.win.rawValue:
            return try determineWinningPlayer(otherPlayerChoice: otherPlayerChoice, playerChoice: PlayerRPS.scissors.rawValue)
        default:
            throw(UnknownChoice.unknownPlayerChoice(choice: playerChoice))
        }
    case OponentRPS.scissors.rawValue:
        switch(playerChoice) {
        case Outcome.loss.rawValue:
            return try determineWinningPlayer(otherPlayerChoice: otherPlayerChoice, playerChoice: PlayerRPS.paper.rawValue)
        case Outcome.draw.rawValue:
            return try determineWinningPlayer(otherPlayerChoice: otherPlayerChoice, playerChoice: PlayerRPS.scissors.rawValue)
        case Outcome.win.rawValue:
            return try determineWinningPlayer(otherPlayerChoice: otherPlayerChoice, playerChoice: PlayerRPS.rock.rawValue)
        default:
            throw(UnknownChoice.unknownPlayerChoice(choice: playerChoice))
        }
    default:
        throw(UnknownChoice.unknownOtherPlayerChoice(choice: playerChoice))
    }
}

enum OponentRPS: String {
    case rock = "A"
    case paper = "B"
    case scissors = "C"
}

enum PlayerRPS: String {
    case rock = "X"
    case paper = "Y"
    case scissors = "Z"
}

enum Outcome: String {
    case loss = "X"
    case draw = "Y"
    case win = "Z"
}

enum ChoicePoints: Int {
    case rock = 1
    case paper = 2
    case scissors = 3
}

enum ScoreAddition: Int {
    case loss = 0
    case draw = 3
    case win = 6
}

enum UnknownChoice: Error {
    case unknownPlayerChoice(choice: String)
    case unknownOtherPlayerChoice(choice: String)
}
