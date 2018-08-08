import QtQuick 2.12
import QtQuick.Window 2.12
import QtPositioning 5.12
import QtLocation 5.12
import Qt.labs.qmlmodels 1.0

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("GeoJSON viewer")

    Map {
        anchors.fill: parent
        id: map
        plugin: Plugin { name: "osm" }
        zoomLevel: 3

        MapItemView {
            id: miv
            model: annotations
            delegate: MapDelegate {

            }

            Component.onCompleted: {
                console.log(JSON.stringify(annotations, null, 2))
            }
        }
    }
}
