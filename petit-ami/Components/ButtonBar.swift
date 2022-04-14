//
//  ButtonBar.swift
//  petit-ami
//
//  Created by Triston Palacios on 4/13/22.
//

import SwiftUI

struct ButtonBar: View {
    @StateObject var realmManager = RealmManager()
    @State private var showNameAmiView = false
    
    var body: some View {
        HStack{
            
            
            var Showhunger = realmManager.amis[0].hunger
           
            
            FeedButton()
                .onTapGesture {
                    print("The Ami is fed")
                    realmManager.updateAmiHunger(id:realmManager.amis[0].id)
                    Showhunger+=1
                    print("The Fake hunger is \(Showhunger)")
                    
                }
                .environmentObject(realmManager)
            
            Text("\(Showhunger)")
            
            SleepButton()
                .onTapGesture {
                    print("Sleep")
                }
            
            DrinkButton()
                .onTapGesture {
                    print("Drink")
                }
            
            PetButton()
                .onTapGesture {
                    print("Pet")
                }
            
        }
    }
}

struct ButtonBar_Previews: PreviewProvider {
    static var previews: some View {
        ButtonBar()
            .environmentObject(RealmManager())
            
    }
}

