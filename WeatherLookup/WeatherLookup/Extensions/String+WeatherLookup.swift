//
//  String+WeatherLookup.swift
//  WeatherLookup
//
//  Created by Yogesh Arora on 11/03/22.
//

import Foundation

extension String {
    public var trimmed: String {
      return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
