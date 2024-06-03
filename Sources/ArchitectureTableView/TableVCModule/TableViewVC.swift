//
//  TableViewVC.swift
//
//
//  Created by user on 31.05.2024.
//

import UIKit
import Architecture
import Components
import DesignSystem
import ImagesService

public final class TableViewVC: UIViewController, ViewProtocol {
    
    // MARK: - Public properties
    
    public struct ViewProperties {
        let screenTitle: String?
        let addTableView: Closure<UIView>
        let confirmButtonTap: ClosureEmpty
        let confirmButtonTitle: String?
        var confirmButtonState: ButtonViewStyle.State
        
        public init(
            screenTitle: String?,
            addTableView: @escaping Closure<UIView>,
            confirmButtonTap: @escaping ClosureEmpty,
            confirmButtonTitle: String?,
            confirmButtonState: ButtonViewStyle.State
        ) {
            self.screenTitle = screenTitle
            self.addTableView = addTableView
            self.confirmButtonTap = confirmButtonTap
            self.confirmButtonTitle = confirmButtonTitle
            self.confirmButtonState = confirmButtonState
        }
    }
    
    public var viewProperties: ViewProperties
    
    // MARK: - Private properties
    
    private var buttonViewProperties: ButtonView.ViewProperties?
    private let confirmButton = ButtonView(
        frame: .init(
            x: 0,
            y: (UIScreen.main.bounds.height - 100),
            width: (UIScreen.main.bounds.width - 32),
            height: 50
        )
    )
    private var style = ButtonViewStyle(
        context: .action(.contained),
        state: .default,
        size: .sizeM
    )
    
    // MARK: - Life cycle
    
    public init(viewProperties: ViewProperties) {
        self.viewProperties = viewProperties
        
        super.init(nibName: nil, bundle: nil)
        
        if let buttonTitle = viewProperties.confirmButtonTitle {
            buttonViewProperties = ButtonView.ViewProperties(
                attributedText: buttonTitle.attributed
            )
            buttonViewProperties?.onTap = { [weak self] in
                self?.view.endEditing(true)
                self?.viewProperties.confirmButtonTap()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        viewProperties.addTableView(view)
        setupBottomButton()
        confirmButtonState()
        setupNavBar()
    }
    
    // MARK: - Public methods
    
    public func update(with viewProperties: ViewProperties) {
        self.viewProperties = viewProperties
        confirmButtonState()
    }

    // MARK: - Private methods
    
    private func setupNavBar() {
        let barItem = UIBarButtonItem(
            image: .ic24ChevronLeft.withTintColor(.contentPrimary),
            style: .plain,
            target: self,
            action: #selector(backTapped))
        navigationItem.leftBarButtonItem = barItem
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.backBarButtonItem = .init(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backButtonTitle = nil
        
        title = viewProperties.screenTitle
    }
    
    private func confirmButtonState() {
        guard var buttonViewProperties = buttonViewProperties else { return }
        
        style.state = viewProperties.confirmButtonState
        style.update(viewProperties: &buttonViewProperties)
    }
    
    private func setupBottomButton() {
        guard var buttonViewProperties = buttonViewProperties else { return }
        
        view.addSubview(confirmButton)
        confirmButton.center.x = view.center.x
        
        style.state = .default
        style.update(viewProperties: &buttonViewProperties)
        confirmButton.update(with: buttonViewProperties)
    }
    
    @objc private func backTapped() {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
}
