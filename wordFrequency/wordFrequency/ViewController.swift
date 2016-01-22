//
//  ViewController.swift
//  wordFrequency
//
//  Created by Lucas Andrade on 1/21/16.
//  Copyright © 2016 LucasRibeiro. All rights reserved.
//

import UIKit



class ViewController: UIViewController{
    
    @IBOutlet weak var fieldTextUser: UITextField!
    @IBAction func actionNext(sender: AnyObject){
        
        do{
            do{
                //saving again to get data from text document as specified
                try wordFrequency.writeToFile(self.fieldTextUser.text!)
                try wordFrequency.readToFile()
                self.sortWithWordFrequency(3)
            }
            
        }
        catch{
            print("Writing/reading issues")
        }
    }
    //initializing class that has methods related to the challenging
    var wordFrequency: WordFrequency = WordFrequency()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            //reading file and testing its management
            try wordFrequency.readFileFirstTime()

            //method with tho parameters is in WordFrequency class
            self.sortWithWordFrequency(3)
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
        //updating field text
        self.fieldTextUser.text = wordFrequency.fileContent as String

        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
    }
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    override func viewDidAppear(animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func sortWithWordFrequency(numberOfItensToReturn: Int){
        do{
            //apply sort algorithm just in WordFrequency class.
            //method wrote to handle exceptions
           let arrayWithWordFrequency = try wordFrequency.sortWithWordFrequency(wordFrequency.fileContent, numberOfItensToReturn: numberOfItensToReturn)
            do{
                //saving
                try wordFrequency.writeToFile(arrayWithWordFrequency.componentsJoinedByString(","))
            }
            catch{
                print("Writing issue")
            }
        }
        catch CustomError.sortingIssue{
            print("Error sorting file")
        }
        catch{
            print("Unknow error when sorting file")
        }
        
    }
}

