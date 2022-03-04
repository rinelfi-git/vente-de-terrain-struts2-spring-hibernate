<%--
  Created by IntelliJ IDEA.
  User: rinelfi
  Date: 03/03/2022
  Time: 14:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    #map-container {
        min-height: 500px;
        width: 100%;
    }
    canvas.mapboxgl-canvas {
        width: 100%;
        height: 100%;
    }
</style>
<div class="modal" id="map">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title map-header">Localisation sur la carte</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="map-container">
            </div>
            <div class="modal-footer">
                <input type="number" id="map-long" hidden="hidden" >
                <input type="number" id="map-lat" hidden="hidden" >
                <div class="form-inline">
                    <div class="input-group mx-sm-3 mb-2">
                        <div class="input-group-prepend">
                            <span class="btn btn-default">
                                <i class="fa fa-layer-group"></i>
                            </span>
                        </div>
                        <select class="custom-select" onchange="calcSelectionChanged(this)">
                            <option hidden selected>Calques</option>
                            <option value="mapbox://styles/mapbox/outdoors-v11">Outdoors</option>
                            <option value="mapbox://styles/mapbox/satellite-v9">Satellite</option>
                            <option value="mapbox://styles/mapbox/satellite-streets-v11">Satellite Streets</option>
                        </select>
                    </div>
                    <button type="button" class="btn btn-default mb-2" onclick="locateOnMap()">Centrer</button>
                </div>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
