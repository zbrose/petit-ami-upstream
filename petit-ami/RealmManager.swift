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
               let amiToUpdate = localRealm.objects(Ami.self).filter(NSPredicate(format:"id == %@",id))
                guard !amiToUpdate.isEmpty else {return}
                
                try localRealm.write{
                    if (amiToUpdate[0].hunger + 20 < 100) {
                        amiToUpdate[0].hunger = amiToUpdate[0].hunger + 20
                    } else {
                        amiToUpdate[0].hunger = 100
                    }
                    getAmis()
                    print("Current Hunger: \(amiToUpdate[0].hunger)")
                }
            }catch{
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }
    
    func updateAmiThirst(id:ObjectId){
        if let localRealm = localRealm {
            do{
               let amiToUpdate = localRealm.objects(Ami.self).filter(NSPredicate(format:"id == %@",id))
                guard !amiToUpdate.isEmpty else {return}
                
                try localRealm.write{
                    if (amiToUpdate[0].thirst + 20 < 100) {
                        amiToUpdate[0].thirst = amiToUpdate[0].thirst + 20
                    } else {
                        amiToUpdate[0].thirst = 100
                    }
                    getAmis()
                    print("Current Thirst: \(amiToUpdate[0].thirst)")
                }
            }catch{
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }
    
    func increaseAmiHappiness (id:ObjectId){
        if let localRealm = localRealm {
            do{
               let amiToUpdate = localRealm.objects(Ami.self).filter(NSPredicate(format:"id == %@",id))
                guard !amiToUpdate.isEmpty else {return}
                
                try localRealm.write{
                    if (amiToUpdate[0].happiness + 1 < 100) {
                        amiToUpdate[0].happiness = amiToUpdate[0].happiness + 1
                    } else {
                        amiToUpdate[0].happiness = 100
                    }
                    getAmis()
                    print("Current Happiness: \(amiToUpdate[0].happiness)")
                }
            }catch{
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }
    
    func decreaseAmiHunger(id:ObjectId){
           if let localRealm = localRealm {
               do{
                  let amiToUpdate = localRealm.objects(Ami.self).filter(NSPredicate(format:"id == %@",id))
                   guard !amiToUpdate.isEmpty else {return}
                   
                   try localRealm.write {
                       amiToUpdate[0].hunger = amiToUpdate[0].hunger - 1
                       getAmis()
                       print("Current Hunger: \(amiToUpdate[0].hunger)")
                   }
               }catch{
                   print("Error updating task \(id) to Realm: \(error)")
               }
           }
       }
    
    func decreaseAmiThirst(id:ObjectId){
           if let localRealm = localRealm {
               do{
                  let amiToUpdate = localRealm.objects(Ami.self).filter(NSPredicate(format:"id == %@",id))
                   guard !amiToUpdate.isEmpty else {return}
                   
                   try localRealm.write{
                       amiToUpdate[0].thirst = amiToUpdate[0].thirst - 1
                       getAmis()
                       print("Current Thirst: \(amiToUpdate[0].thirst)")
                   }
               }catch{
                   print("Error updating task \(id) to Realm: \(error)")
               }
           }
       }
    
    func decreaseAmiHappiness(id:ObjectId){
           if let localRealm = localRealm {
               do{
                  let amiToUpdate = localRealm.objects(Ami.self).filter(NSPredicate(format:"id == %@",id))
                   guard !amiToUpdate.isEmpty else {return}
                   
                   try localRealm.write{
                       if (amiToUpdate[0].happiness < 0) {
                           amiToUpdate[0].happiness = 0
                       } else {
                           amiToUpdate[0].happiness = amiToUpdate[0].happiness - 1
                       }
                       getAmis()
                       print("Current Happiness: \(amiToUpdate[0].happiness)")
                   }
               }catch{
                   print("Error updating task \(id) to Realm: \(error)")
               }
           }
       }
    
    func decreaseAmiEnergy(id:ObjectId){
           if let localRealm = localRealm {
               do{
                  let amiToUpdate = localRealm.objects(Ami.self).filter(NSPredicate(format:"id == %@",id))
                   guard !amiToUpdate.isEmpty else {return}
                   
                   try localRealm.write{
                       amiToUpdate[0].energy = amiToUpdate[0].energy - 1
                       getAmis()
                       print("Current Happiness: \(amiToUpdate[0].energy)")
                   }
               }catch{
                   print("Error updating task \(id) to Realm: \(error)")
               }
           }
       }
}
