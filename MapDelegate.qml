import QtQuick 2.12
import QtPositioning 5.12
import QtLocation 5.12
import Qt.labs.qmlmodels 1.0

DelegateComponent {
    id: dc
//    role: "dataType"
    role: "key"
    DelegateChoice {
        roleValue: "LineString"
        delegate: MapPolyline {
            path: modelData.path
            line.color: "red"
        }
    }
    DelegateChoice {
        roleValue: "circle"
        delegate: MapCircle {
            center: modelData.crd //QtPositioning.coordinate(dt.lat, dt.lon)
            radius: modelData.rds
            color: modelData.clr
        }
    }
    DelegateChoice {
        roleValue: "rect"
        delegate: MapRectangle {
            topLeft: modelData.tl
            bottomRight: modelData.br
            color: modelData.clr
        }
    }
    DelegateChoice {
        roleValue: "model"
        delegate: MapItemView {
            model: modelData.list
            delegate: dc
        }
    }
}
