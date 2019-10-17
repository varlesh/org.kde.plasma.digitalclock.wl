/*
    Copyright 2013 Anant Kamath <kamathanant@gmail.com>
    Copyright 2015 David Edmundson <davidedmundson@kde.org>
    Copyright 2019 Alexey Varfolomeev <varlesh@gmail.com>
    
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) version 3, or any
    later version accepted by the membership of KDE e.V. (or its
    successor approved by the membership of KDE e.V.), which shall
    act as a proxy defined in Section 6 of version 3 of the license.

    This plasmoid is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this plasmoid. If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.plasmoid 2.0

Item {
    id: mainWindow
    Layout.minimumWidth: Plasmoid.configuration.marginSize
    Layout.minimumHeight: 16
    property string textColor: Plasmoid.configuration.textColor
    property string textFont: Plasmoid.configuration.textFont
    
    Text {
        id: time
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.weight: plasmoid.configuration.bold ? Font.Bold : Font.Normal
        color: theme.textColor
        font.pixelSize: plasmoid.configuration.clockFontSize
        font.pointSize: -1
        text: Qt.formatTime( dataSource.data["Local"]["DateTime"],"h:mm" )
        anchors.fill: parent
    }
    MouseArea {
        anchors.fill: parent
        onClicked: plasmoid.expanded = !plasmoid.expanded
    }
}
