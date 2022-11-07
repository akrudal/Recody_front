//
//  HomeViewController.swift
//  Recody
//
//  Created by 마경미 on 2022/08/04.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayTestCategory(viewModel: Home.TestCategory.ViewModel)
    func displayTestWork(viewModel: Home.TestWork.ViewModel)
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?

    let works: [Work] = [
        Work(id: "0", name: "Attention", image: "attention"),
        Work(id: "1", name: "1987", image: "1987"),
        Work(id: "2", name: "CallMeByYourName", image: "callMeByYourName"),
        Work(id: "3", name: "her", image: "her"),
        Work(id: "4", name: "Pink Venom", image: "pinkVenom"),
        Work(id: "5", name: "마더", image: "mother"),
        Work(id: "6", name: "블랙 팬서", image: "blackPanther"),
        Work(id: "7", name: "스파이더맨", image: "spiderman"),
        Work(id: "8", name: "After Like", image: "afterLike")
    ]

    let categories: [Category] = [
        Category(name: "책", image: "book"),
        Category(name: "영화", image: "movie"),
        Category(name: "드라마", image: "drama"),
        Category(name: "음악", image: "music"),
        Category(name: "공연", image: "show")
    ]

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        makeCategoryStackView()
    }

    @IBOutlet weak var categoryStackView: UIStackView!
    @IBOutlet weak var workCategoryStackView: UIStackView!

    func makeCategoryStackView() {
        var index = 0
        guard let tempArray = categoryStackView.arrangedSubviews as? [CustomCategory] else { return }
        for value in tempArray {
            value.setData(with: categories[index])
            index += 1
        }
    }

    func displayTestCategory(viewModel: Home.TestCategory.ViewModel) {

    }

    func displayTestWork(viewModel: Home.TestWork.ViewModel) {
        //
    }
}
