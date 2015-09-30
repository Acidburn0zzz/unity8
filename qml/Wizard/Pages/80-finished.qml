/*
 * Copyright (C) 2013-2015 Canonical, Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.3
import Ubuntu.Components 1.2
import ".." as LocalComponents

LocalComponents.Page {
    objectName: "finishedPage"

    hasBackButton: false
    customTitle: true
    lastPage: true

    Component.onCompleted: {
        state = "reanchored";
    }

    states: State {
        name: "reanchored"
        AnchorChanges { target: bgImage; anchors.top: parent.top; anchors.bottom: parent.bottom }
        AnchorChanges { target: column;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.top: undefined
        }
    }

    transitions: Transition {
        ParallelAnimation {
            AnchorAnimation {
                targets: [bgImage, column]
                duration: UbuntuAnimation.BriskDuration
                easing.type: Easing.OutCubic
            }
            NumberAnimation { // opacity animation
                targets: [bgImage,column]
                property: 'opacity'
                from: 0
                to: 1
                duration: UbuntuAnimation.BriskDuration
            }
        }
    }

    Image {
        id: bgImage
        source: "data/Phone Splash Screen bkg.png"
        scale: Image.PreserveAspectFit
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.top // outside to let it slide down
        visible: opacity > 0
    }

    Column {
        id: column
        anchors.leftMargin: leftMargin
        anchors.rightMargin: rightMargin
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.bottom // outside to let it slide in
        spacing: units.gu(2)
        visible: opacity > 0

        Label {
            id: welcomeLabel
            anchors.left: parent.left
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            fontSize: "x-large"
            font.weight: Font.Light
            text: i18n.tr("Welcome to Ubuntu")
        }

        Label {
            anchors.left: parent.left
            anchors.right: parent.right
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.Wrap
            fontSize: "large"
            font.weight: Font.Light
            text: i18n.tr("You are ready to use your device now")
        }

        Rectangle {
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            color: 'transparent'
            border.width: units.dp(1)
            border.color: 'white'
            radius: units.dp(4)
            width: buttonLabel.paintedWidth + units.gu(6)
            height: buttonLabel.paintedHeight + units.gu(1.7)

            Label {
                id: buttonLabel
                color: 'white'
                text: i18n.tr("Get Started")
                fontSize: "medium"
                anchors.centerIn: parent
            }
            MouseArea {
                anchors.fill: parent
                onClicked: root.quitWizard()
            }
        }
    }
}
