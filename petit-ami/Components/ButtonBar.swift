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
            Image("pizza")
                .resizable()
                .padding(1.5)
                .frame(width: 20, height: 20)
        }
    }
}

struct ButtonBar: View {
    @StateObject var realmManager = RealmManager()
    @State private var showNameAmiView = false
    @State var hungerRemaining = RealmManager().amis[0].hunger
    @State var thirstRemaining = RealmManager().amis[0].thirst
    @State var happinessRemaining = RealmManager().amis[0].happiness
    @State var energyRemaining = RealmManager().amis[0].energy
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let energyTimer = Timer.publish(every: 100, on: .main, in: .common).autoconnect()
   
    var body: some View {
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
                        .font(.system(size: 10, weight: .bold, design: .default))
                    
                    Text("Energy: \(String(realmManager.amis[0].energy))")
                        .font(.system(size: 10, weight: .bold, design: .default))
                        .onReceive(energyTimer) { _ in
                            if energyRemaining > 0 {
                                energyRemaining -= 1
                                realmManager.decreaseAmiEnergy(id: realmManager.amis[0].id)
                            }
                        }
                }
                VStack{
            
                    Text("Happiness: \(String(realmManager.amis[0].happiness))")
                        .onReceive(timer) { _ in
                            if (thirstRemaining < 50 || hungerRemaining < 50 && happinessRemaining > 0) {
                                happinessRemaining -= 1
                                realmManager.decreaseAmiHappiness(id: realmManager.amis[0].id)
                            } else if (happinessRemaining < 100) {
                                happinessRemaining += 1
                                realmManager.increaseAmiHappiness(id: realmManager.amis[0].id)
                            }
                        }
                        .font(.system(size: 10, weight: .bold, design: .default))
                }
                
                VStack{
                    Text("Thirst:\(realmManager.amis[0].thirst)")
                        .font(.system(size: 10, weight: .bold, design: .default))
                        .onReceive(timer) { _ in
                            if thirstRemaining > 0 {
                                thirstRemaining -= 1
                                realmManager.decreaseAmiThirst(id: realmManager.amis[0].id)
                            }
                        }
                    ProgressView(value: Float(hungerRemaining)/100)
                        .progressViewStyle(GaugeProgressStyle())
                        .frame(width: 20, height: 20)
                                    .contentShape(Rectangle())
                        .onReceive(timer) { _ in
                            if hungerRemaining > 0 {
                                hungerRemaining -= 1
                                realmManager.decreaseAmiHunger(id: realmManager.amis[0].id)
                            }
                        }
                        .font(.system(size: 10, weight: .bold, design: .default))
                        .onAppear()
                }
            }
                
            }
        HStack{
            

            FeedButton()
                .onTapGesture {
                    hungerRemaining += 20
                    realmManager.updateAmiHunger(id:realmManager.amis[0].id)
                }
            SleepButton()
                .onTapGesture {
                    print("Sleep")
                }
            
            DrinkButton()
                .onTapGesture {
                    thirstRemaining += 20
                    realmManager.updateAmiThirst(id:realmManager.amis[0].id)
                }
            
            PetButton()
                .onTapGesture {
                    print("Pet")
                }
                    
                    
                }
                .environmentObject(realmManager)
            
//            Text("\(Showhunger)")
            
           
            
        }
    }
    }


struct ButtonBar_Previews: PreviewProvider {
    static var previews: some View {
        ButtonBar()
            .environmentObject(RealmManager())
            
    }
}

