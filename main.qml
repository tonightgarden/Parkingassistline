import QtQuick 2.7
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    visible: true
    width: 800
    height: 480
    title: qsTr("Test")

    Item {
        width: 800
        height: 480
        Assistline{
            anchors.fill: parent
        }
    }


}
