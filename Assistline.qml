import QtQuick 2.0
import QtQuick.Controls 1.4
import Qt.labs.settings 1.0

Rectangle {
    id:rootAssistLine
    //    color: "blue"
    property int pointX_1: 0
    property int pointY_1: 0

    property int pointX_2: 0
    property int pointY_2: 0

    property int pointX_3: 0
    property int pointY_3: 0

    property int pointX_4: 0
    property int pointY_4: 0

    property int pointX_5: 0
    property int pointY_5: 0

    property int pointX_6: 0
    property int pointY_6: 0

    property int pointX_7: 0
    property int pointY_7: 0

    property int pointX_8: 0
    property int pointY_8: 0


    Canvas{
        id:canvasView
        anchors.fill: parent

        onPaint: {

            /**
              * 4 —— 5
              * |    |
              * 3 -- 6
              * |    |
              * 2 -- 7
              * |    |
              * 1    8
              */
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, canvasView.width, canvasView.height)
            ctx.lineWidth  = 6
            // 设置画笔
            ctx.strokeStyle = "green"
            // 创建路径
            ctx.beginPath()
            ctx.moveTo(pointX_3,pointY_3)
            ctx.lineTo(pointX_4,pointY_4)
            ctx.moveTo(pointX_5,pointY_5)
            ctx.lineTo(pointX_6,pointY_6)
            ctx.stroke()


            ctx.beginPath()
            ctx.strokeStyle = "yellow"
            ctx.moveTo(pointX_2,pointY_2)
            ctx.lineTo(pointX_3,pointY_3)
            ctx.moveTo(pointX_6,pointY_6)
            ctx.lineTo(pointX_7,pointY_7)
            ctx.stroke()


            ctx.beginPath()
            ctx.strokeStyle = "red"
            ctx.moveTo(pointX_1,pointY_1)
            ctx.lineTo(pointX_2,pointY_2)
            ctx.moveTo(pointX_7,pointY_7)
            ctx.lineTo(pointX_8,pointY_8)
            ctx.stroke()
            // 绘制

            // 4——5
            ctx.beginPath()
            ctx.strokeStyle = "green"
            ctx.moveTo(pointX_4,pointY_4)
            ctx.lineTo(pointX_5,pointY_5)
            ctx.stroke()
            // 3--6
            ctx.beginPath()
            ctx.strokeStyle = "yellow"
            drawDashLine(ctx,pointX_3,pointY_3,pointX_6,pointY_6,6);
            // 2--7
            ctx.beginPath()
            ctx.strokeStyle = "red"
            drawDashLine(ctx,pointX_2,pointY_2,pointX_7,pointY_7,6);

        }

        function drawDashLine(ctx, x1, y1, x2, y2, dashLength){
            var dashLen = dashLength === undefined ? 5 : dashLength;
            var xpos = x2 - x1; //得到横向的宽度;
            var ypos = y2 - y1; //得到纵向的高度;
            var numDashes = Math.floor(Math.sqrt(xpos * xpos + ypos * ypos) / dashLen);
            //利用正切获取斜边的长度除以虚线长度，得到要分为多少段;
            for(var i=0; i<numDashes+1; i++){
                if(i % 2 === 0){
                    ctx.moveTo(x1 + (xpos/numDashes) * i, y1 + (ypos/numDashes) * i);
                    //有了横向宽度和多少段，得出每一段是多长，起点 + 每段长度 * i = 要绘制的起点；
                }else{
                    ctx.lineTo(x1 + (xpos/numDashes) * i, y1 + (ypos/numDashes) * i);
                }
            }
            ctx.stroke();
        }

    }


    /**
      * 2 —5 — 3
      * |      |
      * |--6---|
      * |      |
      * |--7---|
      * |      |
      * 1      4
      */

    Repeater{
        id:pointImgRepeater
        model: 7
        MovePoint{
            visible: editModeBtn.isEditMode
            onXyChanged:
            {
                if(index==0)
                {
                    var point = pointsRepeater.itemAt(0);
                    point.x = x;
                    point.y = y;
                    pointsRepeater.itemAt(7).x =  pointsRepeater.itemAt(3).x - x +pointsRepeater.itemAt(4).x
                    pointsRepeater.itemAt(7).y = y;

                }
                if(index==3)
                {
                    var point = pointsRepeater.itemAt(7);
                    point.x = x;
                    point.y = y;
                    pointsRepeater.itemAt(0).x = pointsRepeater.itemAt(3).x - (x- pointsRepeater.itemAt(4).x);
                    pointsRepeater.itemAt(0).y = y;
                }

                if(index==1)
                {
                    var point = pointsRepeater.itemAt(3);
                    point.x = x;
                    point.y = y;
                    pointsRepeater.itemAt(4).x =  pointsRepeater.itemAt(7).x -( x- pointsRepeater.itemAt(0).x )
                    pointsRepeater.itemAt(4).y = y;
                    //                     pointsRepeater.itemAt(7).x =  pointsRepeater.itemAt(4).x+( x- pointsRepeater.itemAt(0).x );

                }
                if(index==2)
                {
                    var point = pointsRepeater.itemAt(4);
                    point.x = x;
                    point.y = y;
                    pointsRepeater.itemAt(3).x =  pointsRepeater.itemAt(7).x - x +pointsRepeater.itemAt(0).x
                    pointsRepeater.itemAt(3).y = y;
                }
                if(index==4)
                {
                    pointsRepeater.itemAt(3).y = y;
                    pointsRepeater.itemAt(4).y = y;
                }
                if(index==5)
                {
                    if(y<=pointsRepeater.itemAt(3).y)
                    {
                        return;
                    }
                    pointsRepeater.weight3_4 = (y-pointsRepeater.itemAt(3).y) /(pointsRepeater.itemAt(0).y-pointsRepeater.itemAt(3).y)
                }
                if(index==6)
                {
                    if(y<=pointsRepeater.itemAt(2).y)
                    {
                        return;
                    }
                    pointsRepeater.weight2_3 = (y- pointsRepeater.itemAt(2).y )/(pointsRepeater.itemAt(0).y-pointsRepeater.itemAt(3).y)
                }

                pointsRepeater.handleOtherPoints();
                rootAssistLine.resetPointSXY();
            }
        }
    }

    Column{
        spacing: 2
        Button{
            text: "Reset"
            onClicked: {
                setDefalt()
                pointsRepeater.handleOtherPoints();
                resetPointSXY()
            }
        }
        Button{
            id:editModeBtn
            text: isEditMode?"QuitEdit":"Edits"
            property bool isEditMode: false
            onClicked: {
                isEditMode = ! isEditMode
            }
        }
        Button{
            text: "Save"
            onClicked:
            {
                saveData();
            }
        }
    }

    function resetPointSXY()
    {
        pointX_1= pointsRepeater.itemAt(0).x;
        pointY_1= pointsRepeater.itemAt(0).y;

        pointX_2= pointsRepeater.itemAt(1).x;
        pointY_2= pointsRepeater.itemAt(1).y;

        pointX_3= pointsRepeater.itemAt(2).x;
        pointY_3= pointsRepeater.itemAt(2).y;

        pointX_4= pointsRepeater.itemAt(3).x;
        pointY_4= pointsRepeater.itemAt(3).y;

        pointX_5= pointsRepeater.itemAt(4).x;
        pointY_5= pointsRepeater.itemAt(4).y;

        pointX_6= pointsRepeater.itemAt(5).x;
        pointY_6= pointsRepeater.itemAt(5).y;

        pointX_7= pointsRepeater.itemAt(6).x;
        pointY_7= pointsRepeater.itemAt(6).y;

        pointX_8= pointsRepeater.itemAt(7).x;
        pointY_8= pointsRepeater.itemAt(7).y;

        canvasView.requestPaint();

        var point = pointImgRepeater.itemAt(0);
        point.x  = pointX_1-point.width/2;
        point.y  = pointY_1-point.height/2;

        var point = pointImgRepeater.itemAt(1);
        point.x  = pointX_4-point.width/2;
        point.y  = pointY_4-point.height/2;

        var point = pointImgRepeater.itemAt(2);
        point.x  = pointX_5-point.width/2;
        point.y  = pointY_5-point.height/2;

        var point = pointImgRepeater.itemAt(3);
        point.x  = pointX_8-point.width/2;
        point.y  = pointY_8-point.height/2;

        var point = pointImgRepeater.itemAt(4);
        point.x  = (pointX_5-pointX_4)/2+pointX_4 -point.width/2;
        point.y  = pointY_4-point.height/2;

        var point = pointImgRepeater.itemAt(5);
        point.x  = (pointX_6-pointX_3)/2+pointX_3-point.width/2;
        point.y  = pointY_3-point.height/2;

        var point = pointImgRepeater.itemAt(6);
        point.x  = (pointX_7-pointX_2)/2+pointX_2-point.width/2;
        point.y  = pointY_2-point.height/2;

    }

    Repeater{
        id:pointsRepeater
        model:8
        property real weight3_4: 0
        property real weight2_3: 0
        Item{
        }
        function handleOtherPoints()
        {

            var y3 =  (pointsRepeater.itemAt(0).y - pointsRepeater.itemAt(3).y)*weight3_4+pointsRepeater.itemAt(3).y
            var pwl3 =  (pointsRepeater.itemAt(3).x - pointsRepeater.itemAt(0).x)*weight3_4
            //point3
            pointsRepeater.itemAt(2).x = pointsRepeater.itemAt(3).x-pwl3;
            pointsRepeater.itemAt(2).y = y3;
            //point6
            pointsRepeater.itemAt(5).x = pointsRepeater.itemAt(4).x+pwl3;
            pointsRepeater.itemAt(5).y = y3;

            var y2 =  (pointsRepeater.itemAt(0).y - pointsRepeater.itemAt(3).y)*weight2_3+pointsRepeater.itemAt(2).y
            var pwl2 =  (pointsRepeater.itemAt(3).x - pointsRepeater.itemAt(0).x)*weight2_3

            //point2
            pointsRepeater.itemAt(1).x = pointsRepeater.itemAt(2).x-pwl2;
            pointsRepeater.itemAt(1).y = y2;
            //point7
            pointsRepeater.itemAt(6).x = pointsRepeater.itemAt(5).x+pwl2;
            pointsRepeater.itemAt(6).y = y2;


        }
    }

    Settings{
        id:settings
        property int pointX_1: -1
        property int pointY_1: -1
        property int pointX_4: -1
        property int pointY_4: -1
        property int pointX_5: -1
        property int pointY_5: -1
        property int pointX_8: -1
        property int pointY_8: -1
        property real weight3_4: 1/3
        property real weight2_3: 1/3
    }

    function saveData()
    {
        //point1
        settings.pointX_1 = pointsRepeater.itemAt(0).x
        settings.pointY_1 = pointsRepeater.itemAt(0).y
        //point4
        settings.pointX_4 = pointsRepeater.itemAt(3).x
        settings.pointY_4 = pointsRepeater.itemAt(3).y
        //point5
        settings.pointX_5 =pointsRepeater.itemAt(4).x
        settings.pointY_5 = pointsRepeater.itemAt(4).y
        //point8
        settings.pointX_8 = pointsRepeater.itemAt(7).x
        settings.pointY_8 = pointsRepeater.itemAt(7).y

        settings.weight2_3 = pointsRepeater.weight2_3
        settings.weight3_4 = pointsRepeater.weight3_4

    }

    function getData()
    {
        //point1
        pointsRepeater.itemAt(0).x   = settings.pointX_1
        pointsRepeater.itemAt(0).y   = settings.pointY_1
        //point4
        pointsRepeater.itemAt(3).x   = settings.pointX_4
        pointsRepeater.itemAt(3).y   = settings.pointY_4
        //point5
        pointsRepeater.itemAt(4).x   = settings.pointX_5
        pointsRepeater.itemAt(4).y   = settings.pointY_5
        //point8
        pointsRepeater.itemAt(7).x   = settings.pointX_8
        pointsRepeater.itemAt(7).y   = settings.pointY_8

        pointsRepeater.weight2_3     = settings.weight2_3
        pointsRepeater.weight3_4     = settings.weight3_4

    }

    function setDefalt()
    {
        console.debug("setDefalt")
        //point1
        pointsRepeater.itemAt(0).x = 0;
        pointsRepeater.itemAt(0).y = rootAssistLine.height-20;
        //point4
        pointsRepeater.itemAt(3).x = rootAssistLine.width/4;
        pointsRepeater.itemAt(3).y = 0+20;
        //point5
        pointsRepeater.itemAt(4).x = rootAssistLine.width/4*3;
        pointsRepeater.itemAt(4).y = pointsRepeater.itemAt(3).y ;
        //point8
        pointsRepeater.itemAt(7).x = rootAssistLine.width;
        pointsRepeater.itemAt(7).y = pointsRepeater.itemAt(0).y;

        pointsRepeater.weight2_3 = settings.weight2_3;
        pointsRepeater.weight3_4 = settings.weight3_4;

        console.debug("weight2_3 ", pointsRepeater.we_ight23);
        console.debug("weight3_4 ", pointsRepeater.weight3_4);
        console.debug("getData")
    }

    Component.onCompleted: {
        if(settings.pointX_1==-1&&settings.pointX_4==-1)
        {

            setDefalt()
            pointsRepeater.handleOtherPoints();
        }else
        {

            getData();
             pointsRepeater.handleOtherPoints();
        }
        resetPointSXY()
    }
    Component.onDestruction: {

    }


}
