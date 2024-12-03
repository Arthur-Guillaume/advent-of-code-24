//
//  FileReader.swift
//  MyLibrary
//
//  Created by Arthur Guillaume on 03/12/2024.
//

public class FileReader {
    public static func readFileContent(path: String) throws -> String {
        try String(contentsOfFile: path, encoding: .utf8)
    }
}
