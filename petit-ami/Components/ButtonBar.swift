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
         
            FeedButton()
                .onTapGesture {
                    print("feeding time")
                }
            
            SleepButton()
                .onTapGesture {
                    print("Hello ")
                }
            
            
            
            DrinkButton()
                .onTapGesture {
                    print("Hello ")
                }
            PetButton()
            
        }
    }
}

struct ButtonBar_Previews: PreviewProvider {
    static var previews: some View {
        ButtonBar()
    }
}
