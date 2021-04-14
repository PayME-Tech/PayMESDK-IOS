//
//  Method.swift
//  PayMESDK
//
//  Created by HuyOpen on 10/28/20.
//

import UIKit

class Method: UITableViewCell {

   struct Constants {
        static let contentInsets = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)
        static let avatarSize = CGSize(width: 36.0, height: 36.0)
    }

    // MARK: - Properties

    var presentable = MethodInfo(methodId: nil, type: "", title: "", label: "", amount: 0, fee: 0, minFee: 0, dataWallet: nil, dataLinked: nil, active: false)
    // MARK: - Views

    
    let containerView : UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 15.0
        containerView.layer.borderColor = UIColor(203,203,203).cgColor
        containerView.layer.borderWidth = 0.5
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    let bankNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(9,9,9)
        label.font = label.font.withSize(16)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let bankContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(98,98,98)
        label.backgroundColor = .clear
        label.font = label.font.withSize(12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageContainer : UIView = {
        let imageContainer = UIView()
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.layer.borderWidth = 1
        imageContainer.layer.borderColor = UIColor(203,203,203).cgColor
        imageContainer.layer.cornerRadius = 5
        return imageContainer
    }()

    let walletMethodImage: UIImageView = {
        var bgImage = UIImageView()
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        return bgImage
    }()
    
    let checkedImage : UIImageView = {
        let bundle = Bundle(for: Method.self)
        let bundleURL = bundle.resourceURL?.appendingPathComponent("PayMESDK.bundle")
        let resourceBundle = Bundle(url: bundleURL!)
        let image = UIImage(named: "nextIcoCopy3", in: resourceBundle, compatibleWith: nil)
        var bgImage = UIImageView(image: image)
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        return bgImage
    }()
    
    let uncheckImage : UIImageView = {
        let bundle = Bundle(for: Method.self)
        let bundleURL = bundle.resourceURL?.appendingPathComponent("PayMESDK.bundle")
        let resourceBundle = Bundle(url: bundleURL!)
        let image = UIImage(named: "uncheck", in: resourceBundle, compatibleWith: nil)
        var bgImage = UIImageView(image: image)
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        return bgImage
    }()
    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .white
        isAccessibilityElement = true

        let backgroundView = UIView()
        backgroundView.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.8235294118, blue: 0.8274509804, alpha: 1).withAlphaComponent(0.11)
        selectedBackgroundView = backgroundView
        contentView.addSubview(containerView)
        containerView.addSubview(walletMethodImage)
        containerView.addSubview(bankNameLabel)
        containerView.addSubview(checkedImage)
        containerView.addSubview(bankContentLabel)
        containerView.addSubview(imageContainer)
        // contentView.addSubview(walletMethodImage)
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout

    func setupConstraints() {
        
        
        containerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        containerView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
        imageContainer.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageContainer.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        imageContainer.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        walletMethodImage.heightAnchor.constraint(equalToConstant: 16).isActive = true
        walletMethodImage.widthAnchor.constraint(equalToConstant: 16).isActive = true
        walletMethodImage.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor).isActive = true
        walletMethodImage.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor).isActive = true
        
        checkedImage.heightAnchor.constraint(equalToConstant: 12).isActive = true
        checkedImage.widthAnchor.constraint(equalToConstant: 6).isActive = true
        checkedImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16).isActive = true
        checkedImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        bankNameLabel.leadingAnchor.constraint(equalTo: walletMethodImage.trailingAnchor, constant: 10).isActive = true
        bankNameLabel.trailingAnchor.constraint(equalTo: bankContentLabel.leadingAnchor, constant: -5).isActive = true
        bankNameLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        
        bankContentLabel.leadingAnchor.constraint(equalTo: bankNameLabel.trailingAnchor, constant: 5).isActive = true
        bankContentLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        

        
        /*[a, b, c, d].forEach {
            $0.priority = UILayoutPriority(UILayoutPriority.required.rawValue - 1)
            $0.isActive = true
        }
         */
        /*
        let avatarWidthConstriant = avatarView.widthAnchor.constraint(equalToConstant: Constants.avatarSize.width)
        let avatarHeightConstraint = avatarView.heightAnchor.constraint(equalToConstant: Constants.avatarSize.height)

        [avatarWidthConstriant, avatarHeightConstraint].forEach {
            $0.priority = UILayoutPriority(UILayoutPriority.required.rawValue - 1)
            $0.isActive = true
        }
         */
        
    }

    // MARK: - Highlight

    /**
     On cell selection or highlight, iOS makes all vies have a clear background
     the below methods address the issue for the avatar view
     */

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - View Configuration

    func configure(with presentable: MethodInfo) {
        self.presentable = presentable
        if (presentable.type == "WALLET") {
            bankNameLabel.text = "Số dư ví"
            bankContentLabel.text = "(\(formatMoney(input: presentable.amount!))đ)"
        } else {
            bankNameLabel.text = presentable.title
            bankContentLabel.text = presentable.label
        }
        if (presentable.type.isEqual("WALLET")) {
            let bundle = Bundle(for: Method.self)
            let bundleURL = bundle.resourceURL?.appendingPathComponent("PayMESDK.bundle")
            let resourceBundle = Bundle(url: bundleURL!)
            let image = UIImage(named: "iconWallet", in: resourceBundle, compatibleWith: nil)
            self.walletMethodImage.image = image
        }
        else if (presentable.type.isEqual("LINKED")) {
            if (presentable.dataLinked != nil) {
                let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/vn-mecorp-payme-wallet.appspot.com/o/image_bank%2Fimage_method%2Fmethod\(presentable.dataLinked!.swiftCode!).png?alt=media&token=28cdb30e-fa9b-430c-8c0e-5369f500612e")
                DispatchQueue.global().async {
                    if let sureURL = url as URL? {
                        let data = try? Data(contentsOf: sureURL) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                        DispatchQueue.main.async {
                            self.walletMethodImage.image = UIImage(data: data!)
                        }
                    }
                }
                
            }
        }
        else if (presentable.type.isEqual("BANK_CARD")) {
            let bundle = Bundle(for: Method.self)
            let bundleURL = bundle.resourceURL?.appendingPathComponent("PayMESDK.bundle")
            let resourceBundle = Bundle(url: bundleURL!)
            let image = UIImage(named: "fill1", in: resourceBundle, compatibleWith: nil)
            self.walletMethodImage.image = image
        } else {
            let bundle = Bundle(for: Method.self)
            let bundleURL = bundle.resourceURL?.appendingPathComponent("PayMESDK.bundle")
            let resourceBundle = Bundle(url: bundleURL!)
            let image = UIImage(named: "iconWallet", in: resourceBundle, compatibleWith: nil)
            self.walletMethodImage.image = image
        }
        
        /*else {
            bankNameLabel.text = presentable.bankCode!
            bankContentLabel.text = presentable.cardNumber!
        }
         */
    }

}

