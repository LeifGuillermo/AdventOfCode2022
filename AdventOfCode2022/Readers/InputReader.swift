//
//  InputReader.swift
//  AdventOfCode2020
//
//  Created by Leif Guillermo on 10/23/22.
//

import Foundation

public class InputReader {
    private let resourcesPath: String = "/Documents/Dev/AdventOfCode2022/Resources"

    init() {
    }
    
    public func loadFileAsStringFromUrlString(_ filename: String) -> String {
        let inputDirectoryConfig = InputDirectoryConfig(resourcesPath)
        let fullURL: URL = inputDirectoryConfig.getInputDirectory().appendingPathComponent(filename)
        return loadContentsAsStringFromUrlString(fullURL.absoluteString)
    }
    
    private func loadContentsAsStringFromUrlString(_ urlString: String) -> String {
        if let webUrl = URL(string: urlString) {
            do {
                let contents = try String(contentsOf: webUrl)
                return contents
            } catch {
                fatalError("The contents of the file \(urlString) could not be loaded.")
            }
        }
        fatalError("Failure to fetch url from string \(urlString)")
    }
    
}
