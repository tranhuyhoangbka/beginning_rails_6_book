module ApplicationHelper
  def submit_or_cancel(form, name = "Cancel")
    form.submit + ' or ' + link_to(name, 'javascript:history.go(-1);',
      class: 'cancel')
  end

  def language_selector
    if I18n.locale == :en
      link_to 'Pt', url_for(locale: 'pt-br')
    else
      link_to 'EN', url_for(locale: 'en')
    end
  end
end
