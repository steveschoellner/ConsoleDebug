import bb.cascades 1.2

ActionItem {
    title: qsTr("Do Stuff")
    imageSource: "asset:///images/ic_code_inspector.png"
    ActionBar.placement: ActionBarPlacement.OnBar
    onTriggered: {
        systemPrompt.show()
    }
}
