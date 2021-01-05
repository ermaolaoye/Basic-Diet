//
//  NutritionProportionBar.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2020/12/31.
//

import SwiftUI

struct NutritionProportionBar: View {
    var nutritionName: String
    var nutritionVal: Float
    var nutritionUnit: String
    var body: some View {
        VStack {
            HStack {
                Text(nutritionName)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(basicColors.textColor)
                    
                Spacer()
                Text(String(nutritionVal) + nutritionUnit)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(basicColors.textColor)
            }
            ProgressBar(value: Float(getProportion(nutrition: nutritionVal, unit: nutritionUnit))).frame(height: 15)
        }
    }
}

struct NutritionProportionBar_Previews: PreviewProvider {
    static var previews: some View {
        NutritionProportionBar(nutritionName: "Protein", nutritionVal: referenceFoods.chickenBreast.protein!, nutritionUnit: referenceFoods.chickenBreast.unitMap!["Protein"]!)
    }
}

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
