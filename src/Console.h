/*
 * Console.h
 *
 *  Created on: 2014-10-16
 *      Author: Roger
 */

#ifndef CONSOLE_H_
#define CONSOLE_H_

#include <QObject>
#include <QtNetwork/QUdpSocket>
#include <bb/data/JsonDataAccess>

#define CONSOLEDEBUG_SENDING_PORT 10466
#define CONSOLEDEBUG_LISTENING_PORT 10465
#define MAX_ENTRY_SIZE_PER_APP 1000

class Console : public QObject
{
    Q_OBJECT
public:
    Console();
    virtual ~Console();

    Q_INVOKABLE void sendMessage(QString _command);

private:
    void listenOnPort(int _port);
    void onReceivedData(QString _data);

    QUdpSocket *m_socket;
    QUdpSocket *m_server;

    bb::data::JsonDataAccess jda;
    bool sendToConsoleDebug;

signals:
    void receivedData(QString);

public slots:
    void onReadyRead();
};

#endif /* Console_H_ */
