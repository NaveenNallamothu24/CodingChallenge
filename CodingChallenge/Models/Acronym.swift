//
//  Acronym.swift
//  CodingChallenge
//
//  Created by Naveen Nallamothu on 07/21/22.
//

import Foundation

// MARK: - AcronymElement
struct AcronymResult: Codable {
    let sf: String?
    let lfs: [Acronym]?
}

// MARK: - LF
struct Acronym: Codable {
    let lf: String?
    let freq, since: Int?
    let vars: [Acronym]?
}

typealias Acronyms = [AcronymResult]
