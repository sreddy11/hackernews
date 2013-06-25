// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

$(function() {
  var $filter  = $('select[name=filter]');
  var $byMonth = $('select[name="filter_date[month]"]');
  var $byDay   = $('select[name="filter_date[day]"]');
  var $byYear  = $('select[name="filter_date[year]"]');

  $filter.bind('change', function(e) {
    console.log('change')

    var $this = $(this);

    var value = $this.find('option:selected').val();

    if (value == 'Day') {
      $byMonth.show();
      $byDay.show();
      $byYear.show();
    } else if (value == 'Month') {
      $byMonth.show();
      $byDay.hide();
      $byYear.show();
    } else {
      $byMonth.hide();
      $byDay.hide();
      $byYear.show();
    }
  });

  $filter.trigger('change');
});
