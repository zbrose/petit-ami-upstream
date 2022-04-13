//
//  StatusBars.swift
//  petit-ami
//
//  Created by Zach Brose on 4/12/22.
//

import SwiftUI

struct StatusBars: View {
    @EnvironmentObject var realmManager: RealmManager
//    let hungerCount = realmManager.amis
    var body: some View {
        VStack{
        Text("Hunger")
            .font(.title).bold()
//        Text("the hunger is \(hungerCount)")
       
        }
       
    }
}

struct StatusBars_Previews: PreviewProvider {
    static var previews: some View {
        StatusBars()
    }
}
