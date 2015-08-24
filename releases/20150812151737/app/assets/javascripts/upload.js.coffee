//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl

jQuery ->
  $('#avatar_upload').fileupload
    dataType: 'script'
    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png|mov|mpeg|mpeg4|avi)$/i
      file = data.files[0]
      if types.test(file.type) || types.test(file.name)
        data.context = $(tmpl("template-upload", file))
        $('#new_image').append(data.context)
        data.submit()
      else
        alert("#{file.name} is not a gif, jpg or png image file")
    progress: (e, data) ->
      if data.context

        progress = parseInt(data.loaded / data.total * 100, 10)
        console.log(progress)
        console.log(data.context.find('#upload_progress'))
        data.context.find('#upload_progress').attr('data-percent', progress)