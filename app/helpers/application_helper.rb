module ApplicationHelper
  include Pagy::Frontend

  def show_attachment(attachment, alternative)
    attachment.attached? ? rails_blob_path(attachment, disposition: "attachment", only_path: true) : asset_path(alternative)
  end

  def events_ajax_previous_link(user_id)
    ->(param, date_range) { link_to my_calender_user_path(id: user_id), {param => date_range.first - 1.day}, remote: :true}
  end

  def events_ajax_next_link(user_id)
    ->(param, date_range) { link_to my_calender_user_path(id: user_id), {param => date_range.last + 1.day}, remote: :true}
  end

  def check_attribute_presence(value)
    value.present?
  end
end
