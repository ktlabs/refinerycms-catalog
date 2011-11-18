var applied_filters = [];
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
        return $('<div></div>', {
            className: 'filter-choice',
            text: item.name
        }).click(function() {
                on_filter_pick(item);
            });
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
        return $('<li></li>', {
            text: entry.title + ' ' + entry.composition + ' ' + entry.color + ' ' + entry.manufacturer
        });
    };

    $('#filter-results').html('');

    _.each(entries, function(item) {
        $('#filter-results').append(list_item(item.catalog_entry))
    });

    $('#filter-results').sortable();
    $('#filter-results').disableSelection();
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
    _.each(applied_filters, function(item) {
      $('#filter-applied').append($('<div></div>',{text:item.name}));
    });
};

var on_filter_pick = function(filter) {
    applied_filters.push(filter);
    update_results_list();
    update_current_filters_display();
};

var load_initial_catalog = function() {
    var all = all_catalog_entries();
    fill_results_list_with(all);
};

load_initial_catalog();
prepare_filter_chooser();

$('#filter-tabs').tabs();