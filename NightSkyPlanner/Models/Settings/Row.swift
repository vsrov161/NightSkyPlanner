//
//  Row.swift
//  NightSkyPlanner
//
//  Created by Vic on 22.01.2026.
//

import Foundation

enum RowStyle {
    case disclosure // arrow, transition to submenu
    case switchToggle // switch
    case button // eg. clear cache
}

struct Row {
    let title: String
    let style: RowStyle
    var value: Any? // bool, str, int etc.
    
//    let action: (() -> Void)?
}
