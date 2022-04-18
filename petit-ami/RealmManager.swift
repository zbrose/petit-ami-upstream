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
                let config = Realm.Configuration(schemaVersion: 4)

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
                    if (amiToUpdate[0].hygiene + 20 < 100) {
                        amiToUpdate[0].hygiene = amiToUpdate[0].hygiene + 20
                    } else {
                        amiToUpdate[0].hygiene = 100
                    }
                    getAmis()
                    print("Current Thirst: \(amiToUpdate[0].hygiene)")
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
    func increaseAmiHappinessManual (id:ObjectId){
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
                       if (amiToUpdate[0].hunger - 1 < 0) {
                           amiToUpdate[0].hunger = 0
                       } else {
                           amiToUpdate[0].hunger = amiToUpdate[0].hunger - 1
                       }
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
                       if (amiToUpdate[0].hygiene - 1 < 0) {
                           amiToUpdate[0].hygiene = 0
                       } else {
                           amiToUpdate[0].hygiene = amiToUpdate[0].hygiene - 1
                       }
                       getAmis()
                       print("Current Hygiene: \(amiToUpdate[0].hygiene)")
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
                       if (amiToUpdate[0].happiness - 1 < 0) {
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
                       if (amiToUpdate[0].energy - 1 > 0) {
                           amiToUpdate[0].energy = amiToUpdate[0].energy - 1
                       } else {
                           amiToUpdate[0].energy = 0
                       }
                       getAmis()
                       print("Current Energy: \(amiToUpdate[0].energy)")
                   }
               }catch{
                   print("Error updating task \(id) to Realm: \(error)")
               }
           }
       }
    
    func increaseAmiEnergy(id:ObjectId){
           if let localRealm = localRealm {
               do{
                  let amiToUpdate = localRealm.objects(Ami.self).filter(NSPredicate(format:"id == %@",id))
                   guard !amiToUpdate.isEmpty else {return}
                   
                   try localRealm.write{
                       if (amiToUpdate[0].energy + 1 < 100) {
                           amiToUpdate[0].energy = amiToUpdate[0].energy + 1
                       } else {
                           amiToUpdate[0].energy = 100
                       }
                       getAmis()
                       print("Current Energy: \(amiToUpdate[0].energy)")
                   }
               }catch{
                   print("Error updating task \(id) to Realm: \(error)")
               }
           }
       }
    
    func deadState(id:ObjectId) {
        if let localRealm = localRealm {
            do{
               let amiToUpdate = localRealm.objects(Ami.self).filter(NSPredicate(format:"id == %@",id))
                guard !amiToUpdate.isEmpty else {return}
                
                try localRealm.write{
                    amiToUpdate[0].alive = false
                    getAmis()
                    print("Current Energy: \(amiToUpdate[0].energy)")
                }
            }catch{
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }
    
    func replaceAmi(id: ObjectId, amiName: String) {
        if let localRealm = localRealm {
            do{
               let amiToDelete = localRealm.objects(Ami.self).filter(NSPredicate(format:"id == %@",id))
                guard !amiToDelete.isEmpty else {return}
                
                try localRealm.write{
                    // Creating a new Task
                    let newAmi = Ami(value: ["name": amiName])
                   
                    // Adding newTask to localRealm
                    localRealm.delete(amiToDelete)
                    localRealm.add(newAmi)
                    getAmis()
                    print("\(amis)")
                }
            }catch{
                print("Error updating task \(id) to Realm: \(error)")
            }
        }
    }
}
