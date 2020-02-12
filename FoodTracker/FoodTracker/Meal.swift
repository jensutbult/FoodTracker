//
//  Meal.swift
//  FoodTracker
//
//  Created by Jens Utbult on 2020-02-12.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import UIKit

struct Meal: Codable {

    init?(name: String, image: UIImage?, rating: Int) {
        guard !name.isEmpty else { return nil }
        guard rating >= 0 && rating < 5 else { return nil }
        self.name = name
        self.imageData = image?.pngData()
        self.rating = rating
    }

    let name: String
    let imageData: Data?

    var image: UIImage? {
        guard let data = imageData else { return nil }
        return UIImage(data: data)
    }

    let rating: Int
}
