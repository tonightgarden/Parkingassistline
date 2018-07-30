import QtQuick 2.0
    Image {
        id: point_img
        source: "qrc:/icon_move.png"
        signal xyChanged(int x,int y);
        MouseArea{
            anchors.fill: parent
            drag.target: point_img
            drag.axis: Drag.XAndYAxis
            drag.minimumX: -point_img.width/2
            drag.maximumX: 800 - point_img.width/2
            drag.minimumY: -parent.height/2
            drag.maximumY: 480 - point_img.height/2
            onPositionChanged: {

                xyChanged(point_img.x+point_img.width/2,point_img.y+point_img.height/2 );
            }
        }
    }

