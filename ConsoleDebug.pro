APP_NAME = ConsoleDebug

CONFIG += qt warn_on cascades10
QT+= network

LIBS += -lbb -lbbdata -lbbsystem

include(config.pri)

QT += network
LIBS += -lbb
