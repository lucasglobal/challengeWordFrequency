//
//  ShowResultsViewController.swift
//  wordFrequency
//
//  Created by Lucas Andrade on 1/22/16.
//  Copyright © 2016 LucasRibeiro. All rights reserved.
//

import UIKit

class ShowResultsViewController: UIViewController{
    @IBOutlet weak var labelFirstPlace: UILabel!
    @IBOutlet weak var labelSecondPlace: UILabel!
    @IBOutlet weak var labelThirdPlace: UILabel!
    var arrayWithWords: [String] = []

    override func viewDidLoad() {
        //Input to labels for final result
        do{
            try self.readToFileAndSetWordsArray()
            switch arrayWithWords.count{
            case 0:
                    labelFirstPlace.text = "No First Word"
                    labelSecondPlace.text = "No Second Word"
                    labelThirdPlace.text = "No Third Word"
            case 1:
                if(arrayWithWords[0] != ""){
                    labelFirstPlace.text = arrayWithWords[0]
                    labelSecondPlace.text = "No Second Word"
                    labelThirdPlace.text = "No Third Word"

                }
                else{
                    labelFirstPlace.text = "No First Word"
                    labelSecondPlace.text = "No Second Word"
                    labelThirdPlace.text = "No Third Word"

                }
            case 2:
                labelFirstPlace.text = arrayWithWords[0]
                labelSecondPlace.text = arrayWithWords[1]
                labelThirdPlace.text = "No Third Word"
            default:
                labelFirstPlace.text = arrayWithWords[0]
                labelSecondPlace.text = arrayWithWords[1]
                labelThirdPlace.text = arrayWithWords[2]            }
            
        }
        catch{
            print("Reading issue")
        }
        
    }
    func readToFileAndSetWordsArray() throws{
        //name of file that will be used to manage program
        let fileName = "words.txt"
        //getting directory and adding the file name on its final
        if let dir : NSString = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true).first {
            let path = dir.stringByAppendingPathComponent(fileName);
            //reading file
            do {
                let contentRead = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                arrayWithWords = contentRead.componentsSeparatedByString(",")
            }
            catch {
                throw CustomError.readingIssue
            }

        }
    }

}
