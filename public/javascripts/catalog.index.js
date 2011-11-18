var applied_filters = (function() {
  var result = [];
  var old_push = result.push;
  result.push = function(x) {
    for (var i = 0; i < this.length; i++) {
        if (this[i].id == x.id) return;
    }

    old_push.call(this, x);
  };

  result.remove_by_id = function(id) {
    for (var i = 0; i < this.length; i++) {
        if (this[i].id == id) {
            this.splice(i,1);
            return;
        }
    }
  };

  result.contains_id = function(id) {
    for (var i = 0; i < this.length; i++) {
        if (this[i].id == id) {
            return true;
        }
    }

    return false;
  };

  return result;
})();
var possible_filters = [];
var on_possible_filter_values_ready = function() {
};


var prepare_possible_filter_values_for = function(attribute_types) {
    attribute_types = $.toJSON(attribute_types);
    $.ajax({
        url: "/catalog/filters",
        data: {attribute_types: attribute_types},
        dataType: 'json',
        success: function(data) {
            possible_filters = data;
            on_possible_filter_values_ready();
        }
    });
};

var fill_filter_tabs = function(pfv) {

    var filter_element = function(item) {
        if (item.type != 'color') {
          return $('<span></span>', {
                className: 'filter-choice',
                html: '<span style="width:50px; height:50px; display: inline-block; ">' +
                    'V' +
                    '</span><br>' +
                    '<span>'+ item.name + '</span>'
            }).click(function() {
                  if (this.toggle == undefined)
                  this.toggle = false;

                    $(this).firstChild().
                    on_filter_pick(item);
                });
        } else {
          return $('<span></span>', {
                className: 'filter-choice',
                html: '<span style="width:50px; height:50px; display: inline-block; background:' + item.name + '">' +
                    'V' +
                    '</span><br>'
            }).click(function() {
                    on_filter_pick(item);
                });
        }
    };

    var fill_tab = function(tab_id, values) {
        _.each(values, function(item) {
            $('#' + tab_id).append(filter_element(item));
        });
    };

    fill_tab("tabs-composition", pfv.by_composition);
    fill_tab("tabs-color", pfv.by_color);
    fill_tab("tabs-manufacturer", pfv.by_manufacturer);

};

var prepare_filter_chooser = function() {
    on_possible_filter_values_ready = function() {
        fill_filter_tabs(possible_filters);
    };

    prepare_possible_filter_values_for(["composition", "color", "manufacturer"]);
};

var fill_results_list_with = function(entries) {

    var list_item = function(entry) {
        return $('<tr></tr>', {
            html: '<td></td>' +
            '<td>' + entry.title + '</td>' +
            '<td>' + entry.composition + '</td>' +
            '<td style="background:' + entry.color + '"></td>' +
            '<td>' + entry.manufacturer + '</td>'
        });
    };

    $('#filter-results tbody').html('');

    _.each(entries, function(item) {
        $('#filter-results tbody').append(list_item(item.catalog_entry))
    });

};

var update_results_list = function() {

    var af = $.toJSON(applied_filters);
    $.ajax({
        url: "/catalog/filters",
        type: 'POST',
        data: {applied_filters: af},
        dataType: 'json',
        success: function(data) {
            fill_results_list_with(data);
        }
    });
};

var update_current_filters_display = function() {

    $('#filter-applied-composition').html('');
    $('#filter-applied-color').html('');
    $('#filter-applied-manufacturer').html('');

    _.each(applied_filters, function(item) {
      $('#filter-applied-' + item.type).append($('<li></li>',{text:item.name
          , style:'background:'+ item.name +
              (item.type =='color'? ';text-indent:-9999px;' :'')
      }));
    });
};

var on_filter_pick = function(filter) {

    if (applied_filters.contains_id(filter.id)) {
        applied_filters.remove_by_id(filter.id);
    } else {
        applied_filters.push(filter);
    }

    update_results_list();
    update_current_filters_display();
};

var load_initial_catalog = function() {
    $.ajax({
        url: "/catalog/filters",
        type: 'POST',
        dataType: 'json',
        success: function(all) {
            fill_results_list_with(all);
        }
    });
};

load_initial_catalog();
prepare_filter_chooser();

$('#filter-tabs').tabs();