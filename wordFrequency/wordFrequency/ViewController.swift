//
//  ViewController.swift
//  wordFrequency
//
//  Created by Lucas Andrade on 1/21/16.
//  Copyright © 2016 LucasRibeiro. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    //initializing class that has methods related to the challenging
    var wordFrequency: WordFrequency = WordFrequency()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            //reading file and testing its management
            try wordFrequency.readFile()
            
            //method with tho parameters is in WordFrequency class
            let arrayWithWordFrequency = self.sortWithWordFrequency(10)
            print(arrayWithWordFrequency)
        }
        catch CustomError.readingIssue {
            print("Unknown problem reading file")
        }
        catch CustomError.writingIssue {
            print("Unknown problem writing to file")
        }
        catch{
            print("Unknown error")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func sortWithWordFrequency(numberOfItensToReturn: Int)->NSMutableArray {
        do{
            //apply sort algorithm just in WordFrequency class.
            //method wrote to handle exceptions
           let arrayWithWordFrequency = try wordFrequency.sortWithWordFrequency(wordFrequency.fileContent, numberOfItensToReturn: numberOfItensToReturn)
            return arrayWithWordFrequency
            
        }
        catch CustomError.sortingIssue{
            print("Error sorting file")
        }
        catch{
            print("Unknow error when sorting file")
        }
        return NSMutableArray()
    }
}

