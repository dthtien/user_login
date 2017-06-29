$(document).on "turbolinks:load", ->
  $("#edit-post-btn").on "ajax:success", ->
    editPostModal = $('#edit-post-modal')
    editPostModal.modal()
    editPostModal.modal('open')