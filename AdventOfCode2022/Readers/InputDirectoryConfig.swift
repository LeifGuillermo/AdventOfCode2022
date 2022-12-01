//
//  InputDirectoryConfig.swift
//  AdventOfCode2020
//
//  Created by Leif Guillermo on 10/23/22.
//

import Foundation

public class InputDirectoryConfig {
    private var inputDirectory: URL
    
    init(_ pathFromUserDirectory: String) {
        inputDirectory = FileManager().homeDirectory(forUser: NSUserName())!
            .appendingPathComponent(pathFromUserDirectory)
    }
    
    public func getInputDirectory() -> URL {
        return inputDirectory
    }
}
