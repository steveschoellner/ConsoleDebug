/*
 * Copyright (c) 2011-2014 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import bb.cascades 1.3
import bb.system 1.2

Page {
    property int appFontSize: _app.appFontSize
    property string appExplanation: "This app shows console logs of a connected app. To connect to ConsoleDebug, you need to add about 20 lines of code to your app. You can have more info on how to set your app here : https://github.com/RodgerLeblanc/ConsoleDebug\n\nOnce done, your console logs will appear here. ConsoleDebug is a new app and no published app can connect to it actually. You can build this test app if you want to try it : https://github.com/RodgerLeblanc/ConsoleClient"
    property bool appSelected
/*
    onAppSelectedChanged: {
        if (appSelected) {
            removeAction(doStuffDisabled)
            addAction(doStuffEnabled)            
        }
        else {
            removeAction(doStuffEnabled)
            addAction(doStuffDisabled)
        }
    }   
*/         
    Menu.definition: MenuDefinition {        
        settingsAction: [
            SettingsActionItem {
                ActionBar.placement: ActionBarPlacement.OnBar
                onTriggered: {
                    settingsSheet.open()
                }
            }
        ]

        actions: [
            ActionItem {
                title: qsTr("About")
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "asset:///images/ic_info.png"
                onTriggered: {
                    aboutSheet.open()
                }
            },
            ActionItem {
                title: qsTr("More apps")
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "asset:///images/ic_share.png"
                onTriggered: invoke.trigger("bb.action.OPEN");
            },
            ActionItem {
                id: reloadAction
                title: qsTr("Reload DropDown")
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "asset:///images/ic_reload.png"
                onTriggered: _app.fillDropDown()
                enabled: appsDropDown.visible
            },
            ActionItem {
                id: emailAction
                title: qsTr("Email log")
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "asset:///images/ic_email_dk.png"
                enabled: (appsDropDown.count() > 0)
                onTriggered: {
                    var subject = "-- ConsoleDebug -- " + appsDropDown.selectedOption.text
                    var body = textArea.text
                    _app.sendEmail(subject, body)
                }
            }
        ]      
    } // end of MenuDefinition
    
    attachedObjects: [
        AboutSheet {
            id: aboutSheet
        },
        SettingsSheet {
            id: settingsSheet
        },
        ComponentDefinition {
            id: menu
        },
        Invocation {
            id: invoke
            query {
                invokeTargetId: "sys.appworld"
                uri: "appworld://vendor/70290"
            }
        },
        ActionItem {
            id: doStuffEnabled
        },
        SystemPrompt {
            id: systemPrompt
            title: "For debugging purpose only"
            body: "Enter a command line to interact with " + appsDropDown.selectedOption.text + " app"
            onFinished: {
                _console.sendMessage(inputFieldTextEntry())
            }
        }
    ]
    actions: [
        ActionItem {
            id: doStuffDisabled
            title: qsTr("Do Stuff")
            imageSource: "asset:///images/ic_code_inspector.png"
//            enabled: false
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                systemPrompt.show()
            }
        }
    ]

    Container {
        Container {
            topPadding: ui.du(3)
            leftPadding: topPadding
            rightPadding: topPadding
            bottomPadding: topPadding
            DropDown {
                objectName: "appsDropDown"
                id: appsDropDown
                title: "App to show console"
                visible: (count() > 0)
                onOptionAdded: visible = true
                onSelectedOptionChanged: {
                    _app.setText(" ")
                    if (selectedOption != 0) {
                        appSelected = true
                        emailAction.enabled = true
                        _settings.setValue("appsDropDownOptionText", selectedOption.text)                        
                    }
                    else {
                        appSelected = false
                        emailAction.enabled = false
                    }
                }
            }
        }        
        ScrollView {
            Container {
                TextArea {
                    id: textArea
                    text: (_app.text == "") ? appExplanation : _app.text
                    editable: false
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: appFontSize
                }
            }
        }
    }
}
