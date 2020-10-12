//
//  PostTableViewCell.swift
//  TMFeeds
//
//  Created by Savi on 10/11/20.
//

import UIKit
import SDWebImage

@available(iOS 13.0, *)
class FeedTableViewCell: UITableViewCell {
    
    public static let identifier = "feed"
    private var imageHeight = CGFloat(0)
    
    struct Padding {
        static let padding32: CGFloat = 32
        static let padding16: CGFloat = 16
        static let padding8: CGFloat = 8
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let commentsCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "placeholder")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let commentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "bubble.left.fill")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let scoreImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "hand.thumbsup.fill")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        layer.masksToBounds = false
        contentView.backgroundColor = .white
        addSubview(titleLabel)
        addSubview(postImage)
        addSubview(scoreLabel)
        addSubview(commentsCountLabel)
        addSubview(commentImage)
        addSubview(scoreImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: .none)
    }
    
    private func loadImage(urlString: String) {
        postImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "placeholder.png"))
    }
    
    func configure(with model: FeedCellViewModel?) {
        if let model = model {
            imageHeight = model.height
            titleLabel.text =  model.title
            commentsCountLabel.text = "\(model.commentsCount)"
            scoreLabel.text = "\(model.score)"
            loadImage(urlString: model.imageURLString)
        } else {
            titleLabel.text = nil
            postImage.image = UIImage(named: "placeholder")
            scoreLabel.text = nil
            commentsCountLabel.text = nil
        }
        postImage.layer.cornerRadius = 10
        setupConstraints()
    }
    
    func setupConstraints() {
        
        func setPostImageConstraints() {
            postImage.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: Padding.padding8).isActive = true
            postImage.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: -Padding.padding8).isActive = true
            postImage.topAnchor.constraint(equalTo: topAnchor,
                                           constant: Padding.padding16).isActive = true
            postImage.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        }
        
        func setTitleConstraints() {
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                constant: Padding.padding16).isActive = true
            titleLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor,
                                            constant: Padding.padding16).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                 constant: -Padding.padding16).isActive = true
        }
        
        func setCommentConstraints() {
            commentImage.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                  constant: Padding.padding32).isActive = true
            commentImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                              constant: Padding.padding8).isActive = true
        }
        
        func setCommentsCountConstraints() {
            commentsCountLabel.leadingAnchor.constraint(equalTo: commentImage.trailingAnchor).isActive = true
            commentsCountLabel.centerYAnchor.constraint(equalTo: commentImage.centerYAnchor).isActive = true
            commentsCountLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        }
        
        func setScoreImageConstraints() {
            scoreImage.centerYAnchor.constraint(equalTo: commentImage.centerYAnchor).isActive = true
            scoreImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Padding.padding8).isActive = true
            scoreImage.trailingAnchor.constraint(equalTo: scoreLabel.leadingAnchor).isActive = true
        }
        
        func setScoreLabelImageConstraints() {
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Padding.padding32).isActive = true
            scoreLabel.centerYAnchor.constraint(equalTo: scoreImage.centerYAnchor).isActive = true
        }
        
        setPostImageConstraints()
        setTitleConstraints()
        setCommentConstraints()
        setCommentsCountConstraints()
        setScoreImageConstraints()
        setScoreLabelImageConstraints()
    }
}
