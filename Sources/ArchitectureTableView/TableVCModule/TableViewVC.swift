import UIKit
import SnapKit
import Architecture
import ImagesService
import Colors
import Components
import Services
import Combine

public final class TableViewVC: UIViewController, ViewProtocol {
    
    // MARK: - Public properties
    
    public struct ViewProperties {
        public var navigationBarViewProperties: NavigationBar.ViewProperties?
        public var tableView: UIView
        public var confirmButtonView: UIView?
        public var activityIndicator: UIView?
        public var backgroundColor: UIColor
        public var confirmButtonInsets: UIEdgeInsets
        public var tableViewInsets: UIEdgeInsets
        public var confirmButtonAnimationDuration: CGFloat
        public var lifeCycle: LifeCycle?
        
        public init(
            navigationBarViewProperties: NavigationBar.ViewProperties? = nil,
            tableView: UIView,
            confirmButtonView: UIView? = nil,
            activityIndicator: UIView? = nil,
            backgroundColor: UIColor = .white,
            confirmButtonInsets: UIEdgeInsets = .init(top: .zero, left: 16, bottom: 50, right: 16),
            tableViewInsets: UIEdgeInsets = .init(top: .zero, left: .zero, bottom: .zero, right: .zero),
            confirmButtonAnimationDuration: CGFloat = 1,
            lifeCycle: LifeCycle? = nil
        ) {
            self.navigationBarViewProperties = navigationBarViewProperties
            self.tableView = tableView
            self.confirmButtonView = confirmButtonView
            self.activityIndicator = activityIndicator
            self.backgroundColor = backgroundColor
            self.confirmButtonInsets = confirmButtonInsets
            self.tableViewInsets = tableViewInsets
            self.confirmButtonAnimationDuration = confirmButtonAnimationDuration
            self.lifeCycle = lifeCycle
        }
    }
    
    // MARK: - Private properties
    
    public var viewProperties: ViewProperties
    
    // MARK: - Private properties
    
    private let keyboardService: KeyboardService
    private var anyCancellable: Set<AnyCancellable> = []
    
    // MARK: - Life cycle
    
    public init(
        keyboardService: KeyboardService = .init(),
        viewProperties: ViewProperties
    ) {
        self.viewProperties = viewProperties
        self.keyboardService = keyboardService
        
        super.init(nibName: nil, bundle: nil)
        
        addTableView(viewProperties: viewProperties)
        addConfirmButtonView(viewProperties: viewProperties)
        addActivityIndicator(viewProperties: viewProperties)
        setupNavigationBar(viewProperties: viewProperties)
        
        viewProperties.lifeCycle?.onInit?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = viewProperties.backgroundColor
        viewProperties.lifeCycle?.onViewDidLoad?()
        subscribeToKeyboard()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar(viewProperties: viewProperties)
        viewProperties.lifeCycle?.onViewWillAppear?()
    }
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
        viewProperties.lifeCycle?.onViewIsAppearing?()
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        viewProperties.lifeCycle?.onViewWillLayoutSubViews?()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        viewProperties.lifeCycle?.onViewDidLayoutSubviews?()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewProperties.lifeCycle?.onViewDidAppear?()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        viewProperties.lifeCycle?.onViewWillDisappear?()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        viewProperties.lifeCycle?.onViewDidDisappear?()
    }
    
    deinit {
        viewProperties.lifeCycle?.onDeinit?()
    }
    
    // MARK: - Public methods
    
    public func update(with viewProperties: ViewProperties) {
        updateTableViewIfNeeded(newViewProperties: viewProperties)
        updateConfirmButtonIfNeeded(newViewProperties: viewProperties)
        updateActivityIndicatorIfNeeded(newViewProperties: viewProperties)
        updateNavigationBarIfNeeded(newViewProperties: viewProperties)
        
        view.backgroundColor = viewProperties.backgroundColor
        self.viewProperties = viewProperties
    }
    
    // MARK: - Private methods
    
    private func setupNavigationBar(viewProperties: ViewProperties) {
        guard let navigationBarViewProperties = viewProperties.navigationBarViewProperties
        else { return }
        
        let navigationBar = navigationController as? NavigationBar
        navigationBar?.update(with: navigationBarViewProperties)
    }
    
    private func updateNavigationBarIfNeeded(newViewProperties: ViewProperties) {
        guard newViewProperties.navigationBarViewProperties != viewProperties.navigationBarViewProperties,
              let navigationBarViewProperties = newViewProperties.navigationBarViewProperties
        else { return }
        
        let navigationBar = navigationController as? NavigationBar
        navigationBar?.update(with: navigationBarViewProperties)
    }
    
    private func addTableView(viewProperties: ViewProperties) {
        addTableViewAndMakeConstraints(
            with: viewProperties.tableView,
            and: viewProperties.tableViewInsets
        )
    }
    
    private func updateTableViewIfNeeded(newViewProperties: ViewProperties) {
        guard newViewProperties.tableView != viewProperties.tableView else { return }
        
        viewProperties.tableView.snp.removeConstraints()
        viewProperties.tableView.removeFromSuperview()
        
        addTableViewAndMakeConstraints(
            with: newViewProperties.tableView,
            and: newViewProperties.tableViewInsets
        )
    }
    
    private func addTableViewAndMakeConstraints(with tableView: UIView, and insets: UIEdgeInsets) {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(insets)
        }
    }
    
    private func addConfirmButtonView(viewProperties: ViewProperties) {
        guard let confirmButtonView = viewProperties.confirmButtonView else { return }
        
        addConfirmButtonAndMakeConstraints(
            with: confirmButtonView,
            and: viewProperties.confirmButtonInsets
        )
        remakeTableViewConstraintsForButton(
            with: viewProperties.tableView,
            button: confirmButtonView,
            insets: viewProperties.tableViewInsets
        )
    }
    
    private func updateConfirmButtonIfNeeded(newViewProperties: ViewProperties) {
        guard newViewProperties.confirmButtonView != viewProperties.confirmButtonView,
              let confirmButtonView = newViewProperties.confirmButtonView
        else { return }
        
        viewProperties.confirmButtonView?.snp.removeConstraints()
        viewProperties.confirmButtonView?.removeFromSuperview()
        
        addConfirmButtonAndMakeConstraints(
            with: confirmButtonView,
            and: viewProperties.confirmButtonInsets
        )
        remakeTableViewConstraintsForButton(
            with: viewProperties.tableView,
            button: confirmButtonView,
            insets: viewProperties.tableViewInsets
        )
    }
    
    private func addConfirmButtonAndMakeConstraints(with button: UIView, and insets: UIEdgeInsets) {
        view.addSubview(button)
        button.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(insets)
        }
    }
    
    private func updateConfirmButtonConstraints(with button: UIView, and insets: UIEdgeInsets) {
        button.snp.updateConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(insets)
        }
    }
    
    private func remakeTableViewConstraintsForButton(
        with tableView: UIView,
        button: UIView,
        insets: UIEdgeInsets
    ) {
        tableView.snp.remakeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(insets)
            $0.bottom.equalTo(button.snp.top).inset(-16)
        }
    }
    
    private func addActivityIndicator(viewProperties: ViewProperties) {
        guard let loader = viewProperties.activityIndicator else { return }
        
        addLoaderAndMakeConstraints(with: loader)
    }
    
    private func updateActivityIndicatorIfNeeded(newViewProperties: ViewProperties) {
        guard newViewProperties.activityIndicator != viewProperties.activityIndicator,
              let loader =  newViewProperties.activityIndicator
        else { return }
        
        viewProperties.activityIndicator?.snp.removeConstraints()
        viewProperties.activityIndicator?.removeFromSuperview()
        
        addLoaderAndMakeConstraints(with: loader)
    }
    
    private func addLoaderAndMakeConstraints(with loader: UIView) {
        view.addSubview(loader)
        loader.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func subscribeToKeyboard() {
        keyboardService.showKeyboard.sink(
            receiveValue: { [weak self] keyboardHeight in
                guard let self, let confirmButton = viewProperties.confirmButtonView
                else { return }
                
                let insets = UIEdgeInsets(
                    top: viewProperties.confirmButtonInsets.top,
                    left: viewProperties.confirmButtonInsets.left,
                    bottom: viewProperties.confirmButtonInsets.bottom + keyboardHeight,
                    right: viewProperties.confirmButtonInsets.right
                )
                UIView.animate(withDuration: viewProperties.confirmButtonAnimationDuration) {
                    self.updateConfirmButtonConstraints(
                        with: confirmButton,
                        and: insets
                    )
                    confirmButton.superview?.layoutIfNeeded()
                }
            }
        ).store(in: &anyCancellable)
        
        keyboardService.dismissKeyboard.sink(
            receiveValue: { [weak self] _ in
                guard let self, let confirmButton = viewProperties.confirmButtonView 
                else { return }
                
                UIView.animate(withDuration: viewProperties.confirmButtonAnimationDuration) {
                    self.updateConfirmButtonConstraints(
                        with: confirmButton,
                        and: self.viewProperties.confirmButtonInsets
                    )
                    confirmButton.superview?.layoutIfNeeded()
                }
            }
        ).store(in: &anyCancellable)
    }
}
