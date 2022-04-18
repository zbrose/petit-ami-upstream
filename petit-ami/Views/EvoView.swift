//
//  EvoView.swift
//  petit-ami
//
//  Created by Zach Brose on 4/16/22.
//

import SwiftUI

struct EvoView: View {
    @StateObject var realmManager = RealmManager()
    
    func daysSince(date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
    }
    
    func evolutionImg(int: Int, str: String) -> String{
        if(int == 2 && str == "egg") {
            return "BabyCrack"
        } else if (int == 25 && str == "baby") {
            return "EggtoTeen"
        } else if (int == 50 && str == "child") {
            return "EggEating"
        } else if (int == 100 && str == "teenager") {
            return "SleepingEgg"
        } else {
            return "BabyCrack"
        }
    }
    
    func lifeStage(int: Int) -> String{
        if (int >= 100) {
            return "adult"
        } else if (int >= 50) {
            return "teenager"
        } else if (int >= 25) {
            return "child"
        } else if (int >= 2) {
            return "baby"
        } else {
            return "egg"
        }
    }
    
    var body: some View {
        
        VStack {
            let amiAge = daysSince(date: RealmManager().amis[0].creationDate)
            let lStage = lifeStage(int: amiAge)
            
            Text("Your Ami is Evolving!")
                .font(.title).bold()
                .padding()

            
            GifImage(evolutionImg(int: amiAge, str: lStage))
                .frame(width:400,height: 400)
                
        }
        .padding()
    }
    
}

struct EvoView_Previews: PreviewProvider {
    static var previews: some View {
        EvoView()
    }
}
