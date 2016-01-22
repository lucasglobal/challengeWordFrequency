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
    case sortingIssue
    case cleaningIssue
}

class WordFrequency: NSObject {
  
    var fileContent: NSString = ""
    //name of file that will be used to manage program
    let fileName = "words.txt"
    var standardPath = ""
    
    func readFileFirstTime() throws{
        
        
        //standard text to write to file
        let textToWriteToFile = "Type your text here"
        
        //getting directory and adding the file name on its final
        if let dir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = dir.stringByAppendingPathComponent(fileName);
            standardPath = path
            
            do{
                try self.writeToFile(textToWriteToFile)
            }
            catch{
                throw CustomError.writingIssue
            }
            do{
                try self.readToFile()
            }
            catch{
                throw CustomError.readingIssue
            }
        }
    }
    
    
    //create function with two parameters and apply sort to file content
    func sortWithWordFrequency(textToBeSorted: NSString, var numberOfItensToReturn: Int) throws -> NSMutableArray{
        do{
            //lowering all text
            let loweredString = textToBeSorted.lowercaseString
            
            //separating words that have special characters
            let treatedString = try self.cleanStringWithSpecialCharacters(loweredString)
            
            //cleaning white spaces from array
            let arrayWithSeparatedWords = treatedString.componentsSeparatedByString(" ")
            let cleanedArray = arrayWithSeparatedWords.filter() {
                $0 != ""
            }
            
            //creating dictionary with word appearing count as value
            let dictionaryWithCountedWords = self.createDictionaryWithWordAppearingCount(cleanedArray)
            
            //sort dictionary keys by appearing counter(value)
            let sortedKeys = (dictionaryWithCountedWords as NSDictionary).keysSortedByValueUsingSelector("compare:")
            
            let treatedArray = NSMutableArray()
            //creating array on reverse mode
            for item in sortedKeys.reverse() {
                treatedArray.addObject(item)
            }
            
            var numberMaximumOfItemsToReturn = 0
            //create array with the correct number of items to return
            //if the user asks for more items than the software has
            if((treatedArray.count - numberOfItensToReturn) < 0){
                numberMaximumOfItemsToReturn = treatedArray.count
            }
            else if(numberOfItensToReturn > treatedArray.count){
                numberOfItensToReturn = treatedArray.count
            }
            else{
                numberMaximumOfItemsToReturn = numberOfItensToReturn
            }
            let decreasedTreatedArray = NSMutableArray()
            for var index = 0; index < numberMaximumOfItemsToReturn; ++index {
                decreasedTreatedArray.addObject(treatedArray[index])
            }
            
            //return array with correct size and sorted
            return decreasedTreatedArray
        }
        catch CustomError.sortingIssue{
            throw CustomError.sortingIssue
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
    
    //counting how many times each word appears
    func createDictionaryWithWordAppearingCount(arrayWithWords: [String]) -> NSMutableDictionary{
        let dictionaryWithCountedWords = NSMutableDictionary()
        
        for var index = 0; index < arrayWithWords.count; ++index{
            //the dictionary already contains the word and will count one more on the key value
            if(dictionaryWithCountedWords[arrayWithWords[index]] != nil){
                var pastWordCounter = (dictionaryWithCountedWords.valueForKey(arrayWithWords[index]) as! Int)
                ++pastWordCounter
                dictionaryWithCountedWords.setValue(pastWordCounter, forKey: arrayWithWords[index])
            }
            //the dictionary does not contain the word and start one as word counter as it is the first appearence
            else{
                dictionaryWithCountedWords.setValue(1, forKey: arrayWithWords[index])
            }
        }
        return dictionaryWithCountedWords
    }
    func writeToFile(stringToWrite: NSString) throws{
        //writing to file
        do {
            try stringToWrite.writeToFile(standardPath, atomically: false, encoding: NSUTF8StringEncoding)
        }
        catch {
            throw CustomError.writingIssue
        }
        
    }
    func readToFile() throws{
        //reading file
        do {
            let contentRead = try NSString(contentsOfFile: standardPath, encoding: NSUTF8StringEncoding)
            fileContent = contentRead
        }
        catch {
            throw CustomError.readingIssue
        }
    }
}



