//
//  CitySearchView.swift
//  WeatherNow
//
//  Created by Arthur Silva on 03/02/20.
//  Copyright © 2020 Arthur Silva. All rights reserved.
//

import SwiftUI

struct CitySearchView: View {
    var weathers: [Weather] = []
    var selectedWeather: Weather? = nil
    @State var searchText: String

    var body: some View {
        VStack {
            HStack {
                TextField("Search_Text_Field_Placeholder", text: $searchText)
                    .padding(.leading)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {}) {
                    Text("Search_Button_Text")
                        .padding(.horizontal)
                }
            }
            List(weathers) { weather in
                Text(String(format: AppContants.cityNameWithCountryTemplate, weather.cityName, weather.cityCountry))
            }
        }
        .padding(.top)
    }
}

#if DEBUG
struct CitySearchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CitySearchView(weathers: [], searchText: "")

            CitySearchView(weathers: testData, searchText: "Rio")
            
            CitySearchView(weathers: [], searchText: "")
                .environment(\.locale, Locale(identifier: "pt-BR"))

            CitySearchView(weathers: testData, searchText: "Rio")
                .environment(\.locale, Locale(identifier: "pt-BR"))
            
            CitySearchView(weathers: [], searchText: "")
                .environment(\.colorScheme, .dark)
        }
    }
}
#endif
