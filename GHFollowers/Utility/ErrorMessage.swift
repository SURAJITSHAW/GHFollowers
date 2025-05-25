//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Surajit Shaw on 25/05/25.
//

import Foundation

enum ErrorMessage: String {
    case invalidUsername      = "The username provided is invalid. Please check and try again."
    case unableToComplete     = "Unable to complete your request. Please check your internet connection."
    case invalidResponse      = "Invalid response from the server. Please try again later."
    case invalidData          = "The data received from the server is corrupted or in an unexpected format."
}
