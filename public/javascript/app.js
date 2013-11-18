$(function(){
    $(".chosen-select.country").chosen().change(function() {
        $(".chosen-select.subregions").empty();
        var url = "http://0.0.0.0:9393/countries/name/" + $(".chosen-select.country").val() + "/subregions";
        $.getJSON(url, function(data) {

            $.each(data["subregions"], function(key, val) {
                $("<option>" + val["name"] + "</option>").appendTo(".chosen-select.subregions");
            });
           $(".chosen-select.subregions").show().chosen();
        });
    });
});