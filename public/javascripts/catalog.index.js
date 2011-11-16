var applied_filters = [];
var possible_filters = [];
var on_possible_filter_values_ready = function() { };


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
        mouseDown: function() {
          on_filter_pick(item);
        },
        text: item.name
    });
  };

  var fill_tab = function(tab_id, values) {
    _.each(values, function(item) {
      $('#'+tab_id).append(filter_element(item));
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
//prepare_filter_chooser();