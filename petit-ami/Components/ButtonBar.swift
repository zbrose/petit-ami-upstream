//
//  ButtonBar.swift
//  petit-ami
//
//  Created by Triston Palacios on 4/13/22.
//

import SwiftUI
struct HungerGaugeProgressStyle: ProgressViewStyle {
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

struct EnergyGaugeProgressStyle: ProgressViewStyle {
    var strokeColor = Color.yellow
    var strokeWidth = 2.0

    func makeBody(configuration: Configuration) -> some View {
        let fractionCompleted = configuration.fractionCompleted ?? 0

        return ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(fractionCompleted))
                .stroke(strokeColor, style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
                .rotationEffect(.degrees(-90))
            Image("Bolt")
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
    @State var hygieneRemaining = RealmManager().amis[0].hygiene
    @State var happinessRemaining = RealmManager().amis[0].happiness
    @State var energyRemaining = Double(RealmManager().amis[0].energy)
    @State private var showInstructions = false
    @State public var sleepState: Bool = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let energyTimer = Timer.publish(every: 100, on: .main, in: .common).autoconnect()
   
    func daysSince(date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
    }
    
    func lifeStage(int: Int) -> String {
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
        VStack{
            let amiAge = daysSince(date: RealmManager().amis[0].creationDate)
                                   
            Button{
                showInstructions.toggle()
            } label :{
                Image(systemName: "questionmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .sheet(isPresented: $showInstructions){
                InstructionsView()
            }
            Spacer()
            GifImage("RotateLeft")
                .frame(width:500,height: 500)
                .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
          
//            Image("Still-1")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .padding(.all)
//                .frame(width: 375.0, height: 450.0, alignment: .top)
            VStack{
                
                Text("\(realmManager.amis[0].name)")
                    .font(.system(size: 30, weight: .bold, design: .default))
    //            print("\(ButtonInfo)")
            HStack{
                VStack{
                    
                    Text("Age: \(amiAge) d / \(lifeStage(int: amiAge))")
                        .font(.system(size: 10, weight: .bold, design: .default))
                    
                    ProgressView(value: Float(energyRemaining)/100)
                        .progressViewStyle(EnergyGaugeProgressStyle())
                        .frame(width: 20, height: 20)
                                    .contentShape(Rectangle())
                        .onReceive(timer) { _ in
                            if (sleepState == true && energyRemaining + 1 < 100) {
                                energyRemaining += 1
                                realmManager.increaseAmiEnergy(id: realmManager.amis[0].id)
                            } else if (sleepState == false && energyRemaining - 0.2 > 0) {
                                energyRemaining -= 0.2
                                realmManager.decreaseAmiEnergy(id: realmManager.amis[0].id)
                            }
                        }
                        .font(.system(size: 10, weight: .bold, design: .default))
                        .onAppear()
                }
                
                VStack{
            
                    Text("Happiness: \(String(realmManager.amis[0].happiness))")
                        .onReceive(timer) { _ in
                            if ((hygieneRemaining < 50 || hungerRemaining < 50) && happinessRemaining > 0) {
                                happinessRemaining -= 1
                                realmManager.decreaseAmiHappiness(id: realmManager.amis[0].id)
                            } else if ((hygieneRemaining >= 50 && hungerRemaining >= 50) && happinessRemaining < 100) {
                                happinessRemaining += 1
                                realmManager.increaseAmiHappiness(id: realmManager.amis[0].id)
                            }
                        }
                        .font(.system(size: 10, weight: .bold, design: .default))
                }
                
                VStack{
                    Text("Hygiene:\(realmManager.amis[0].hygiene)")
                        .font(.system(size: 10, weight: .bold, design: .default))
                        .onReceive(timer) { _ in
                            if hygieneRemaining > 0 {
                                hygieneRemaining -= 1
                                realmManager.decreaseAmiThirst(id: realmManager.amis[0].id)
                            }
                        }
                    ProgressView(value: Float(hungerRemaining)/100)
                        .progressViewStyle(HungerGaugeProgressStyle())
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
                    if (sleepState == true) {
                        print("Sleeping")
                    } else if (hungerRemaining + 20 < 100) {
                        hungerRemaining += 20
                        realmManager.updateAmiHunger(id:realmManager.amis[0].id)
                    } else {
                        hungerRemaining = 100
                        realmManager.updateAmiHunger(id:realmManager.amis[0].id)
                    }
                }
         
            SleepButton(sleepState: .constant(sleepState))
                .onTapGesture {
                    sleepState.toggle()
                    print(realmManager.amis[0].energy)
                }

            
            DrinkButton()
                .onTapGesture {
                    if (sleepState == true) {
                        print("Sleeping")
                    } else if (hygieneRemaining + 20 < 100) {
                        hygieneRemaining += 20
                        realmManager.updateAmiThirst(id:realmManager.amis[0].id)
                    } else {
                        hygieneRemaining = 100
                        realmManager.updateAmiThirst(id:realmManager.amis[0].id)
                    }
                }
            
            PetButton()
                .onTapGesture {
                    if (sleepState == true) {
                        print("Sleeping")
                    } else {
                        print("Pet")
                    }
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


