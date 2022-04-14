//
//  RealmManager.swift
//  petit-ami
//
//  Created by Bryan Nguyen on 4/12/22.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published var amis: [Ami] = []
    
    init() {
            openRealm()
            getAmis()
        }
    
    func openRealm() {
            do {
                // Setting the schema version
                let config = Realm.Configuration(schemaVersion: 2)

                // Letting Realm know we want the defaultConfiguration to be the config variable
                Realm.Configuration.defaultConfiguration = config

                // Trying to open a Realm and saving it into the localRealm variable
                localRealm = try Realm()
                // Get on-disk location of the default Realm
                let realm = try! Realm()
                print("Realm is located at:", realm.configuration.fileURL!)
            } catch {
                print("Error opening Realm", error)
            }
    }
    
    func addAmi(amiName: String) {
            if let localRealm = localRealm { // Need to unwrap optional, since localRealm is optional
                do {
                    // Trying to write to the localRealm
                    try localRealm.write {
                        // Creating a new Task
                        let newAmi = Ami(value: ["name": amiName])
                       
                        // Adding newTask to localRealm
                        localRealm.add(newAmi)
                        getAmis()
                        // Re-setting the tasks array
                        print("Ami Created!", newAmi)
                        
                    }
                } catch {
                    print("Error adding task to Realm: \(error)")
                }
            }
        }
    
    func getAmis() {
            if let localRealm = localRealm {
                let allAmis = localRealm.objects(Ami.self)
                amis = []
                allAmis.forEach{ami in
                    amis.append(ami)
                }
            }
        }
    func updateAmiHunger(id:ObjectId){
        if let localRealm = localRealm {
            do{
               let amiToUpdateHunger = localRealm.objects(Ami.self).filter(NSPredicate(format:"id == %@",id))
                guard !amiToUpdateHunger.isEmpty else {return}
                
                try localRealm.write{
                    amiToUpdateHunger[0].hunger=amiToUpdateHunger[0].hunger+1
                    getAmis()
                    print("Updated taks with id \(id)! Current Hunger: \(amiToUpdateHunger[0].hunger)")
                }
            }catch{
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }
    
    func decreaseAmiHunger(id:ObjectId){
           if let localRealm = localRealm {
               do{
                  let amiToUpdateHunger = localRealm.objects(Ami.self).filter(NSPredicate(format:"id == %@",id))
                   guard !amiToUpdateHunger.isEmpty else {return}
                   
                   try localRealm.write{
                       amiToUpdateHunger[0].hunger=amiToUpdateHunger[0].hunger-1
                       getAmis()
                       print("Updated taks with id \(id)! Current Hunger: \(amiToUpdateHunger[0].hunger)")
                   }
               }catch{
                   print("Error updating task \(id) to Realm: \(error)")
               }
           }
       }
}
