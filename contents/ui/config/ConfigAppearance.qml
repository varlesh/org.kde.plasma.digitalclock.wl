import QtQuick 2.2
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4

Item {
    property alias cfg_bold: bold.checked
    property alias cfg_marginSize: marginSize.value
    property alias cfg_clockFontSize: clockFontSize.value

    
    GridLayout {
        columns: 2
        columnSpacing: 50; rowSpacing: 3
        Layout.fillWidth: true
        anchors.right: parent.right
        anchors.left: parent.left

        CheckBox {
            Layout.row: 0
            Layout.column: 0
            id: bold
            text: i18n('Use bold font')
            
        }
        
        Label {
            Layout.row: 1
            Layout.column: 0
            text: i18n("Margin:")
        }
        Slider {
            Layout.row: 1
            Layout.column: 1
            id: marginSize
            stepSize: 1
            minimumValue: 1
            maximumValue: 100
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignRight
        }
        
        Label {
            Layout.row: 2
            Layout.column: 0
            text: i18n("Clock font size:")
        }
        Slider {
            Layout.row: 2
            Layout.column: 1
            id: clockFontSize
            stepSize: 1
            minimumValue: 1
            maximumValue: 100
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignRight
        }
        
        Item {
            width: 2
            height: 10
            Layout.columnSpan: 2
        }   
    }
}

