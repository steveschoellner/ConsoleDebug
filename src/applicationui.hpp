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

#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_

#include "Console.h"
#include "Settings.h"
#include "Commons.h"

#include <QObject>
#include <bb/cascades/DropDown>

namespace bb
{
    namespace cascades
    {
        class LocaleHandler;
    }
}

class QTranslator;

/*!
 * @brief Application UI object
 *
 * Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class ApplicationUI : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString text READ getText WRITE setText NOTIFY textChanged);
    Q_PROPERTY(int appFontSize READ getAppFontSize WRITE setAppFontSize NOTIFY appFontSizeChanged);
    Q_PROPERTY(int activeFrameFontSize READ getActiveFrameFontSize WRITE setActiveFrameFontSize NOTIFY activeFrameFontSizeChanged);
public:
    ApplicationUI();
    virtual ~ApplicationUI() {}

    Q_INVOKABLE void fillDropDown();
    Q_INVOKABLE void setText(QString newValue);

private slots:
    void onSystemLanguageChanged();
    void onReceivedData(QString _data);

private:
    QString getText() { return m_text; }
    int getAppFontSize() { return m_appFontSize; }
    void setAppFontSize(int appFontSize);
    int getActiveFrameFontSize() { return m_activeFrameFontSize; }
    void setActiveFrameFontSize(int activeFrameFontSize);

    QTranslator* m_pTranslator;
    bb::cascades::LocaleHandler* m_pLocaleHandler;

    Console* console;
    Settings* settings;

    bb::cascades::DropDown* appsDropDown;

    QString m_text;
    int m_appFontSize;
    int m_activeFrameFontSize;

signals:
    void textChanged();
    void appFontSizeChanged();
    void activeFrameFontSizeChanged();
};

#endif /* ApplicationUI_HPP_ */
