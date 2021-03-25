//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by George Cremer on 25/03/2021.
//

import Foundation



//enum ErrorMessage: String {
//    case invalidUserName = "This username created an invalid requst please try again."
//    case unableToComplete = "Unable to complete your request please check your internet connection"
//    case invalidResponse = "Invalid response from the server. Please try again."
//    case invalidData = "The data recieved form the server was invalid. Please try again."
//}


enum GFError: String, Error {
    case invalidUserName = "This username created an invalid requst please try again."
    case unableToComplete = "Unable to complete your request please check your internet connection"
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data recieved form the server was invalid. Please try again."
}
