//
//  TechkyProfile.swift
//  HourTech
//
//  Created by Maggie on 2019-02-27.
//  Copyright © 2019 Maggie VU. All rights reserved.
//

import Foundation

struct TechkyProfile {
    let firstName: String
    let lastName: String
    let title: String
    let description: String

    static func createProfile() -> [TechkyProfile] {
        return [TechkyProfile(firstName: "Maggie",
                              lastName: "Vu",
                              title: "Full-stack Developer",
                              description: "Highly motivated bla bla bla bla"),
                TechkyProfile(firstName: "Diego",
                              lastName: "Rodrigues De Oliveira",
                              title: "Front-end Developer",
                              description: "Skillful, hard-working. 2-year student at Langara. Available for design, presentation, logo design..."),
                TechkyProfile(firstName: "Ta",
                              lastName: "Hansombob",
                              title: "Back-end Developer",
                              description: "Skillful, hard-working. 2-year student at Langara. Available for design, presentation, logo design..."),
                TechkyProfile(firstName: "Andra",
                              lastName: "Iskandar",
                              title: "Quality Assurance Developer",
                              description: "Skillful, hard-working. 2-year student at Langara. Available for design, presentation, logo design..."),
                TechkyProfile(firstName: "Julia",
                              lastName: "Stanovsky",
                              title: "Designer",
                              description: "Skillful, hard-working. 2-year student at Langara. Available for design, presentation, logo design...")
        ]
    }
}

