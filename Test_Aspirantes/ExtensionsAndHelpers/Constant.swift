//
//  Constant.swift
//  Test_Aspirantes
//
//  Created by Josafat Martínez  on 05/01/21.
//

import Foundation

enum EndPointUrl: String {
    case authorization = "https://stage-api.cinepolis.com/v2/oauth/token"
    case profile = "https://stage-api.cinepolis.com/v1/members/profile?country_code=MX"
    case movies = "https://stage-api.cinepolis.com/v2/movies?country_code=MX&cinemas=61"
}

public let apiKey: String = "stage_4V78Fwm_android"
