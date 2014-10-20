import bb.cascades 1.3
import bb.system 1.2

Sheet {
    id: aboutSheet
    Page {
        titleBar: TitleBar {
            title: qsTr("About")
            acceptAction: ActionItem {
                title: qsTr("Ok")
                onTriggered: {
                    aboutSheet.close()
                }
            }
        }
        ScrollView {
            Container {
                topPadding: ui.du(3)
                leftPadding: topPadding
                rightPadding: topPadding
                bottomPadding: topPadding
                layout: DockLayout {}
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                Container {
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    Label {
                        horizontalAlignment: HorizontalAlignment.Center
                        text: qsTr("By adding a few lines of code (less than 20), any existing app can show the console log usually displayed in Momentics on ConsoleDebug screen, so you have a console available even when you're on the go. Perfect for those bugs/crash that are sporadic and doesn't always come up when you're connected to Momentics. Another use case would be if a user is experiencing a bug/crash that you can't reproduce, you tell that user to download ConsoleDebug and to send you the console logs when the bug happens.\n\nMore info on how to implement in your own project on GitHub : https://github.com/RodgerLeblanc/ConsoleDebug")
                        multiline: true
                        textStyle.base: SystemDefaults.TextStyles.TitleText
                        content.flags: TextContentFlag.ActiveText
                    }
                    Label {
                        horizontalAlignment: HorizontalAlignment.Center
                        text: Application.applicationName + " " + Application.applicationVersion
                        textStyle.base: SystemDefaults.TextStyles.BigText
                    }
                    Label {
                        horizontalAlignment: HorizontalAlignment.Center
                        text: "<html><a href=\"http://bit.ly/1w7LUfm\">" + qsTr("Donate") + "</a></html>"
                        textStyle.base: SystemDefaults.TextStyles.BodyText
                    }
                    Label {
                        horizontalAlignment: HorizontalAlignment.Center
                        text: "<html><a href=\"http://icons8.com/\">" + qsTr("App Icon is from icons8.com") + "</a></html>"
                        textStyle.base: SystemDefaults.TextStyles.SubtitleText
                    }
                }
            }
        }
    }
}
