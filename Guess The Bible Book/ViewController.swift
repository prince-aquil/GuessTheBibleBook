//
//  ViewController.swift
//  Guess The Bible Book
//
//  Created by Abigail Farrand on 01/08/2015.
//  Copyright (c) 2015 Far End Designs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate {


    
    @IBOutlet var verseArea: UITextView!
    @IBOutlet var bookWheel: UIPickerView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var bookName = ""
    var guessBook = "Genesis"
    var bookNameChapter = ""
    var verseNum = ""
    
     var bookList = ["Genesis", "Exodus", "Leviticus", "Numbers","Deuteronomy","Joshua", "Judges", "Ruth", "1 Samuel", "2 Samuel", "1 Kings", "2 Kings", "1 Chronicles", "2 Chronicles", "Ezra", "Nehemiah", "Esther", "Job", "Psalms", "Proverbs",  "Ecclesiastes","Song of Songs", "Isaiah", "Jeremiah", "Lamentations", "Ezekiel", "Daniel", "Hosea", "Joel", "Amos", "Obadiah", "Jonah", "Micah", "Nahum", "Habakkuk", "Zephaniah", "Haggai",  "Zechariah",  "Malachi",  "Matthew", "Mark", "Luke",  "John",  "Acts","Romans",  "1 Corinthians","2 Corinthians", "Galatians", "Ephesians", "Philippians", "Colossians", "1 Thessalonians", "2 Thessalonians", "1 Timothy", "2 Timothy", "Titus", "Philemon", "Hebrews", "James", "1 Peter", "2 Peter", "1 John",  "2 John","3 John", "Jude", "Revelation"]
    
//PICKERVIEW CONFIG//
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return bookList.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!{
        return bookList[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        var itemSelected = bookList[row]
        guessBook = itemSelected
    }
////
    
    override func viewDidLoad() {
        super.viewDidLoad()
         VerseChange()
        }
    
//BUTTON ACTIONS//
    @IBAction func submitButton(sender: UIButton) {
        activityIndicatorStart()
        if guessBook == bookName {
            AlertCreator("Correct", content: "Well done the verse was "+bookNameChapter+":"+verseNum)
            VerseChange()
        } else {
            AlertCreator("Incorrect", content: "Sorry the verse is not in "+guessBook+". Try Again")
        }
        activityIndicatorStop()
    }
    
    @IBAction func revealButton_click(sender: AnyObject) {
        activityIndicatorStart()
        AlertCreator("The Answer", content: "The verse was "+bookNameChapter+":"+verseNum)
        VerseChange()
        activityIndicatorStop()
    }
    
    @IBAction func newVerse_click(sender: AnyObject) {
        activityIndicatorStart()
         VerseChange()
        activityIndicatorStop()
    }
////
    
    
//VERSE GETTER FUNCTINO//
    func VerseChange() {
        
        let myURLString = "http://labs.bible.org/api/?passage=random&formatting=plain"
        
        if let myURL = NSURL(string: myURLString) {
            
            var error: NSError?
            let myHTMLString = NSString(contentsOfURL: myURL, encoding: NSUTF8StringEncoding, error: &error)
            var verseSplit = split(String(myHTMLString!)){ $0 == ":" }
            
            bookNameChapter = verseSplit[0]
            
            //NOW TEST FOR LONGER NAMES AND REMOVE CHAPTER
            
             var nameChunks = split(bookNameChapter){ $0 == " " }
            
            if nameChunks.count == 2 {
                bookName = nameChunks[0]
            } else if nameChunks.count == 3  {
                bookName = nameChunks[0] + " " + nameChunks[1]
            } else{
                VerseChange()
            }
            
            if let error = error {
            } else {
                var verseSplitAgain = split(verseSplit[1]){ $0 == " " }
                verseNum = verseSplitAgain[0]
                var verseNumCount = count(verseNum)
                var tempString = verseSplit[1].stringByReplacingOccurrencesOfString("&#8211;", withString: "-")
            tempString = tempString.stringByReplacingOccurrencesOfString("&#1499;", withString: "-")
                
                tempString = tempString.substringWithRange(Range<String.Index>(start: advance(tempString.startIndex, verseNumCount+1), end: tempString.endIndex))
                
                verseArea.text = tempString
                
                println(bookName)
                println(bookNameChapter+":"+verseNum)
            }
            
        } else {
            println("Error: \(myURLString) doesn't seem to be a valid URL")
        }
    }
  ////
    
    
  //ALERT FUNCTION//
    func AlertCreator(title: String, content: String){
    let alertController = UIAlertController(title: title, message:
        content, preferredStyle: UIAlertControllerStyle.Alert)
    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
    self.presentViewController(alertController, animated: true, completion: nil)
    }
////
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func activityIndicatorStart(){
        
        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }

    
    func activityIndicatorStop(){
        activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
}

