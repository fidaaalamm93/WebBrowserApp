//
//  WebViewModel.swift
//  WebBrowserApp
//
//  Created by Fidaa Alamm on 02/06/2023.
//

import Foundation
class WebViewModel {

    /// Input struct can hold all the properities that the view controller will give it's values to the view model.
    struct Input {
    }

    /// Output struct can hold all the properities that viewModel will provide them to the view controller.
    struct Output {
        let initURL: String
    }

    var input: Input
    var output: Output

    init () {
        input = Input()

        output = Output(initURL: "https://tamatemplus.com")
    }
}
