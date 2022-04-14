//
//  ButtonBar.swift
//  petit-ami
//
//  Created by Triston Palacios on 4/13/22.
//

import SwiftUI
struct GaugeProgressStyle: ProgressViewStyle {
    var strokeColor = Color.red
    var strokeWidth = 2.0

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(fractionCompleted))
                .stroke(strokeColor, style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
                .rotationEffect(.degrees(-90))
        }
    }
}

struct ButtonBar: View {
    @StateObject var realmManager = RealmManager()
    @State private var showNameAmiView = false
    @State var hungerRemaining = RealmManager().amis[0].hunger
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
   
    var body: some View {
        let hungerPercent = Float(hungerRemaining)/100
        VStack{
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
                ProgressView(value: hungerPercent)
                    .progressViewStyle(GaugeProgressStyle())
                    .frame(width: 20, height: 20)
                                .contentShape(Rectangle())
                VStack{
                    Text("Thirst:\(realmManager.amis[0].thirst)")
                        .frame(width: .infinity,  alignment: .top)
                        .font(.system(size: 10, weight: .bold, design: .default))
                    Text("Hunger: \(hungerRemaining)")
                        .onReceive(timer) { _ in
                            if hungerRemaining > 0 {
                                hungerRemaining -= 1
                                realmManager.decreaseAmiHunger(id: realmManager.amis[0].id)
                            }
                        }
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
                    hungerRemaining += 1
                    print("The Fake hunger is \(realmManager.amis[0].hunger)")
                    
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

