//
//  ModalViewController.swift
//  TodoRx
//
//  Created by 권승용 on 2023/03/20.
//

import UIKit
import RxSwift
import RxCocoa

class ModalViewController: UIViewController {
    // MARK: - Properties
    let disposeBag = DisposeBag()
    let viewModel = TodoViewModel.shared
    
    // MARK: - UI Components
    let todoTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .asciiCapable
        textField.placeholder = "ToDo를 입력하세요"
        textField.borderStyle = .line
        return textField
    }()
    
    let addTodoButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        return button
    }()
    
    lazy var textFieldAndButtonStackVeiw: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20.0
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.addArrangedSubview(todoTextField)
        stack.addArrangedSubview(addTodoButton)
        return stack
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        bindUIWithRx()
    }
    
    func setupLayout() {
        view.addSubview(textFieldAndButtonStackVeiw)
        
        textFieldAndButtonStackVeiw.translatesAutoresizingMaskIntoConstraints = false
        textFieldAndButtonStackVeiw.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textFieldAndButtonStackVeiw.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        textFieldAndButtonStackVeiw.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
    }
    
    func bindUIWithRx() {
        
        // 텍스트필드의 텍스트 구독,
        todoTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .bind(to: viewModel.todoTextObservable)
            .disposed(by: disposeBag)

        // 버튼 탭 구독
        addTodoButton.rx.tap
            .bind {
                self.viewModel.addTodo()
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}


// MARK: - 프리뷰 기능
#if DEBUG
import SwiftUI
struct ModalViewControllerRepresentable: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    @available(iOS 13.0, *)
    func makeUIViewController(context: Context) -> some UIViewController {
        ModalViewController()
    }
}

struct ModalViewController_Previews: PreviewProvider {
    static var previews: some View {
        ModalViewControllerRepresentable()
    }
}
#endif

