//
//  AmiView.swift
//  petit-ami
//
//  Created by Zach Brose on 4/13/22.
//

import SwiftUI
import RealmSwift

struct AmiView: View {
    @EnvironmentObject var realmManager : RealmManager
    let amis = realm.objects(Ami.self)
    var body: some View {
        Text(Ami.self)
    }
}

//struct AmiView_Previews: PreviewProvider {
//    static var previews: some View {
//        AmiView(ami:Ami)
//    }
//}
