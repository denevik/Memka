//		
//  Memka
//	

import Nuke
import PinLayout
import Tempura
import UIKit

/// The root view of the `MemeDetailsView` section.
class MemeDetailsView: UIView, ViewControllerModellableView {

    // MARK: - UI Elements

    /// Topic title before the `memeImageView`.
    private let titleLabel = UILabel()

    /// Meme image.
    private let memeImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
        style()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	// MARK: - SSUL
	
	func setup() {
        addSubview(titleLabel)
        addSubview(memeImageView)
    }
    
	func style() {
        MemeDetailsView.styleView(self)
    }
    
	func update(oldModel: MemeDetailsViewModel?) {
        guard let model = model else {
            return
        }

        MemeDetailsView.styleTitleLabel(titleLabel, text: model.meme.title)
        MemeDetailsView.styleMemesImageView(memeImageView, imageURL: model.meme.imageURL)
    }
        
	override func layoutSubviews() {
		super.layoutSubviews()

        titleLabel.pin
            .top(pin.safeArea)
            .marginTop(2%)
            .hCenter()
            .width(100%)
            .sizeToFit(.width)

        memeImageView.pin
            .below(of: titleLabel, aligned: .center)
            .marginTop(2%)
            .width(90%)
            .height(80%)
	}
}

// MARK: Styling Functions

private extension MemeDetailsView {
    static func styleView(_ view: UIView) {
        view.backgroundColor = .white
    }

    static func styleTitleLabel(_ label: UILabel, text: String?) {
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
    }

    static func styleMemesImageView(_ memesImageView: UIImageView, imageURL: URL?) {
        if let imageURL = imageURL {
            Nuke.loadImage(with: imageURL, into: memesImageView)
        }
        memesImageView.contentMode = .scaleAspectFit
    }
}
