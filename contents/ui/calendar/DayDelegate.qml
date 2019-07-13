/*
 * Copyright 2013 Heena Mahour <heena393@gmail.com>
 * Copyright 2013 Sebastian Kügler <sebas@kde.org>
 * Copyright 2015 Kai Uwe Broulik <kde@privat.broulik.de>
 * Copyright 2019 Michail Vourlakos <mvourlakos@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.0
import org.kde.plasma.calendar 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as Components

import org.kde.plasma.calendar 2.0

MouseArea {
    id: dayStyle

    hoverEnabled: true

    property bool circleStyle: true

    signal activated

    readonly property date thisDate: new Date(yearNumber, typeof monthNumber !== "undefined" ? monthNumber - 1 : 0, typeof dayNumber !== "undefined" ? dayNumber : 1)
    readonly property bool today: {
        var today = root.today;
        var result = true;
        if (dateMatchingPrecision >= Calendar.MatchYear) {
            result = result && today.getFullYear() === thisDate.getFullYear()
        }
        if (dateMatchingPrecision >= Calendar.MatchYearAndMonth) {
            result = result && today.getMonth() === thisDate.getMonth()
        }
        if (dateMatchingPrecision >= Calendar.MatchYearMonthAndDay) {
            result = result && today.getDate() === thisDate.getDate()
        }
        return result
    }
    readonly property bool selected: {
        var current = root.currentDate;
        var result = true;
        if (dateMatchingPrecision >= Calendar.MatchYear) {
            result = result && current.getFullYear() === thisDate.getFullYear()
        }
        if (dateMatchingPrecision >= Calendar.MatchYearAndMonth) {
            result = result && current.getMonth() === thisDate.getMonth()
        }
        if (dateMatchingPrecision >= Calendar.MatchYearMonthAndDay) {
            result = result && current.getDate() === thisDate.getDate()
        }
        return result
    }

    onHeightChanged: {
        // this is needed here as the text is first rendered, counting with the default root.cellHeight
        // then root.cellHeight actually changes to whatever it should be, but the Label does not pick
        // it up after that, so we need to change it explicitly after the cell size changes
        label.font.pixelSize = Math.max(theme.smallestFont.pixelSize, Math.floor(daysCalendar.cellHeight / 4))
    }

    Rectangle {
        id: todayRect
        anchors.centerIn: parent
        width: circleStyle ? 0.9 * Math.min(parent.width, parent.height) : parent.width
        height: circleStyle ? width : parent.height
        radius: circleStyle ? width : 0

        opacity: {
            if (dayStyle.containsMouse) {
                1
            } else if (selected && today) {
                0.9
            } else if (today) {
                0.8
            } else {
                0
            }
        }
        Behavior on opacity { NumberAnimation { duration: units.shortDuration*2 } }
        color: theme.buttonFocusColor/*theme.textColor*/
    }

    Rectangle {
        id: highlightDate
        anchors.centerIn: todayRect
        width: circleStyle ? Math.min(todayRect.width, todayRect.height) : todayRect.width
        height: circleStyle ? width : todayRect.height
        radius: circleStyle ? width : 0

        opacity: {
            if (selected) {
                0.6
            } else if (dayStyle.containsMouse) {
                0.4
            } else {
                0
            }
        }
        visible: !today
        Behavior on opacity { NumberAnimation { duration: units.shortDuration*2 } }
        color: theme.highlightColor
        z: todayRect.z - 1
    }

    Loader {
        active: model.containsMajorEventItems !== undefined && model.containsMajorEventItems
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        height: parent.height / 4
        width: height
        sourceComponent: eventsMarkerComponent
    }

    Components.Label {
        id: label
        anchors {
            fill: todayRect
            margins: units.smallSpacing
        }
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: model.label || dayNumber
        opacity: isCurrent ? 1.0 : 0.5
        wrapMode: Text.NoWrap
        elide: Text.ElideRight
        fontSizeMode: Text.HorizontalFit
        font.bold: (dayStyle.today || dayStyle.containsMouse || selected)
        font.pixelSize: Math.max(theme.smallestFont.pixelSize, Math.floor(daysCalendar.cellHeight / 4))
        // Plasma component set point size, this code wants to set pixel size
        // Setting both results in a warning
        // -1 is an undocumented same as unset (see qquickvaluetypes)
        font.pointSize: -1
        color: today ? theme.highlightedTextColor/*theme.backgroundColor*/ : theme.textColor
        Behavior on color {
            ColorAnimation { duration: units.shortDuration * 2 }
        }
    }
}

