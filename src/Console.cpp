/*
 * Console.cpp
 *
 *  Created on: 2014-10-16
 *      Author: Roger
 */

#include "Console.h"
#include <QStringList>
#include <bb/ApplicationInfo>

Console::Console() :
    QObject(),
    m_socket(new QUdpSocket(this)),
    m_server(new QUdpSocket(this))
{
    sendToConsoleDebug = false;

    listenOnPort(CONSOLEDEBUG_LISTENING_PORT);

    sendMessage("ConsoleDebugStarted$$");
}

Console::~Console()
{
    sendMessage("ConsoleDebugStopped$$");
}

void Console::sendMessage(QString _data)
{
    bb::ApplicationInfo appInfo;
    QString message = appInfo.title() + "##" + _data;

    qDebug() << "Console::sendMessage(): " + message;

    m_socket->writeDatagram(message.toStdString().c_str(),QHostAddress("127.0.0.1"), CONSOLEDEBUG_SENDING_PORT);
}


void Console::listenOnPort(int _port)
{
    m_server->bind(QHostAddress::Any, _port);
    connect(m_server, SIGNAL(readyRead()), this, SLOT(onReadyRead()));
}

void Console::onReadyRead()
{
    while (m_server->hasPendingDatagrams())
    {
        QByteArray datagram;
        datagram.resize(m_server->pendingDatagramSize());
        QHostAddress sender;
        quint16 senderPort;

        m_server->readDatagram(datagram.data(), datagram.size(),&sender, &senderPort);
        QString data = QString(datagram);

        onReceivedData(data);

        emit receivedData(data);
    }
}

void Console::onReceivedData(QString _data)
{
    qDebug() << "Received this from app :" << _data;
    QStringList allData = _data.split("$$");
    if (allData.size() < 3)
        return;

    QString appName = allData[0];
    QString command = allData[1].toLower();
    QString data = allData[2];

    if (command == "consolethis") {
        qDebug() << "consolethis";
        // Retrieve the timeActive list from file
        QString filePath = "data/ConsoleDebug/" + appName + ".json";
        QVariantList thisAppConsole = jda.load(filePath).toList();
        thisAppConsole.prepend(QVariant(data));

        qDebug() << "thisAppConsole" << thisAppConsole;

        while (thisAppConsole.size() > MAX_ENTRY_SIZE_PER_APP) {
            thisAppConsole.removeFirst();
        }

        // Save changes to the file
        jda.save(QVariant(thisAppConsole), filePath);
    }
}
