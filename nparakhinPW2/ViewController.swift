//
//  ViewController.swift
//  nparakhinPW2
//
//  Created by Nik on 11.10.2022.
//

import UIKit

extension UIView {
    public var viewWidth: CGFloat {
        return self.frame.size.width
    }
    
    public var viewHeight: CGFloat {
        return self.frame.size.height
    }

    @discardableResult
    func pinLeft(to superview: UIView, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(
            equalTo: superview.leadingAnchor,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func pinRight(to superview: UIView, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = trailingAnchor.constraint(
            equalTo: superview.trailingAnchor,
            constant: CGFloat(const * -1)
        )
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func pinTop(to superview: UIView, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = topAnchor.constraint(
            equalTo: superview.topAnchor,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func pinTop(to side: NSLayoutYAxisAnchor, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = topAnchor.constraint(
            equalTo: side,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func pinBottom(to superview: UIView, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(
            equalTo: superview.bottomAnchor,
            constant: CGFloat(const * -1)
        )
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func pinCenterX(to superview: UIView, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerXAnchor.constraint(
            equalTo: superview.centerXAnchor,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func pinCenterY(to superview: UIView, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerYAnchor.constraint(
            equalTo: superview.centerYAnchor,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        return constraint
    }

    @discardableResult
    func setHeight(_ const: Int) -> NSLayoutConstraint {
        let constraint = heightAnchor.constraint(equalToConstant: CGFloat(const))
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func setWidth(_ const: Int) -> NSLayoutConstraint {
        let constraint = widthAnchor.constraint(equalToConstant: CGFloat(const))
        constraint.isActive = true
        return constraint
    }

    func pinCenter(to superview: UIView) {
        pinCenterX(to: superview)
        pinCenterY(to: superview)
    }
}



final class ViewController: UIViewController {
    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    private let commentView = UIView()
    private let incrementButton = UIButton()
    
    private var value: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func updateUI() {
        UIView.transition(
            with: self.view,
            duration: 0.5,
            options: .transitionCrossDissolve,
            animations: {
                self.valueLabel.text = "\(self.value)"
                self.incrementButton.layer.shadowOffset = CGSize(width: 1, height: 2)
                self.incrementButton.layer.shadowOpacity = 0.5
                self.updateCommentLabel(value: self.value)
                }
            )
        UIView.transition(
            with: self.view,
            duration: 0.5,
            options: .transitionCrossDissolve,
            animations: {
                self.incrementButton.layer.shadowOffset = CGSize(width: 0.25, height:0.5)
                    self.incrementButton.layer.shadowOpacity = 0.25})
    }
    
    private func setupIncrementButton() {
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 10
        incrementButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        incrementButton.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        incrementButton.layer.shadowOffset = CGSize(width: 0.25, height: 0.5)
        incrementButton.layer.shadowOpacity = 0.25
        self.view.addSubview(incrementButton)
        incrementButton.setHeight(Int(self.view.viewHeight / 20))
        incrementButton.pinTop(to: self.view.centerYAnchor)
        incrementButton.pinLeft(to: self.view, Int(self.view.viewWidth / 10))
        incrementButton.pinRight(to: self.view, Int(self.view.viewWidth / 10))
        incrementButton.addTarget(self, action: #selector(incrementButtonPressed), for: .touchUpInside)
    }

    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        
        self.view.addSubview(valueLabel)
                valueLabel.setHeight(Int(self.view.viewHeight / 20))
                valueLabel.pinBottom(to: self.view,
                                     Int(self.view.viewHeight / 2 + incrementButton.viewHeight + 10))
                valueLabel.pinCenter(to: self.view)
    }
    
    private func setupView(){
        view.backgroundColor = .systemGray6
        
        setupIncrementButton()
        setupValueLabel()
        setupCommentView()
    }
    
    @objc
    private func incrementButtonPressed() {
        value += 1
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        self.updateUI()
    }
    
    private func setupCommentView() {
        let commentView = UIView()
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 10
        
        view.addSubview(commentView)
        commentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        commentView.setHeight(Int(self.view.viewHeight / 30))
        commentView.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        commentView.pinLeft(to: self.view, Int(self.view.viewWidth / 10))
        commentView.pinRight(to: self.view, Int(self.view.viewWidth / 10))
        commentLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        commentLabel.textColor = .systemGray
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        commentView.addSubview(commentLabel)
        commentLabel.pinTop(to: commentView, 5)
        commentLabel.pinLeft(to: commentView, 5)
        commentLabel.pinRight(to: commentView, 5)
        commentLabel.pinBottom(to: commentView, 5)
    }
    
    func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commentLabel.text = "1"
        case 10...20:
            commentLabel.text = "2"
        case 20...30:
            commentLabel.text = "3"
        case 30...40:
            commentLabel.text = "4"
        case 40...50:
            commentLabel.text = "! ! ! ! ! ! ! ! ! "
        case 50...60:
            commentLabel.text = "big boy"
        case 60...70:
            commentLabel.text = "70 70 70 moreeeee"
        case 70...80:
            commentLabel.text = "⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ ⭐ "
        case 80...90:
            commentLabel.text = "80+\n go higher!"
        case 90...100:
            commentLabel.text = "100!! to the moon!!"
        default:
            break
        }
    }
    
    private func makeMenuButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }
    
    private func setupMenuButtons() {
        let colorsButton = makeMenuButton(title: "🎨")
        let notesButton = makeMenuButton(title: "✏")
        let newsButton = makeMenuButton(title: "📰")

        let buttonsSV = UIStackView(arrangedSubviews: [colorsButton, notesButton, newsButton])
        buttonsSV.spacing = 12
        buttonsSV.axis = .horizontal
        buttonsSV.distribution = .fillEqually
        self.view.addSubview(buttonsSV)
        buttonsSV.pinLeft(to: self.view, Int(self.view.viewWidth / 10))
        buttonsSV.pinRight(to: self.view, Int(self.view.viewWidth / 10))
        buttonsSV.pinBottom(to: self.view, Int(self.view.viewHeight / 10))
    }
}
