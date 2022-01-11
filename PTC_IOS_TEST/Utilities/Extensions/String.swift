//
//  String.swift
//  PTC_IOS_TEST
//
//  Created by Mohannad on 1/11/22.
//  Copyright © 2022 Jumia. All rights reserved.
//

extension String {
    var trimmed : String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}
