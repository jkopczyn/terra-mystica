{
    layout => 'sidebar',
    scripts => [ "/stc/common.js",
                 "/stc/faction.js",
                 "/stc/game.js",
                 "/stc/map.js"],
    title => 'Map Viewer',
    content => read_then_close(*DATA)
}

__DATA__
<div id="error"></div>

<h4>ID</h4>
<div id="map-id"></div>

<h4>Map</h4>
<div id="map-container">
  <canvas id="map" width="800" height="500" style="display: none">
    Browser not supported.
  </canvas>
</div>

<script>showMap();</script>
