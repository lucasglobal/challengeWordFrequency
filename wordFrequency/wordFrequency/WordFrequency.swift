//
//  WordFrequency.swift
//  wordFrequency
//
//  Created by Lucas Andrade on 1/21/16.
//  Copyright © 2016 LucasRibeiro. All rights reserved.
//

import Foundation

enum FileError: ErrorType {
    case writingIssue
    case readingIssue
}

class WordFrequency: NSObject {
  
    var fileContent: NSString = ""
    
    func readFile() throws{
        
        //name of file that will be used to manage program
        let fileName = "words.txt"
        
        //standard text to write to file
        let textToWriteToFile = "Standard text"
        
        //getting directory and adding the file name on its final
        if let dir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = dir.stringByAppendingPathComponent(fileName);
            
            //writing to file
            do {
                try textToWriteToFile.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding)
            }
            catch {
                throw FileError.writingIssue
            }
            
            //reading file
            do {
                let contentRead = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                self.fileContent = contentRead
            }
            catch {
                throw FileError.readingIssue
            }
        }
    }
   
}
