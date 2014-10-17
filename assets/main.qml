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

Page {
    property int appFontSize: _app.appFontSize

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
                title: qsTr("Reload DropDown")
                ActionBar.placement: ActionBarPlacement.OnBar
                imageSource: "asset:///images/ic_reload.png"
                onTriggered: _app.fillDropDown()
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
        }
    ]
    ScrollView {
        Container {
            topPadding: ui.du(3)
            leftPadding: topPadding
            rightPadding: topPadding
            bottomPadding: topPadding
            DropDown {
                objectName: "appsDropDown"
                title: "App to show console"
                onSelectedOptionChanged: {
                    _app.setText("")
                    if (selectedOption != 0)
                        _settings.setValue("appsDropDownOptionText", selectedOption.text)
                }
            }
            TextArea {
                text: _app.text
                editable: false
                textStyle.fontSize: FontSize.PointValue
                textStyle.fontSizeValue: appFontSize
            }
        }
    }
}
