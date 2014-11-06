import bb.cascades 1.3

ActionItem {
    title: qsTr("Do Stuff")
    imageSource: "asset:///images/ic_code_inspector.png"
    ActionBar.placement: ActionBarPlacement.Signature
    onTriggered: {
        systemPrompt.show()
    }
}
