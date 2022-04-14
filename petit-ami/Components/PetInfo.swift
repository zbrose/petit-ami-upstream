//
//  PetInfo.swift
//  petit-ami
//
//  Created by Triston Palacios on 4/13/22.
//

import SwiftUI

struct PetInfo: View {
    @StateObject var realmManager = RealmManager()
    var body: some View {
        VStack{
            
            var ButtonInfo = ButtonBar()
            
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
                Text("Hunger: \(realmManager.amis[0].thirst))")
                    .frame(width: .infinity,  alignment: .top)
                    .font(.system(size: 10, weight: .bold, design: .default))
                    .onAppear()
            }
        }
            
        }
    }
}

struct PetInfo_Previews: PreviewProvider {
    static var previews: some View {
        PetInfo()
            .environmentObject(RealmManager())
    }
}
