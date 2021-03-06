//
//  FoodUpdateView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/3/6.
//

import SwiftUI

struct FoodUpdateView: View {
    var foodID: Int
    init(food: Food){
        self.foodID = food.id
        _foodNameCHN = State(initialValue: food.foodNameCHN)
        _caloriesText = State(initialValue: String(food.calories))
        _carbohydrateText = State(initialValue: String(food.carbohydrate))
        _fatText = State(initialValue: String(food.fat))
        _proteinText = State(initialValue: String(food.protein))
        _sodiumText = State(initialValue: String(food.sodium))
        _cholesterolText = State(initialValue: String(food.cholesterol))
        _dietaryFiberText = State(initialValue: String(food.dietaryFiber))
        _vitaminAText = State(initialValue: String(food.vitaminA))
        _vitaminEText = State(initialValue: String(food.vitaminE))
        _vitaminB1Text = State(initialValue: String(food.vitaminB1))
        _vitaminB2Text = State(initialValue: String(food.vitaminB2))
        _vitaminCText = State(initialValue: String(food.vitaminC))
        _caroteneText = State(initialValue: String(food.carotene))
        _niacinText = State(initialValue: String(food.niacin))
        _phosphorusText = State(initialValue: String(food.phosphorus))
        _potassiumText = State(initialValue: String(food.potassium))
        _magnesiumText = State(initialValue: String(food.magnesium))
        _calciumText = State(initialValue: String(food.calcium))
        _ironText = State(initialValue: String(food.iron))
        _zincText = State(initialValue: String(food.zinc))
        _seleniumText = State(initialValue: String(food.selenium))
        _copperText = State(initialValue: String(food.copper))
        _manganeseText = State(initialValue: String(food.manganese))
        _selectedTypeIndex = State(initialValue: food.type)
    }
    @State private var foodNameCHN: String
    @State private var calories: Float = 0.0
    @State private var carbohydrate: Float = 0.0
    @State private var fat: Float = 0.0
    @State private var protein: Float = 0.0
    @State private var sodium: Float = 0.0
    @State private var cholesterol: Float = 0.0
    @State private var dietaryFiber: Float = 0.0
    @State private var vitaminA: Float = 0.0
    @State private var vitaminE: Float = 0.0
    @State private var vitaminB1: Float = 0.0
    @State private var vitaminB2: Float = 0.0
    @State private var vitaminC: Float = 0.0
    @State private var carotene: Float = 0.0
    @State private var niacin: Float = 0.0
    @State private var phosphorus: Float = 0.0
    @State private var potassium: Float = 0.0
    @State private var magnesium: Float = 0.0
    @State private var calcium: Float = 0.0
    @State private var iron: Float = 0.0
    @State private var zinc: Float = 0.0
    @State private var selenium: Float = 0.0
    @State private var copper: Float = 0.0
    @State private var manganese: Float = 0.0
    @State private var type: Int = 0
    
    @State var caloriesText: String
    @State var carbohydrateText: String
    @State var fatText: String
    @State var proteinText: String
    @State var sodiumText: String
    @State var cholesterolText: String
    @State var dietaryFiberText: String
    @State var vitaminAText: String
    @State var vitaminEText: String
    @State var vitaminB1Text: String
    @State var vitaminB2Text: String
    @State var vitaminCText: String
    @State var caroteneText: String
    @State var niacinText: String
    @State var phosphorusText: String
    @State var potassiumText: String
    @State var magnesiumText: String
    @State var calciumText: String
    @State var ironText: String
    @State var zincText: String
    @State var seleniumText: String
    @State var copperText: String
    @State var manganeseText: String
    
    @State var selectedTypeIndex: Int
    private var typeOptions = ["🍗Meat", "🍚Staple", "🍰Desert", "🥤Beverage"]
    
    @ObservedObject var manager = FoodUpdateAPIManager() // Internet communication manager
    
    @State private var buttonClicked: Bool = false
    
    var body: some View {
        if self.manager.authenticated {
            Text("Succeed")
                .overlay(StatusOverlayUpdateFood(manager: self.manager))
        } else {
            ScrollView {
                VStack(alignment: .leading){
                    // Username
                    Text("Food Name CHN")
                    TextField("Enter...", text: $foodNameCHN)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .border(Color.gray)
                        .autocapitalization(.none)
                    
                    VStack(alignment: .leading){
                        VStack(alignment:.leading){
                            // Calories
                            Text("Calories")
                            TextField("Enter...", text: $caloriesText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: caloriesText, perform: { value in
                                    self.calories = Float(caloriesText) ?? 0 // Convert String to Integer
                                })
                            // Carbohydrate
                            Text("Carbohydrate")
                            TextField("Enter...", text: $carbohydrateText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: carbohydrateText, perform: { value in
                                    self.carbohydrate = Float(carbohydrateText) ?? 0 // Convert String to Integer
                                })
                            
                            Text("Fat")
                            TextField("Enter...", text: $fatText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: fatText, perform: { value in
                                    self.fat = Float(fatText) ?? 0 // Convert String to Integer
                                })
                            
                            Text("Protein")
                            TextField("Enter...", text: $proteinText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: proteinText, perform: { value in
                                    self.protein = Float(proteinText) ?? 0 // Convert String to Integer
                                })
                            
                            Text("Sodium")
                            TextField("Enter...", text: $sodiumText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: sodiumText, perform: { value in
                                    self.sodium = Float(sodiumText) ?? 0 // Convert String to Integer
                                })
                        }
                        Text("Niacin")
                        TextField("Enter...", text: $niacinText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .border(Color.gray)
                            .autocapitalization(.none)
                            .keyboardType(.numberPad) // Only allows using number pad to input value
                            .onChange(of: niacinText, perform: { value in
                                self.niacin = Float(niacinText) ?? 0 // Convert String to Integer
                            })
                        
                    }
                    VStack(alignment:.leading){
                        VStack(alignment:.leading){
                            Text("Cholesterol")
                            TextField("Enter...", text: $cholesterolText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: cholesterolText, perform: { value in
                                    self.cholesterol = Float(cholesterolText) ?? 0 // Convert String to Integer
                                })
                            
                            Text("Dietary Fiber")
                            TextField("Enter...", text: $dietaryFiberText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: dietaryFiberText, perform: { value in
                                    self.dietaryFiber = Float(dietaryFiberText) ?? 0 // Convert String to Integer
                                })
                            
                            Text("VitaminA")
                            TextField("Enter...", text: $vitaminAText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: vitaminAText, perform: { value in
                                    self.vitaminA = Float(vitaminAText) ?? 0 // Convert String to Integer
                                })
                            
                            Text("Carotene")
                            TextField("Enter...", text: $caroteneText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: caroteneText, perform: { value in
                                    self.carotene = Float(caroteneText) ?? 0 // Convert String to Integer
                                })
                        }
                        VStack(alignment:.leading){
                            
                            Text("vitaminE")
                            TextField("Enter...", text: $vitaminEText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: vitaminEText, perform: { value in
                                    self.vitaminE = Float(vitaminEText) ?? 0 // Convert String to Integer
                                })
                            
                            Text("vitaminB1")
                            TextField("Enter...", text: $vitaminB1Text)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: vitaminB1Text, perform: { value in
                                    self.vitaminB1 = Float(vitaminB1Text) ?? 0 // Convert String to Integer
                                })
                            
                            Text("vitaminB2")
                            TextField("Enter...", text: $vitaminB2Text)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: vitaminB2Text, perform: { value in
                                    self.vitaminB2 = Float(vitaminB2Text) ?? 0 // Convert String to Integer
                                })
                            
                            Text("vitaminC")
                            TextField("Enter...", text: $vitaminCText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: vitaminCText, perform: { value in
                                    self.vitaminC = Float(vitaminCText) ?? 0 // Convert String to Integer
                                })
                        }
                        VStack(alignment:.leading){
                            Text("Niacin")
                            TextField("Enter...", text: $niacinText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: niacinText, perform: { value in
                                    self.niacin = Float(niacinText) ?? 0 // Convert String to Integer
                                })
                            
                            Text("Phosphorus")
                            TextField("Enter...", text: $phosphorusText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: phosphorusText, perform: { value in
                                    self.phosphorus = Float(phosphorusText) ?? 0 // Convert String to Integer
                                })
                            
                            Text("Magnesium")
                            TextField("Enter...", text: $magnesiumText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: magnesiumText, perform: { value in
                                    self.magnesium = Float(magnesiumText) ?? 0 // Convert String to Integer
                                })
                            
                            Text("Calcium")
                            TextField("Enter...", text: $calciumText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: calciumText, perform: { value in
                                    self.calcium = Float(calciumText) ?? 0 // Convert String to Integer
                                })
                        }
                        VStack(alignment:.leading){
                            Text("Iron")
                            TextField("Enter...", text: $ironText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: ironText, perform: { value in
                                    self.iron = Float(ironText) ?? 0 // Convert String to Integer
                                })
                            
                            Text("Zinc")
                            TextField("Enter...", text: $zincText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: zincText, perform: { value in
                                    self.zinc = Float(zincText) ?? 0 // Convert String to Integer
                                })
                            
                            Text("Selenium")
                            TextField("Enter...", text: $seleniumText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: seleniumText, perform: { value in
                                    self.selenium = Float(seleniumText) ?? 0 // Convert String to Integer
                                })
                            
                            Text("Copper")
                            TextField("Enter...", text: $copperText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: copperText, perform: { value in
                                    self.copper = Float(copperText) ?? 0 // Convert String to Integer
                                })
                            
                            Text("Manganese")
                            TextField("Enter...", text: $manganeseText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color.gray)
                                .autocapitalization(.none)
                                .keyboardType(.numberPad) // Only allows using number pad to input value
                                .onChange(of: manganeseText, perform: { value in
                                    self.manganese = Float(manganeseText) ?? 0 // Convert String to Integer
                                })
                        }
                        Text("Type")
                        Picker("Type", selection: $selectedTypeIndex) {
                            ForEach(0..<typeOptions.count) {
                                Text(self.typeOptions[$0])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .onChange(of: selectedTypeIndex, perform: { value in
                            if selectedTypeIndex == 0{
                                self.type = 0
                            } else if selectedTypeIndex == 1 {
                                self.type = 1
                            } else if selectedTypeIndex == 2 {
                                self.type = 2
                            } else if selectedTypeIndex == 3 {
                                self.type = 3
                            }
                        })
                    }
                    
                    //Button
                    Button(action:{
                        self.manager.state = .loading
                        self.buttonClicked = true
                        self.manager.postAuth(food: UpdateFood(foodID: self.foodID, updatePara: Food(foodNameCHN: self.foodNameCHN, id: self.foodID, calories: self.calories, carbohydrate: self.carbohydrate, fat: self.fat, protein: self.protein, cholesterol: self.cholesterol, sodium: self.sodium, dietaryFiber: self.dietaryFiber, vitaminA: self.vitaminA, carotene: self.carotene, vitaminE: self.vitaminE, vitaminB1: self.vitaminB1, vitaminB2: self.vitaminB2, vitaminC: self.vitaminC, niacin: self.niacin, phosphorus: self.phosphorus, potassium: self.potassium, magnesium: self.magnesium, calcium: self.calcium, iron: self.iron, zinc: self.zinc, selenium: self.selenium, copper: self.copper, manganese: self.manganese, imageID: -1, type: self.type).description))
                    }){
                        HStack{
                            Spacer()
                            ZStack{
                                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                                    .accentColor(basicColors.healthyColor) // Only showing green when all contents are filled
                                Text("Submit")
                                    .foregroundColor(basicColors.textColor)
                            }
                            .frame(width: 100.0, height: 40.0)
                            Spacer()
                        }
                    }
                    .disabled(self.foodNameCHN.isEmpty || self.caloriesText.isEmpty || self.carbohydrateText.isEmpty || self.fatText.isEmpty || self.proteinText.isEmpty || self.sodiumText.isEmpty || self.niacinText.isEmpty || self.cholesterolText.isEmpty || self.dietaryFiberText.isEmpty || self.vitaminAText.isEmpty || self.caroteneText.isEmpty || self.vitaminEText.isEmpty || self.vitaminB1Text.isEmpty || self.vitaminB2Text.isEmpty || self.vitaminCText.isEmpty || self.niacinText.isEmpty || self.phosphorusText.isEmpty || self.magnesiumText.isEmpty || self.calciumText.isEmpty || self.ironText.isEmpty || self.zincText.isEmpty || self.seleniumText.isEmpty || self.copperText.isEmpty || self.manganeseText.isEmpty || self.buttonClicked == true)
                    
                }
            }
            .padding(.horizontal)
        }
    }
}


struct FoodUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        FoodUpdateView(food:referenceFoods.chickenBreast)
    }
}
