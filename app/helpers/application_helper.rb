module ApplicationHelper
  include Pagy::Frontend

  def show_attachment(attachment)
    attachment.attached? ? rails_blob_path(attachment, disposition: "attachment", only_path: true) : '#'
  end

  def country_name(country_code)
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.name
  end
end
