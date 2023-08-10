# frozen_string_literal: true

module NotificationsHelper
  def occurrence_description(notification)
    return "" if notification.draft?

    number = "#{number_with_delimiter(notification.occurrences_delivered_count)} / #{number_with_delimiter(notification.occurrences_count)}"
    tooltip_title = sanitize(occurrences_list(notification, number))

    "<span data-toggle='tooltip' data-placement='top' data-html='true' data-title='#{tooltip_title}'>#{number}</span>"
  rescue
    ""
  end

  def survey_form_description(notification)
    return "" if notification.survey_form.nil?

    tooltip_title = sanitize(survey_form_preview(notification))
    "<span data-toggle='tooltip' data-placement='top' data-html='true' data-title='#{tooltip_title}'>#{notification.survey_form_name}</span>"
  end

  def status_html(notification)
    status_method = ["status", notification.status, "html"].compact.join("_")

    send(status_method, notification) rescue notification.status
  end

  def status_draft_html(notification)
    "<span class='badge badge-secondary' data-toggle='tooltip' data-placement='top' data-title='Drafted at: #{I18n.l(notification.updated_at)}'>Draft</span>"
  end

  def status_released_html(notification)
    "<span class='badge badge-success' data-toggle='tooltip' data-placement='top' data-title='Released at: #{I18n.l(notification.released_at)}'>Released</span>"
  end

  private
    def occurrences_list(notification, number)
      str = "<div class='text-left'>"
      str += "Delivered/Total: #{number}"
      str += "<ol>"

      notification.notification_occurrences.each do |occurrence|
        str += "<li>Success: #{occurrence.success_count} / Total: #{occurrence.failure_count} (#{occurrence.status}) </li>"
      end

      str += "</ol>"
      str + "</div>"
    end

    def survey_form_preview(notification)
      form = notification.survey_form
      str = "<div class='text-left'>"
      str += "Form: #{form.name}"
      str += "<div>Question</div>"
      str += "<ol>"
      form.questions.each do |question|
        str += question_list(question)
      end

      str += "</ol>"
      str + "</div>"
    end

    def question_list(question)
      str = "<li> #{question.name}"
      str += "<ul>"
      question.options.each do |option|
        str += "<li>#{option.name}</li>"
      end
      str + "</ul></li>"
    end
end
