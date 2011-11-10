Filters = [];
Filters.database = [];
Filters.create = function(attribute_type, attribute_value) {
    return {
      attribute_type: attribute_type,
      attribute_value: attribute_value,
    };
};

Filters.apply = function(filter) {
    Filters.push(filter);
    Filters.impose();
};

Filters.reset = function() {
    Filters.length = 0;
    Filters.impose();
}

Filters._fetch_filter_values = function(attribute_type) {
    // query for possible attribute values by given type
};

Filters._fill_tab = function(tab_id, values, type) {
    for (var i = 0; i < values.length; i++) {
        var tmp_element = $("<div>" +
                             "<img src=\"" + values[i].image + "\"></img>" +
                             "<p>" + values[i].name + "</p>" +
                             "</div>").click((function(val) { return function() {Filters.apply(Filters.create(
                                                                                      val
                                                                                      , type))}})(values[i]));
        
        $('#'+tab_id).append(tmp_element);
    }
};

Filters.impose = function() {
   
}

Filters.prepare = function() {
    
    var prepare_composition_filter = function() {
        var values = Filters._fetch_filter_values("composition");
        for (var i = 0; i < values.length; i++) {
            Filters.database.push(Filters.create("composition", values[i]));
        };
        Filters._fill_tab("tabs-composition", values);
    };
    var prepare_color_filter = function() {
        var values = Filters._fetch_filter_values("color");
        for (var i = 0; i < values.length; i++) {
            Filters.database.push(Filters.create("color", values[i]));
        };
        Filters._fill_tab("tabs-color", values);
    };
    
    var prepare_manufacturer_filer = function() {
        var values = Filters._fetch_filter_values("manufacturer");
        for (var i = 0; i < values.length; i++) {
            Filters.database.push(Filters.create("manufacturer", values[i]));
        };
        Filters._fill_tab("tabs-manufacturer", values);
    };
};
