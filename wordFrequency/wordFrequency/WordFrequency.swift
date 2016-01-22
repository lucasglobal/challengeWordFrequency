//
//  WordFrequency.swift
//  wordFrequency
//
//  Created by Lucas Andrade on 1/21/16.
//  Copyright © 2016 LucasRibeiro. All rights reserved.
//

import Foundation

//handled errors
enum CustomError: ErrorType {
    case writingIssue
    case readingIssue
    case cleaningIssue
}

class WordFrequency: NSObject {
  
    var fileContent: NSString = ""
    
    func readFile() throws{
        
        //name of file that will be used to manage program
        let fileName = "words.txt"
        
        //standard text to write to file
        let textToWriteToFile = "Som?e ? sea;D:sSdDrch !t,e,xt . doi"
        
        //getting directory and adding the file name on its final
        if let dir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = dir.stringByAppendingPathComponent(fileName);
            
            //writing to file
            do {
                try textToWriteToFile.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding)
            }
            catch {
                throw CustomError.writingIssue
            }
            
            //reading file
            do {
                let contentRead = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                self.fileContent = contentRead
            }
            catch {
                throw CustomError.readingIssue
            }
        }
    }
    
    //create function with two parameters and apply sort to file content
    func sortWithWordFrequency(textToBeSorted: NSString, numberOfItensToReturn: Int) throws{
        do{
            //lowering all text
            let loweredString = textToBeSorted.lowercaseString
            print(loweredString)
            
            //separating words that have special characters
            let treatedString = try self.cleanStringWithSpecialCharacters(loweredString)
            print(treatedString)
        }
        catch CustomError.cleaningIssue{
            throw CustomError.cleaningIssue
        }
    }
    
    func cleanStringWithSpecialCharacters(stringToClean: NSString) throws -> NSString{
        var newString = stringToClean
        //loop to verify the existence of all needed characters and use just one variable, since Swift does not have method to replace string by more than one character at once
        //this characters will separate characters on their sides as words
        for var index = 0; index <= 5; ++index{
            switch index{
            case 0:
                newString = newString.stringByReplacingOccurrencesOfString("!", withString: " ")
            case 1:
                newString = newString.stringByReplacingOccurrencesOfString(".", withString: " ")
            case 2:
                newString = newString.stringByReplacingOccurrencesOfString(",", withString: " ")
            case 3:
                newString = newString.stringByReplacingOccurrencesOfString("?", withString: " ")
            case 4:
                newString = newString.stringByReplacingOccurrencesOfString(";", withString: " ")
            case 5:
                newString = newString.stringByReplacingOccurrencesOfString(":", withString: " ")
            default:
                throw CustomError.cleaningIssue
            }
        }
        return newString
    }
}
