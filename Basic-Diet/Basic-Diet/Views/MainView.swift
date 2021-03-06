//
//  MainView.swift
//  Basic-Diet
//
//  Created by 黄子航 on 2021/3/6.
//

import SwiftUI

struct MainView: View {
    @AppStorage(UserDefaultKeys.System.isLogin) var showFirstView: Bool = false
    var body: some View {
        if !showFirstView {
            FirstView()
        } else {
            SearchBar()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
