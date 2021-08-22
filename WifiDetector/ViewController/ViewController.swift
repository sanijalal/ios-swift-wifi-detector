//
//  ViewController.swift
//  WifiDetector
//
//  Created by Sani on 21/08/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var permissionButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    lazy var deniedView: UIView? = {
        return Bundle.main.loadNibNamed("DeniedView", owner: self, options: nil)?[0] as? UIView
    } ()
    
    lazy var authorisedNoSSIDView: UIView? = {
        return Bundle.main.loadNibNamed("AuthorisedNoSSID", owner: self, options: nil)?[0] as? UIView
    } ()
    
    lazy var authorisedWithSSIDView: AuthorisedWithSSIDView? = {
        return Bundle.main.loadNibNamed("AuthorisedWithSSIDView", owner: self, options: nil)?[0] as? AuthorisedWithSSIDView
    } ()
    
    lazy var unknownPermissionView: UIView? = {
        return Bundle.main.loadNibNamed("UnknownPermissionView", owner: self, options: nil)?[0] as? UIView
    } ()
    
    var presenter: ViewControllerPresenter!
    
    required init?(coder: NSCoder) {
        self.presenter = ViewControllerPresenter(wifiInfoProvider: WifiInfoProvider())
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func updateView() {
        
        self.containerView.subviews.forEach { view in
            view.removeFromSuperview()
        }
        
        var viewToAdd: UIView? = nil
        var showButton = true
        switch presenter.currentPermissionState {
        case .authorised:
            if presenter.hasRequestedSSID {
                if let authorisedView = authorisedWithSSIDView {
                    viewToAdd = authorisedView
                    authorisedView.updateSSID(ssidName: presenter.ssidName)
                }
            } else {
                if let authorisedView = authorisedNoSSIDView {
                    viewToAdd = authorisedView
                }
            }
        case .notAuthorised:
            if let deniedView = deniedView {
                viewToAdd = deniedView
            }
            showButton = false
        case .unknown:
            if let unknownView = unknownPermissionView {
                viewToAdd = unknownView
            }
        }
        
        if let viewToAdd = viewToAdd {
            viewToAdd.frame = CGRect(x: 0, y: 0, width: containerView.bounds.width, height: containerView.bounds.height)
            containerView.addSubview(viewToAdd)
        }

        self.permissionButton.isHidden = !showButton
        self.permissionButton.setTitle(presenter.buttonText, for: .normal)
    }

    @IBAction func permissionButtonPressed(_ sender: Any) {
        self.presenter.bottomButtonPressed { [weak self] in
            guard let self = self else { return }
            self.updateView()
        }
    }
}

