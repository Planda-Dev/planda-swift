import Macaw

class RunningLevelView: MacawView {
    class MyView: MacawView {

        required init?(coder aDecoder: NSCoder) {
            let text = Text(text: "Hello, World!", place: .move(dx: 145, dy: 100))
            super.init(node: text, coder: aDecoder)
        }

    }
}
