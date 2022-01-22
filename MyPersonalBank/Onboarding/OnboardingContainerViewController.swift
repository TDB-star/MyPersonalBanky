//
//  OnboardingContainerViewController.swift
//  MyPersonalBank
//
//  Created by Tatiana Dmitrieva on 21/01/2022.
//

import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {
    
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    weak var delegate: OnboardingContainerViewControllerDelegate?
    var currentVC: UIViewController {
        didSet {
            guard let index = pages.firstIndex(of: currentVC) else { return }
            nextButton.isHidden = index == pages.count - 1 // hide if on last page
            backButton.isHidden = index == 0
            doneButton.isHidden = !(index == pages.count - 1) // show if on last page
        }
    }
    
    let closeButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    let backButton = UIButton(type: .system)
    let doneButton = UIButton(type: .system)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingViewController(heroImageName: "001-rocket", titleText: "MyPersonalBank is faster, easier to use, and has a brand new look.")
        let page2 = OnboardingViewController(heroImageName: "002-globe", titleText: "Move your money around the world quickley and securely.")
        let page3 = OnboardingViewController(heroImageName: "like", titleText: "Learn more at www.mypersonalbank.com")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
    }
    
    private func setup() {
        view.backgroundColor = .systemPurple
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor)
        ])
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
    }
    
    private func style() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .primaryActionTriggered)
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: [])
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .primaryActionTriggered)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("Back", for: [])
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .primaryActionTriggered)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", for: [])
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .primaryActionTriggered)
        
        view.addSubview(closeButton)
        view.addSubview(nextButton)
        view.addSubview(backButton)
        view.addSubview(doneButton)
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2)
        ])
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: nextButton.bottomAnchor, multiplier: 8)
        ])
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: backButton.bottomAnchor, multiplier: 8)
        ])
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: doneButton.trailingAnchor, multiplier: 2),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: doneButton.bottomAnchor, multiplier: 8)
        ])
    }
}

extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}

// MARK: - Actions

extension OnboardingContainerViewController {
    @objc func closeButtonTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
    }
    
    @objc func doneButtonTapped(_ sender: UIButton) {
        delegate?.didFinishOnboarding()
    }
}
