json.attachments collection, :id, :original_filename
json.list_of_attachments render(partial: 'attachments/list_of_attachments',
                                formats: [:html], handlers: [:haml],
                                locals: {attachments: collection, has_remove_button: true})
