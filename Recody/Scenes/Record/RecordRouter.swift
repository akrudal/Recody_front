//
//  RecordRouter.swift
//  Recody
//
//  Created by 마경미 on 2022/08/30.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol RecordRoutingLogic {
  // func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol RecordDataPassing {
  var dataStore: RecordDataStore? { get }
}

class RecordRouter: NSObject, RecordRoutingLogic, RecordDataPassing {
  weak var viewController: RecordViewController?
  var dataStore: RecordDataStore?
}
