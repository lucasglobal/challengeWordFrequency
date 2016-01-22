//
//  ViewController.swift
//  wordFrequency
//
//  Created by Lucas Andrade on 1/21/16.
//  Copyright © 2016 LucasRibeiro. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initializing class that has methods related to the challenging
        let wordfrequency = WordFrequency()
        do{
            //reading file and testing its management
            try wordfrequency.readFile()
        }
        catch FileError.readingIssue {
            print("Unknown problem reading file")
        }
        catch FileError.writingIssue {
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


}

