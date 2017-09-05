//
//  AppError.swift
//  LocalWikipedia
//
//  Created by Vasileios Loumanis on 05/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

struct AppError: Error {
    
    static let locationNotAvailable = AppError(localizedTitle: "Location Not Available", localizedDescription: "Your current location is not available", code: 0)
    static let locationNotAuthorised = AppError(localizedTitle: "Location Not Available", localizedDescription: "Please enable location services for this app", code: 0)
    static let urlMissing = AppError(localizedTitle: "URL Error", localizedDescription: "URL Error", code: 0)

    var localizedTitle: String
    var localizedDescription: String
    var code: Int
    
    init(localizedTitle: String?, localizedDescription: String, code: Int) {
        self.localizedTitle = localizedTitle ?? "Error"
        self.localizedDescription = localizedDescription
        self.code = code
    }
}

