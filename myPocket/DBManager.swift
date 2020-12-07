//
//  DBManager.swift
//  FMDBTut
//
//  Created by Engin KUK on 4.12.2020.
//  Copyright © 2020 Appcoda. All rights reserved.
//

import UIKit
import FMDB

class DBManager: NSObject {

    static let shared: DBManager = DBManager()
    let databaseFileName = "database.sqlite"
    var pathToDatabase: String!
    var database: FMDatabase!
    
    let field_EntryID = "entryID"
    let field_EntryType = "type"
    let field_EntryTitle = "title"
    let field_EntryAmount = "amount"
    
    override init() {
        super.init()
     
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    
    
    func createDatabase() -> Bool {
        var created = false
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
            
            if database != nil {
                // Open the database.
                if database.open() {
                    let createEntriesTableQuery = "create table entries (\(field_EntryID) integer primary key autoincrement not null, \(field_EntryTitle) text not null, \(field_EntryAmount) bool not null default 0, \(field_EntryAmount) integer not null)"
                    
                    do {
                        try database.executeUpdate(createEntriesTableQuery, values: nil)
                        created = true
                    }
                    catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
                    
                    database.close()
                }
                else {
                    print("Could not open the database.")
                }
            }
        }
        
        return created
    }
    
    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)   //this creates the database if it doesnt exists
            // No connection is being established at that point though. We just know that after that line we can use the database property to have access to our database.
            }
        }
        
            if database != nil {
                if database.open() {
                    return true
                } else {
                    print("Could not open the database.")
                }
            }
            return false
    }
    
 
    func insertEntryData() {
        if openDatabase() {
            var query = ""
            query += "insert into entries (\(field_EntryID), \(field_EntryType), \(field_EntryTitle), \(field_EntryAmount)) values (null, false, gym, 100)"

            if !database.executeStatements(query) {
                print("Failed to insert initial data into the database.")
                print(database.lastError(), database.lastErrorMessage())
        }
            database.close()
        }
    }
    
    func loadEntry() -> [Entry]! {
        var entries: [Entry]!
        
        if openDatabase() {
            // create the SQL query that tells the database which data to load:
            let query = "select * from entries order by \(field_EntryTitle) asc"
            // we’re just asking from FMDB to fetch all the entries ordered in an ascending order
            do {
                print(database ?? "no db")
                let results = try database.executeQuery(query, values: nil)
                // The results.next() method should be always called.for single methods call if statement instead of while
                while results.next() {
                    let entry = Entry(entryID: Int(results.int(forColumn: field_EntryID)), type: results.bool(forColumn: field_EntryType),title: results.string(forColumn: field_EntryTitle), amount: Int(results.int(forColumn: field_EntryAmount))
                    )
                 
                    if entries == nil {
                        entries = [Entry]()
                    }
                 
                    entries.append(entry)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            database.close()
        }
     
        return entries
    }
    
    // you can use completion handlers instead of return values when fetching data from the database.
    
    func loadEntry(withID ID: Int, completionHandler: (_ entryInfo: Entry?) -> Void) {
        var entry: Entry!
     
        if openDatabase() {
            // this query loads according to ID of the entry
            let query = "select * from entries where \(field_EntryID)=?"
     
            do {
                let results = try database.executeQuery(query, values: [ID])
     
                if results.next() {
                      entry = Entry(entryID: Int(results.int(forColumn: field_EntryID)), type: results.bool(forColumn: field_EntryType),title: results.string(forColumn: field_EntryTitle), amount: Int(results.int(forColumn: field_EntryAmount))
                    )
     
                }
                else {
                    print(database.lastError())
                }
            }
            catch {
                print(error.localizedDescription)
            }
     
            database.close()
        }
     
        completionHandler(entry)
    }
     
    func updateEntry(withID ID: Int, type: Bool, likes: Int) {
        if openDatabase() {
            let query = "update entries set \(field_EntryType)=?, \(field_EntryAmount)=? where \(field_EntryID)=?"
     
            do {
                // This method is the one that you have to use to perform any kind of changes to the database create or update
                // The second parameter of that method is again an array of Any objects that you pass along with the query that will be executed.
                try database.executeUpdate(query, values: [type, likes, ID])
                // we could return a bool value to indicate if db is updated.
            }
            catch {
                print(error.localizedDescription)
            }
     
            database.close()
        }
    }
     
    func deleteEntry(withID ID: Int) -> Bool {
        var deleted = false
     
        if openDatabase() {
            let query = "delete from entries where \(field_EntryID)=?"
     
            do {
                try database.executeUpdate(query, values: [ID])
                deleted = true
            }
            catch {
                print(error.localizedDescription)
            }
     
            database.close()
        }
     
        return deleted
    }
    
    
}
 
