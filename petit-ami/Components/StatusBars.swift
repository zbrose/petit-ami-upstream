//
//  StatusBars.swift
//  petit-ami
//
//  Created by Zach Brose on 4/12/22.
//

import SwiftUI

struct StatusBars: View {
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        VStack{
        Text("Hunger")
            .font(.title).bold()
            
            List {
                ForEach(realmManager.amis, id: \.id) { ami in
                    if !ami.isInvalidated {
                        Text(ami.lifeStage)
                    }
                }
            }
        }
    }
}

struct StatusBars_Previews: PreviewProvider {
    static var previews: some View {
        StatusBars()
            .environmentObject(RealmManager())
    }
}
