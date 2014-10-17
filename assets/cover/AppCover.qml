/* Copyright (c) 2013 BlackBerry Limited.
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

MultiCover {
    id: multiCover
    property string consoleText: _app.text
    property int activeFrameFontSize: _app.activeFrameFontSize
    property string theme: Application.themeSupport.theme.colorTheme.style == VisualStyle.Bright ? "Bright" : "Dark"

    SceneCover {
        id: bigCover
        MultiCover.level: CoverDetailLevel.High
        content: Container {
            background: theme == "Bright" ? Color.White : Color.Black
            Label {
                text: consoleText
                textStyle.color: theme == "Bright" ? Color.Black : Color.White
                multiline: true
                textStyle.fontSize: FontSize.PointValue
                textStyle.fontSizeValue: activeFrameFontSize
            }
        }
    } // sceneCover HIGH
    
    SceneCover {
        id: smallCover
        MultiCover.level: CoverDetailLevel.Medium
        content: Container {
            background: theme == "Bright" ? Color.White : Color.Black
            Label {
                text: consoleText
                textStyle.color: theme == "Bright" ? Color.Black : Color.White
                multiline: true
                textStyle.fontSize: FontSize.PointValue
                textStyle.fontSizeValue: activeFrameFontSize
            }
        }
    } // sceneCover MEDIUM
} //  multiCover
