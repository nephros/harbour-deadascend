//  Copyright (c) 2024 Peter G. (nephros)
//  SPDX-License-Identifier: MIT
//
// Main QML page for Sailfish OS, replacing main.qml
import QtQuick 2.0

import Qak 1.0

import "qrc:///qml"

import Sailfish.Silica 1.0

ApplicationWindow {
    id: application

    cover: Component { CoverPlaceholder {
        text: qsTr('Dead Ascend')
        icon: "image://theme/harbour-deadascend2"
    }}

    visible: false

    //width: 1100/1.2
    //height: 660/1.2

    background.color: "black"

    /*
    Store {
        id: store
        name: "window"
        property alias px: application.x
        property alias py: application.y
        property alias w: application.width
        property alias h: application.height
        property alias screenMode: application.screenMode
    }
    */

    //Component.onDestruction: store.save()

    Component.onCompleted: {
        //store.load()
        //application.screenMode = Qak.platform.isMobile ? 'full' : 'windowed'

        if(App.dbg) {
            application.visible = true
            launcher.visible = true
            back.opacity = 0
            console.debug("Debugging: on")
        } else {
            console.debug("Debugging: off")
            if(Qak.platform.isDesktop) {
                console.info("Desktop mode")
                application.visible = true
                back.opacity = 1
            } else
                console.info("Mobile mode")
                startTimer.start()
        }
    }

    Loader {
        id: launcher
        visible: false
        anchors { fill: parent }
        sourceComponent: coreComponent
        focus: true
    }

    Component {
        id: coreComponent
        Core {
            anchors { fill: parent }
        }
    }

    /*
    View {
        id: view
        visible: back.opacity > 0

        anchors { fill: parent }

        mattes: true
        mattesColor: "black"

        viewport.fillMode: Image.PreserveAspectFit
        viewport.width: Screen.width
        viewport.height: Math.floor(Screen.height*Screen.widthRatio)

        Item {
            id: back
            anchors { fill: parent }
            //color: "white"

            opacity: 0.99

            Behavior on opacity {
                NumberAnimation { duration: 1500 }
            }

            Image {
                id: publisherImage
                width: parent.width * 0.8
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                source: back.opacity > 0 ? App.getAsset('publisher.png') : ''

                Behavior on opacity {
                    NumberAnimation { duration: 500 }
                }
            }

            Image {
                id: studioImage
                opacity: 0
                width: parent.width * 0.8
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                source: back.opacity > 0 ? App.getAsset('studio.png') : ''

                Behavior on opacity {
                    NumberAnimation { duration: 1000 }
                }
            }

            Timer {
                id: crossFadeTimer
                running: back.opacity == 1
                interval: 1000
                onTriggered: {
                    publisherImage.opacity = 0
                    studioImage.opacity = 1
                }
            }

        }

    }
    */
    Item {
        id: view
        visible: back.opacity > 0

        anchors { fill: parent }

        property bool mattes: true
        property color mattesColor: "black"

        Image {
            id: viewport
        }
        viewport.fillMode: Image.PreserveAspectFit
        viewport.width: Screen.width
        viewport.height: Math.floor(Screen.height*Screen.widthRatio)

        Item {
            id: back
            anchors { fill: parent }
            //color: "white"

            opacity: 0.99

            Behavior on opacity {
                NumberAnimation { duration: 1500 }
            }

            Image {
                id: publisherImage
                width: parent.width * 0.8
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                source: back.opacity > 0 ? App.getAsset('publisher.png') : ''

                Behavior on opacity {
                    NumberAnimation { duration: 500 }
                }
            }

            Image {
                id: studioImage
                opacity: 0
                width: parent.width * 0.8
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
                source: back.opacity > 0 ? App.getAsset('studio.png') : ''

                Behavior on opacity {
                    NumberAnimation { duration: 1000 }
                }
            }

            Timer {
                id: crossFadeTimer
                running: back.opacity == 1
                interval: 1000
                onTriggered: {
                    publisherImage.opacity = 0
                    studioImage.opacity = 1
                }
            }

        }

    }

    Timer {
        id: launchTimer
        running: false
        interval: 2000
        repeat: true
        onTriggered: {

            if(launcher.status === Loader.Ready) {
                launcher.visible = true
                back.opacity = 0
                running = false
            }
        }
    }

    Timer {
        id: blackGrainTimer
        running: back.opacity == 1
        interval: 3500
        onTriggered: {
            studioImage.opacity = 0
            launchTimer.start()
        }
    }

    Timer {
        id: startTimer
        interval: 2000
        onTriggered: {
            application.visible = true
            back.opacity = 1
        }
    }
}
