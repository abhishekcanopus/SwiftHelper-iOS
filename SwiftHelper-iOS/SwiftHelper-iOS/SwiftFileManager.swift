//
//  MissionPlanFileManager.swift
//  Swift Helper
//
//  Created by Abhishek on 23/11/16.
//  Copyright © 2016 Abhishek. All rights reserved.
//

import UIKit

class MissionPlanFileManager: NSObject {

    //Create Singleton Object.
    static var sharedFileManger =  MissionPlanFileManager()
    
    
    //MARK:- Save Data in Json File
    func saveIntoJsonFileWithName(fileName:String,info:NSDictionary)->Void {
    
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let folder = filePath[0] + "/SwiftHelper"
        let fileAtPath = (folder as NSString ).appendingPathComponent("\(fileName).swh")
        if !FileManager.default.fileExists(atPath: fileAtPath){
        
            FileManager.default.createFile(atPath: fileAtPath, contents: nil, attributes: nil)
        }
        
        
        var jsonData: NSData?
        do {
            jsonData = try JSONSerialization.data(withJSONObject: info, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData?
        } catch let error as NSError {
            print(error)
        }
        
         jsonData!.write(toFile: fileAtPath, atomically: false)
        
    }
    
    //MARK:- Rename File Name
    func renameFlightPlan(oldFileName:String, newFileName:String) {
        
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let folder = filePath[0] + "/SwiftHelper"
        let oldFileAtPath = (folder as NSString ).appendingPathComponent("\(oldFileName).swh")
        let newFileAtPath = (folder as NSString).appendingPathComponent("\(newFileName).swh")
        
        do {
            try FileManager.default.moveItem(atPath: oldFileAtPath, toPath: newFileAtPath)
        } catch let error as NSError {
            print(error)
        }
        
        
    }
    
    
    //MARK:- Load a file from FileName
    func loadJsonFileIntoFileAtPAth(fileName:String,completion:(_ success:Bool,_ missionPlan:NSDictionary?)->Void) {
        
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let folder = filePath[0] + "/SwiftHelper"
        let fileAtPath = (folder as NSString ).appendingPathComponent("\(fileName).swh")
        do {
            try FileManager.default.createDirectory(atPath: folder, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            NSLog("Unable to create directory \(error.debugDescription)")
        }
        
        if let compressedData = NSData(contentsOfFile: fileAtPath) {

            let jsonMissionPlan = NSString(data: compressedData as Data, encoding: String.Encoding.utf8.rawValue);
            
            if jsonMissionPlan != nil && jsonMissionPlan != ""{
                
                do {
                    
                    let dictResults = try JSONSerialization.jsonObject(with: (jsonMissionPlan?.data(using: String.Encoding.utf8.rawValue))!, options: [])
                    
                    completion(true, dictResults as? NSDictionary)
                    
                }catch _ {
                    
                    completion(false,nil)
                    
                }
                
            }
        else{
        
            completion(false, nil)

        }
        }
        else {
            completion(false, nil)
        }
        
    }
    
    //MARK:- Get all files name.
    func getAllFiles() -> [String]? {
        
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let folder = filePath[0] + "/SwiftHelper"
        do {
            try FileManager.default.createDirectory(atPath: folder, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            NSLog("Unable to create directory \(error.debugDescription)")
        }

        let filemgr = FileManager.default
        let enumerator:FileManager.DirectoryEnumerator = filemgr.enumerator(atPath: folder)!
        var filesToLoad: [String] = []
        while var element = enumerator.nextObject() as? String {
            if element.hasSuffix("swh") { // checks the extension
                element.remove(at: element.index(before: element.endIndex))
                element.remove(at: element.index(before: element.endIndex))
                element.remove(at: element.index(before: element.endIndex))
                element.remove(at: element.index(before: element.endIndex))
                let fileName = element
                filesToLoad.append(fileName)
                
            }
        }
        return filesToLoad
    }
    
    //MARK :- Delete a File.
    func deleteFile(fileName: String) {
        
        let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let folder = filePath[0] + "/SwiftHelper"
        let fileAtPath = (folder as NSString ).appendingPathComponent("\(fileName).swh")
        let filemgr = FileManager.default
        do {
            try filemgr.removeItem(atPath: fileAtPath)
        } catch let error as NSError {
            print("error deleting file \(error)")
        }
        
    }
}
