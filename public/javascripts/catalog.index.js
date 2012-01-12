$(function() {
    $('#flt-choices-composition-trigger').click(function () {
        $('#flt-choices-color').hide();
        $('#flt-choices-manufacturer').hide();
        $('.active').removeClass('active');

        $('#flt-choices-composition').show();
        $(this).parent().addClass('active');

        return false;
    });

    $('#flt-choices-color-trigger').click(function () {
        $('#flt-choices-manufacturer').hide();
        $('#flt-choices-composition').hide();
        $('.active').removeClass('active');

        $('#flt-choices-color').show();
        $(this).parent().addClass('active');

        return false;
    });

    $('#flt-choices-manufacturer-trigger').click(function () {
        $('#flt-choices-composition').hide();
        $('#flt-choices-color').hide();
        $('.active').removeClass('active');

        $('#flt-choices-manufacturer').show();
        $(this).parent().addClass('active');

        return false;
    });

    $('input[type=checkbox]').attr('checked', false);
});

applied_filters = { color: [], composition: [], manufacturer: [],
    get_by_id: function(id, type) {
        return _.find(applied_filters[type], function(item) {
            if (item.id == id) return true;
        });

    }
};

is_filter_applied = function(filter, type) {
    return _.any(applied_filters[type], function(item) {
        if (item.id == filter.id) return true;
    });
};

update_checked_filters_panel = function() {

    $('#flt-checked-composition-outlet').html(
        _.map(applied_filters.composition, function(item) {
            return ("<li>" +
                item.value +
            "<a href=\"javascript:;\" onclick=\"remove_filter(" +
                "applied_filters.get_by_id('" + item.id + "', 'composition')" +
            ", 'composition')\"></a>" +
            "</li>");

        }).join(' ')
    );

    $('#flt-checked-color-outlet').html(
        _.map(applied_filters.color, function(item) {
            return ("<li>" +
                item.value +
            "<a href=\"javascript:;\" onclick=\"remove_filter(" +
                "applied_filters.get_by_id('" + item.id + "', 'color')" +
            ", 'color')\"></a>" +
            "</li>");

        }).join(' ')
    );

    $('#flt-checked-manufacturer-outlet').html(
        _.map(applied_filters.manufacturer, function(item) {
            return ("<li>" +
                item.value +
            "<a href=\"javascript:;\" onclick=\"remove_filter(" +
                "applied_filters.get_by_id('" + item.id + "', 'manufacturer')" +
            ", 'manufacturer')\"></a>" +
            "</li>");

        }).join(' ')
    )
};

update_results_panel = function(data) {
    $('#flt-table-outlet').html('');

    _.each(data, function(item) {
        item = item.catalog_entry;
        $('#flt-table-outlet').html($('#flt-table-outlet').html +
            '<tr>' +
                '<td>' + ( item.article? item.article : 'Нет данных' ) + '</td>' +
                '<td>' + ( item.title? item.title : 'Нет данных' ) + '</td>' +
                '<td>' + ( item.composition? item.composition : 'Нет данных' ) + '</td>' +
                '<td>' + ( item.color? item.color : 'Нет данных' ) + '</td>' +
                '<td>' + ( item.manufacturer? item.manufacturer : 'Нет данных' ) + '</td>' +
            '</tr>'
        )
    });

}

load_results = function() {
    $.ajax({
        url: '/catalog/search',
        data: $.param(applied_filters),
        dataType: 'json',
        success: function(data) {
            update_checked_filters_panel();
            update_results_panel(data);
        }
    });
};

reload_results = load_results;

apply_filter = function(filter, type) {
    applied_filters[type].push(filter);
    reload_results();
};

remove_filter = function(filter, type) {
    applied_filters[type] = _.reject(
        applied_filters[type], function(item) {
            return filter.id == item.id;
        });
    reload_results();

    $('#check-'+filter.id).attr('checked', false);
};

toggle_composition_filter = function(filter) {
    if (is_filter_applied(filter, 'composition')) {
        remove_filter(filter, 'composition');
    } else {
        apply_filter(filter, 'composition')
    }
};

toggle_color_filter = function(filter) {
    if (is_filter_applied(filter, 'color')) {
        remove_filter(filter, 'color');
    } else {
        apply_filter(filter, 'color')
    }
};

toggle_manufacturer_filter = function(filter) {
    if (is_filter_applied(filter, 'manufacturer')) {
        remove_filter(filter, 'manufacturer');
    } else {
        apply_filter(filter, 'manufacturer')
    }
};
