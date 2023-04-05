//
//  TodoCell.swift
//  TodoRx
//
//  Created by 권승용 on 2023/03/19.
//

import UIKit
import RxCocoa
import RxSwift

class TodoCell: UITableViewCell {
    
    static let identifier = "TodoCell"
    
    var isCompleted = false
    
    let completeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "circle"), for: .normal)
        return button
    }()
    
    let whatToDo: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "이런 느낌 입니다"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        self.contentView.addSubview(completeButton)
        self.addSubview(whatToDo)
        
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        completeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        completeButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        completeButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        completeButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        whatToDo.translatesAutoresizingMaskIntoConstraints = false
        whatToDo.leadingAnchor.constraint(equalTo: completeButton.trailingAnchor).isActive = true
        whatToDo.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}


// MARK: - 프리뷰 기능
#if DEBUG
import SwiftUI
struct TodoCellRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UITableViewCell {
        TodoCell()
    }
    
    func updateUIView(_ uiView: UITableViewCell, context: Context) {
    }
    
    typealias UIViewType = UITableViewCell
}

struct TodoCell_Previews: PreviewProvider {
    static var previews: some View {
        TodoCellRepresentable()
    }
}
#endif
