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
                        text: qsTr("For a developer, nothing is worste than having a user getting an unexpected bug/crash that can't be reproduce on another phone. Connecting the phone to Momentics would really help in those cases, as the console log would show us more details on what's happening.\n\nHere comes ConsoleDebug, it's an app that will print all the console logs ( 'qDebug()' AND 'console.log()' ) on the user's screen, so he can copy and share it with the dev. This app is only intended to be use as a debug helper.")
                        multiline: true
                        textStyle.base: SystemDefaults.TextStyles.TitleText
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
