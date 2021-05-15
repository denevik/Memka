//		
//  Memka
//	

import VerticalCardSwiper
import PinLayout
import Tempura
import Nuke

/// The `UICollectionViewCell` containing information about the meme.
class MemeListCell: CardCell, ModellableView {
    
    // MARK: - Constants
    
    static let identifier = String(describing: MemeListCell.self)
    
    // MARK: - UI Elements
    
    /// Topic title before the `memeImageView`.
    private let titleLabel = UILabel()
    
    /// Meme image.
    private let memeImageView = UIImageView()
    
    /// Loading indicator to show while loading is in progress.
    private let loadingIndicatorView = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SSLU
    
    func setup() {
        addSubview(titleLabel)
        addSubview(memeImageView)
        addSubview(loadingIndicatorView)
    }
    
    func style() {
        MemeListCell.styleView(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.pin
            .top(10)
            .hCenter()
            .width(90%)
            .sizeToFit(.width)
        
        memeImageView.pin
            .below(of: titleLabel)
            .marginTop(10)
            .left(10)
            .right(10)
            .bottom(10)
        
        loadingIndicatorView.pin
            .center()
    }
    
    func update(oldModel: MemeListCellViewModel?) {
        guard let model = model else {
            return
        }
        
        MemeListCell.styleTitleLabel(titleLabel, text: model.meme.title)
        MemeListCell.styleMemesImageView(memeImageView, imageURL: model.meme.previewURL)
        MemeListCell.styleLoadingIndicatorView(loadingIndicatorView, shouldShow: memeImageView.image == nil)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        memeImageView.image = nil
        titleLabel.text = ""
        loadingIndicatorView.stopAnimating()
    }
}

// MARK: Styling Functions

private extension MemeListCell {
    static func styleView(_ view: UIView) {
        view.backgroundColor = .white
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.random.withAlphaComponent(0.3).cgColor,
                           UIColor.random.withAlphaComponent(0.3).cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.size.width, height: view.frame.size.height)
        gradient.cornerRadius = 15
        gradient.borderWidth = 1
        gradient.borderColor = UIColor.white.cgColor

        view.layer.insertSublayer(gradient, at: 0)
//        view.layer.borderWidth = 1
//        view.layer.cornerRadius = 15
//        view.layer.borderColor =
    }
    
    static func styleTitleLabel(_ label: UILabel, text: String?) {
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = text == nil
    }
    
    static func styleMemesImageView(_ memesImageView: UIImageView, imageURL: URL?) {
        if let imageURL = imageURL {
            Nuke.loadImage(with: imageURL, into: memesImageView)
        }
        memesImageView.contentMode = .scaleAspectFit
//        memesImageView.layer.borderWidth = 1
//        memesImageView.layer.borderColor = UIColor.gray.withAlphaComponent(0.7).cgColor
        memesImageView.isHidden = memesImageView.image == nil
    }
    
    static func styleLoadingIndicatorView(_ activityIndicator: UIActivityIndicatorView, shouldShow: Bool) {
        if shouldShow {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

