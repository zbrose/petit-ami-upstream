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
        VStack{
            var Showhunger = realmManager.amis[0].hunger
            Image("Still-1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.all)
                .frame(width: 375.0, height: 450.0, alignment: .top)
            VStack{
                
            
                
                Text("\(realmManager.amis[0].name)")
                    .font(.system(size: 30, weight: .bold, design: .default))
    //            print("\(ButtonInfo)")
            HStack{
                VStack{
                    
                    Text("Age: \(realmManager.amis[0].age)/\(realmManager.amis[0].lifeStage)")
                        .frame(width: .infinity,  alignment: .top)
                        .font(.system(size: 10, weight: .bold, design: .default))
                    Text("Energy: \(String(realmManager.amis[0].energy))")
                        .frame(width: .infinity,  alignment: .top)
                        .font(.system(size: 10, weight: .bold, design: .default))
                }
                VStack{
            
                    Text("Happiness: \(String(realmManager.amis[0].happiness))")
                        .frame(width: .infinity,  alignment: .top)
                        .font(.system(size: 10, weight: .bold, design: .default))
                }
                VStack{
                    Text("Thirst:\(realmManager.amis[0].thirst)")
                        .frame(width: .infinity,  alignment: .top)
                        .font(.system(size: 10, weight: .bold, design: .default))
                    Text("Hunger: \(Showhunger)")
                        .frame(width: .infinity,  alignment: .top)
                        .font(.system(size: 10, weight: .bold, design: .default))
                        .onAppear()
                }
            }
                
            }
        HStack{
            
            
            FeedButton()
                .onTapGesture {
                    print("The Ami is fed")
                    realmManager.updateAmiHunger(id:realmManager.amis[0].id)
                    Showhunger+=1
                    print("The Fake hunger is \(Showhunger)")
                    
                }
                .environmentObject(realmManager)
            
//            Text("\(Showhunger)")
            
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
}

struct ButtonBar_Previews: PreviewProvider {
    static var previews: some View {
        ButtonBar()
            .environmentObject(RealmManager())
            
    }
}

