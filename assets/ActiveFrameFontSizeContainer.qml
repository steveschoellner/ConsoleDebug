import bb.cascades 1.3

Container {
    horizontalAlignment: HorizontalAlignment.Center
    DropDown {
        title: qsTr("Active Frame Font Size")
        Option {                        
            id: option3
            text: qsTr("3")
            value: 3
        }
        Option {                        
            id: option4
            text: qsTr("4")
            value: 4
        }
        Option {
            id: option5
            text: qsTr("5")
            value: 5
        }
        Option {
            id: option6
            text: qsTr("6")
            value: 6
        }
        Option {
            id: option7
            text: qsTr("7")
            value: 7
        }
        Option {                        
            id: option8
            text: qsTr("8")
            value: 8
        }
        onSelectedOptionChanged: {
            _app.activeFrameFontSize = selectedOption.value
        }
        onCreationCompleted: {
            switch (_app.activeFrameFontSize) {
                case 3: 
                    setSelectedOption(option3)
                    break
                case 4: 
                    setSelectedOption(option4)
                    break
                case 5: 
                    setSelectedOption(option5)
                    break
                case 6: 
                    setSelectedOption(option6)
                    break
                case 7: 
                    setSelectedOption(option7)
                    break
                case 8: 
                    setSelectedOption(option8)
                    break
                default:
                    setSelectedOption(option5)
                    break
            }
        }
    }
}
