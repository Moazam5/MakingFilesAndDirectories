//
//  ViewController.swift
//  fileHandler
//
//  Created by Moazam Mir on 1/20/20.
//  Copyright © 2020 Moazam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    let dirName = "dir"
    var b = 1
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

  //  let fileContent : String?
    

    let text = "This is the text I want to write"
    
    func write(){
        
        let dataPath = docDir.appendingPathComponent("file.txt")
        let dataPath2 = docDir.appendingPathComponent("\(dirName)+\(b)" ).appendingPathComponent("file.txt")

        do{
            try text.write(to: dataPath2, atomically: true, encoding: .utf8)
        }catch{
            print("Faced an error \(error)")
    }
    }
    
    func read(){
        let fileContent : String?
        let dataPath = docDir.appendingPathComponent("file.txt")

        do{
            fileContent = try String(contentsOf: dataPath)
            displayLabel.text = fileContent
        }catch{
            print("Error reading the file: \(error)")
        }
        
        
    }
    
    var a = 1
    
    func updateText(){
        
        var moreText = "\n Now I am using File Handler"
        let dataPath = docDir.appendingPathComponent("file.txt")
        let dataPath2 = docDir.appendingPathComponent("\(dirName)+\(b)" ).appendingPathComponent("file.txt")

      
        if let fileUpdater = try? FileHandle(forUpdating: dataPath2){
            fileUpdater.seekToEndOfFile()
            fileUpdater.write(moreText.data(using: .utf8)!)
            fileUpdater.closeFile()
        }
        
        moreText = "This is the new resut \(a += 1)"
    }
    
    func createDir()
       {
           let dataPath = documentsDirectory.appendingPathComponent("\(dirName)+\(b)" )
           do {
                  try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
                  print(dataPath.path)
                  b += 1
                  } catch let error as NSError{
                       print("Error creating directory: \(error.localizedDescription)")
                  }
           
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func makeDirButton(_ sender: UIButton)
    {
        write()
  //  updateText()
    }
    
    @IBAction func readButton(_ sender: UIButton)
    {
        read()
        
    }
    @IBAction func updateButton(_ sender: UIButton) {
        updateText()
    }
    
    @IBAction func createDirectory(_ sender: UIButton) {
        createDir()
    }
}

/*
 From initial vc, get the id
 From setParams VC get the date time info just before segue
 All of these will be stored in app delegate
 Directory has to be created during segue so it exists when called from thirdVC
 
 then just access these from
 */
