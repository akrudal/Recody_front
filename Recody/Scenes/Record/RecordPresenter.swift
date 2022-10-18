//
//  RecordPresenter.swift
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

protocol RecordPresentationLogic {
  func presentSomething(response: Record.API.Response)
}

class RecordPresenter: RecordPresentationLogic {
  weak var viewController: RecordDisplayLogic?

  // MARK: Do something

  func presentSomething(response: Record.API.Response) {
    let viewModel = Record.API.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}