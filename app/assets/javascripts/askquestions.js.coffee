# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#askquestion_tag_names').tokenInput '/tags.json'
    theme: 'facebook'
    prePopulate: $('#askquestion_tag_names').data('load')

#  $('#askquestion_search').autocomplete
#    source: $('#askquestion_search').data('autocomplete-source')