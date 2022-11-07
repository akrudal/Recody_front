//
//  ModifyProfileRouter.swift
//  Recody
//
//  Created by 마경미 on 29.10.22.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol ModifyProfileRoutingLogic {
    // func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ModifyProfileDataPassing {
    var dataStore: ModifyProfileDataStore? { get }
}

class ModifyProfileRouter: NSObject, ModifyProfileRoutingLogic, ModifyProfileDataPassing {
    weak var viewController: ModifyProfileViewController?
    var dataStore: ModifyProfileDataStore?
}