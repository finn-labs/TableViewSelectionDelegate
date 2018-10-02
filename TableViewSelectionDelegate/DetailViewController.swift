import UIKit

protocol DetailViewControllerDelegate: class {
    func detailViewController(_ detailViewController: DetailViewController, didSelectTakeMeBackButtonForOption option: Option?)
}

class DetailViewController: UIViewController {
    // MARK: - Private properties
    weak var delegate: DetailViewControllerDelegate?

    var option: Option?

    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private var button: UIButton?

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.alwaysBounceVertical = true
        return scroll
    }()

    // MARK: - Setup
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private functions
private extension DetailViewController {

    func createButton() -> UIButton? {
        if let button = button {
            button.removeFromSuperview()
        }

        let newButton = UIButton(type: .system)
        newButton.setTitle("Take me back", for: .normal)
        newButton.addTarget(self, action: #selector(handleButtonPressed), for: .touchUpInside)
        newButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(newButton)

        let constraints = [
            newButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .mediumLargeSpacing),
            newButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.mediumLargeSpacing),
            newButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: .largeSpacing),
            scrollView.bottomAnchor.constraint(equalTo: newButton.bottomAnchor, constant: .mediumLargeSpacing)
        ]
        NSLayoutConstraint.activate(constraints)

        return button
    }

    func setup() {
        title = option?.title
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(textLabel)
        textLabel.text = "dwqd wqd jiwqjdo iwq udihwuq dqw djwquh dwqoi dqwb dojqwhd bijqwhdwqijd qw djqw duw"
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor),

            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .mediumLargeSpacing),
            textLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: .mediumLargeSpacing),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.mediumLargeSpacing),

            scrollView.bottomAnchor.constraint(greaterThanOrEqualTo: textLabel.bottomAnchor, constant: .mediumLargeSpacing)
            ])

        button = createButton()
    }

    @objc func handleButtonPressed() {
        delegate?.detailViewController(self, didSelectTakeMeBackButtonForOption: self.option)
    }

}
