//
//  PostTableViewCell.swift
//  Compensate
//
//  Created on 25.5.2020.
//  Copyright © 2020 Compensate. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Dependencies
    var post: Post?
    var isLastPost = false
    
    var openUrlCallback: Closure<String>?
    
    // MARK: - Private properties
    private lazy var containerView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 15
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(linkViewContainer)
        stackView.addArrangedSubview(authorName)
        stackView.addArrangedSubview(bottomStackView)
        
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var selfTextLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Regular", size: 13)
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var linkView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        
        stackView.addArrangedSubview(linkImageView)
        stackView.addArrangedSubview(linkUrl)
        
        linkImageView.translatesAutoresizingMaskIntoConstraints = false
        linkUrl.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy private var linkViewContainer: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        view.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        view.addSubview(linkView)
        
        linkView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            linkView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            linkView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            linkView.topAnchor.constraint(equalTo: view.topAnchor),
            linkView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        return view
    }()
    
    lazy private var linkImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var linkUrl: PaddingLabel = {
        let label = PaddingLabel()
        
        label.textColor = .lightGray
        label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var authorName: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Regular", size: 13)
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var upLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Regular", size: 12)
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var upImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.image = UIImage(named: "up")
        return view
    }()
    
    private lazy var commentImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.image = UIImage(named: "comment")
        return view
    }()
    
    private lazy var timeImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.image = UIImage(named: "time")
        return view
    }()
    
    private lazy var upView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        
        stackView.addArrangedSubview(upImage)
        stackView.addArrangedSubview(upLabel)
        
        upImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            upImage.heightAnchor.constraint(equalToConstant: 20),
            upImage.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        return stackView
    }()
    
    private lazy var commentView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        
        stackView.addArrangedSubview(commentImage)
        stackView.addArrangedSubview(commentLabel)
        
        commentImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            commentImage.heightAnchor.constraint(equalToConstant: 20),
            commentImage.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        return stackView
    }()
    
    private lazy var timeView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        
        stackView.addArrangedSubview(timeImage)
        stackView.addArrangedSubview(timeLabel)
        
        timeImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeImage.heightAnchor.constraint(equalToConstant: 20),
            timeImage.widthAnchor.constraint(equalToConstant: 20)
        ])
        
        return stackView
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        
        stackView.addArrangedSubview(upView)
        stackView.addArrangedSubview(commentView)
        stackView.addArrangedSubview(timeView)
        
        return stackView
    }()
    
    lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
        return view
    }()
    
    // MARK: - Lifecycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        selfTextLabel.removeFromSuperview()
    }
    
    // MARK: - Public methods
    func updateUI() {
        guard let post = post else { return }
        
        titleLabel.text = String(htmlEncodedString: post.content.title)
        
        if post.content.preview?.images.first?.source.url != nil {
            linkImageView.loadImageAsync(with: post.content.preview?.images.first?.source.url)
            linkImageView.isHidden = false
        } else {
            linkImageView.isHidden = true
        }
        
        linkUrl.text = post.content.url
        
        authorName.textColor = post.content.stickied ? UIColor(red: 0, green: 0.808, blue: 0.647, alpha: 1) : .black
        authorName.text = "by \(post.content.author ?? "")"
        
        upLabel.text = "\(post.content.ups)"
        commentLabel.text = "\(post.content.numComments)"
        timeLabel.text = "\(post.content.created.toReadableDateString)"
        
        dividerView.isHidden = isLastPost
        linkViewContainer.isHidden = post.content.stickied
        
        if post.content.stickied {
            selfTextLabel.text = post.content.selftext
            containerView.insertArrangedSubview(selfTextLabel, at: 1)
        }
    }

    // MARK: - Private methods
    private func setup() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(containerView)
        addSubview(dividerView)
        
        setConstraints()
    }
    
    private func setConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            dividerView.heightAnchor.constraint(equalToConstant: 8),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            linkImageView.topAnchor.constraint(equalTo: linkView.topAnchor),
            linkImageView.leadingAnchor.constraint(equalTo: linkView.leadingAnchor),
            linkImageView.trailingAnchor.constraint(equalTo: linkView.trailingAnchor),
            linkImageView.heightAnchor.constraint(equalTo: linkImageView.widthAnchor, multiplier: 9/16)
        ])
        
        NSLayoutConstraint.activate([
            linkUrl.topAnchor.constraint(equalTo: linkImageView.bottomAnchor),
            linkUrl.leadingAnchor.constraint(equalTo: linkView.leadingAnchor),
            linkUrl.trailingAnchor.constraint(equalTo: linkView.trailingAnchor),
            linkUrl.bottomAnchor.constraint(equalTo: linkView.bottomAnchor)
        ])
    }
    
    @objc private func handleTap() {
        guard let post = post else { return }
        openUrlCallback?(post.content.url ?? "")
    }

}
