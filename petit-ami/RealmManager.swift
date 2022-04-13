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
            getAmi()
        }
    
    func openRealm() {
            do {
                // Setting the schema version
                let config = Realm.Configuration(schemaVersion: 1)

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
                        getAmi()
                        // Re-setting the tasks array
                        print("Ami Created!", newAmi)
                        
                    }
                } catch {
                    print("Error adding task to Realm: \(error)")
                }
            }
        }
    
    func getAmi(){
            if let localRealm = localRealm {
                let allAmis = localRealm.objects(Ami.self)
                amis = []
                allAmis.forEach{ami in
                    amis.append(ami)
                }
            }
        }
}
