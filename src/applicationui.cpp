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

#include "applicationui.hpp"

#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/MultiCover>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/LocaleHandler>
#include <bb/cascades/Option>
#include <bb/system/InvokeManager>
#include <bb/system/InvokeRequest>

using namespace bb::cascades;

ApplicationUI::ApplicationUI() :
        QObject(),
        console(new Console()),
        settings(new Settings(this))
{
    // If this directory doesn't exist, create it
    QDir dir;
    if (!dir.exists("./data/ConsoleDebug/"))
        dir.mkpath("./data/ConsoleDebug/");

    setText("");

    connect(console, SIGNAL(receivedData(QString)), this, SLOT(onReceivedData(QString)));

    setAppFontSize(settings->value("appFontSize", DEFAULT_APP_FONT_SIZE).toDouble());
    setActiveFrameFontSize(settings->value("activeFrameFontSize", DEFAULT_ACTIVE_FRAME_FONT_SIZE).toDouble());

    // prepare the localization
    m_pTranslator = new QTranslator(this);
    m_pLocaleHandler = new LocaleHandler(this);

    bool res = QObject::connect(m_pLocaleHandler, SIGNAL(systemLanguageChanged()), this, SLOT(onSystemLanguageChanged()));
    // This is only available in Debug builds
    Q_ASSERT(res);
    // Since the variable is not used in the app, this is added to avoid a
    // compiler warning
    Q_UNUSED(res);

    // initial load
    onSystemLanguageChanged();

    // Create scene document from main.qml asset, the parent is set
    // to ensure the document gets destroyed properly at shut down.
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
    qml->setContextProperty("_app", this);
    qml->setContextProperty("_settings", settings);
    qml->setContextProperty("_console", console);

    // Create root object for the UI
    AbstractPane *root = qml->createRootObject<AbstractPane>();

    // Set created root object as the application scene
    Application::instance()->setScene(root);

    appsDropDown = root->findChild<DropDown*>("appsDropDown");

    fillDropDown();

    QmlDocument *qmlCover = QmlDocument::create("asset:///cover/AppCover.qml").parent(this);
    qmlCover->setContextProperty("_app", this);

    if (!qmlCover->hasErrors()) {
        AbstractCover* cover = qmlCover->createRootObject<MultiCover>();

        Application::instance()->setCover(cover);
    }
}

void ApplicationUI::onSystemLanguageChanged()
{
    QCoreApplication::instance()->removeTranslator(m_pTranslator);
    // Initiate, load and install the application translation files.
    QString locale_string = QLocale().name();
    QString file_name = QString("ConsoleDebug_%1").arg(locale_string);
    if (m_pTranslator->load(file_name, "app/native/qm")) {
        QCoreApplication::instance()->installTranslator(m_pTranslator);
    }
}

void ApplicationUI::onReceivedData(QString _data)
{
    QStringList allData = _data.split("$$");

    if ((!appsDropDown) || (allData.size() < 3))
        return;

    QString appName = allData[0];
    QString command = allData[1].toLower();
    QString data = allData[2];

    bool found = false;
    for (int i = 0; i < appsDropDown->count(); i++)
        if (appsDropDown->at(i)->text() == appName)
            found = true;

    if (appsDropDown->selectedOption() != 0) {
        if (appsDropDown->selectedOption()->text() == allData[0]) {
            setText("<" + QTime::currentTime().toString("hh:mm:ss") + "> " + allData[2] + "\n" + getText());
        }
    }

    if (!found)
        fillDropDown();
}

void ApplicationUI::fillDropDown()
{
    if (!appsDropDown)
        return;

    appsDropDown->removeAll();

    QDir thisDir;
    thisDir.setPath("./data/ConsoleDebug/");

    // Get all the files
    thisDir.setFilter(QDir::Readable | QDir::NoDotAndDotDot | QDir::Files);
    QFileInfoList allFiles = thisDir.entryInfoList();

    for (int i = 0; i < allFiles.size(); i++) {
        Option::Builder option = Option::create().text(allFiles[i].fileName().remove(".json"))
                                                 .selected(settings->value("appsDropDownOptionText", "").toString() == allFiles[i].fileName().remove(".json"));
        appsDropDown->add(option);
    }
}

void ApplicationUI::setText(QString newValue)
{
    if (m_text != newValue) {
        m_text = newValue;
        emit textChanged();
    }
}

void ApplicationUI::setAppFontSize(int appFontSize) {
    if (m_appFontSize != appFontSize) {
        m_appFontSize = appFontSize;
        settings->setValue("appFontSize", appFontSize);
        emit appFontSizeChanged();
    }
}

void ApplicationUI::setActiveFrameFontSize(int activeFrameFontSize) {
    if (m_activeFrameFontSize != activeFrameFontSize) {
        m_activeFrameFontSize = activeFrameFontSize;
        settings->setValue("activeFrameFontSize", activeFrameFontSize);
        emit activeFrameFontSizeChanged();
    }
}

void ApplicationUI::sendEmail(QString subject, QString body) {
    // Create the invoke
    bb::system::InvokeManager* invokeManager = new bb::system::InvokeManager(this);
    bb::system::InvokeRequest request;

    // Sets the URI for prepopulating the fields
    request.setTarget("sys.pim.uib.email.hybridcomposer");

    // Construct the URI
    QString uri = "mailto:?subject=" + QUrl::toPercentEncoding(subject, "", " ") + "&body=" + QUrl::toPercentEncoding(body, "", " ");
    request.setUri(uri);

    // Invoke
    invokeManager->invoke(request);
    invokeManager->deleteLater();
}
