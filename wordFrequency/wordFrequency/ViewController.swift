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
            
            //just keep going if had successful try
            self.sortWithWordFrequency(5)
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
    func sortWithWordFrequency(numberOfItensToReturn: Int){
        do{
            //apply sort algorithm just in WordFrequency class.
            //method wrote to handle exceptions
           try wordFrequency.sortWithWordFrequency(wordFrequency.fileContent, numberOfItensToReturn: numberOfItensToReturn)
            print("cleaned")
        }
        catch CustomError.cleaningIssue{
            print("Error cleaning file")
        }
        catch{
            print("Unknow error when sorting file")
        }
    }
}

