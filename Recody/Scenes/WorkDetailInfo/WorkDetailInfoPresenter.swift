//
//  WorkDetailInfoPresenter.swift
//  Recody
//
//  Created by 마경미 on 2022/08/23.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol WorkDetailInfoPresentationLogic {
  func presentSomething(response: WorkDetailInfo.Something.Response)
}

class WorkDetailInfoPresenter: WorkDetailInfoPresentationLogic {
  weak var viewController: WorkDetailInfoDisplayLogic?

  // MARK: Do something

  func presentSomething(response: WorkDetailInfo.Something.Response) {
    let viewModel = WorkDetailInfo.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
