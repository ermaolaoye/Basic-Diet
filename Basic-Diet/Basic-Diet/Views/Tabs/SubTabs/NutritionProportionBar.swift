//
//  NutritionProportionBar.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/31.
//

import SwiftUI

struct NutritionProportionBar: View {
    var nutritionName: String // Name of nutrition
    var nutritionVal: Float // Value of nutrition
    var nutritionUnit: String // Unit of nutrition
    var body: some View {
        VStack {
            HStack {
                Text(nutritionName) // Name of nutrition
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(basicColors.textColor)
                    
                Spacer()
                Text(String(nutritionVal) + nutritionUnit) // Value + Unit
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(basicColors.textColor)
            }
            ProgressBar(value: Float(getProportion(nutrition: nutritionVal, unit: nutritionUnit))).frame(height: 15) // Progress Bar
        }
    }
}

struct NutritionProportionBar_Previews: PreviewProvider {
    static var previews: some View {
        NutritionProportionBar(nutritionName: "Protein", nutritionVal: referenceFoods.chickenBreast.protein, nutritionUnit: referenceFoods.unitMap["protein"]!)
    }
}

// proportion calculateor
func getProportion(nutrition: Float, unit: String) -> CGFloat{
    switch unit{
        case "g":
            return CGFloat(nutrition / 100)
        case "mg":
            return CGFloat(nutrition / 1000 / 100)
        case "mcg":
            return CGFloat(nutrition / 1000000 / 100)
        default:
            return CGFloat()
    }
}
