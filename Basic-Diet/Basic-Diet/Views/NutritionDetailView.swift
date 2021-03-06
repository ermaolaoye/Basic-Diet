//
//  NutritionDetailView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/3/6.
//

import SwiftUI

struct NutritionDetailView: View {
    var food: Food
    var body: some View {
        List{
            NutritionProportionBar(nutritionName: "Protein", nutritionVal: food.protein, nutritionUnit: referenceFoods.unitMap["protein"]!)
            NutritionProportionBar(nutritionName: "Carbohydrate", nutritionVal: food.carbohydrate, nutritionUnit: referenceFoods.unitMap["carbohydrate"]!)
            NutritionProportionBar(nutritionName: "Fat", nutritionVal: food.fat, nutritionUnit: referenceFoods.unitMap["fat"]!)
            NutritionProportionBar(nutritionName: "Cholesterol", nutritionVal: food.cholesterol, nutritionUnit: referenceFoods.unitMap["cholesterol"]!)
            NutritionProportionBar(nutritionName: "Sodium", nutritionVal: food.sodium, nutritionUnit: referenceFoods.unitMap["sodium"]!)
            NutritionProportionBar(nutritionName: "Dietary Fiber", nutritionVal: food.dietaryFiber, nutritionUnit: referenceFoods.unitMap["dietaryFiber"]!)
            VStack {
                NutritionProportionBar(nutritionName: "vitaminA", nutritionVal: food.vitaminA, nutritionUnit: referenceFoods.unitMap["vitaminA"]!)
                NutritionProportionBar(nutritionName: "vitaminE", nutritionVal: food.vitaminE, nutritionUnit: referenceFoods.unitMap["vitaminE"]!)
                NutritionProportionBar(nutritionName: "vitaminB1", nutritionVal: food.vitaminB1, nutritionUnit: referenceFoods.unitMap["vitaminB1"]!)
                NutritionProportionBar(nutritionName: "vitaminB2", nutritionVal: food.vitaminB2, nutritionUnit: referenceFoods.unitMap["vitaminB2"]!)
                NutritionProportionBar(nutritionName: "vitaminC", nutritionVal: food.vitaminC, nutritionUnit: referenceFoods.unitMap["vitaminC"]!)
                NutritionProportionBar(nutritionName: "Carotene", nutritionVal: food.carotene, nutritionUnit: referenceFoods.unitMap["carotene"]!)
            }
            VStack{
                NutritionProportionBar(nutritionName: "Phosphorus", nutritionVal: food.phosphorus, nutritionUnit: referenceFoods.unitMap["phosphorus"]!)
                NutritionProportionBar(nutritionName: "Potassium", nutritionVal: food.potassium, nutritionUnit: referenceFoods.unitMap["potassium"]!)
                NutritionProportionBar(nutritionName: "Magnesium", nutritionVal: food.magnesium, nutritionUnit: referenceFoods.unitMap["magnesium"]!)
                NutritionProportionBar(nutritionName: "Calcium", nutritionVal: food.calcium, nutritionUnit: referenceFoods.unitMap["calcium"]!)
                NutritionProportionBar(nutritionName: "Niacin", nutritionVal: food.niacin, nutritionUnit: referenceFoods.unitMap["niacin"]!)
                NutritionProportionBar(nutritionName: "Iron", nutritionVal: food.iron, nutritionUnit: referenceFoods.unitMap["iron"]!)
                NutritionProportionBar(nutritionName: "Zinc", nutritionVal: food.zinc, nutritionUnit: referenceFoods.unitMap["zinc"]!)
                NutritionProportionBar(nutritionName: "Selenium", nutritionVal: food.selenium, nutritionUnit: referenceFoods.unitMap["selenium"]!)
                NutritionProportionBar(nutritionName: "Copper", nutritionVal: food.copper, nutritionUnit: referenceFoods.unitMap["copper"]!)
                NutritionProportionBar(nutritionName: "Manganese", nutritionVal: food.manganese, nutritionUnit: referenceFoods.unitMap["manganese"]!)
            }
        }
    }
}

struct NutritionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NutritionDetailView(food: referenceFoods.chickenBreast)
    }
}
