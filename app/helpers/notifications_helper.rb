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
    title = "#{I18n.t('notification.drafted_at')}: #{I18n.l(notification.updated_at)}"
    "<span class='badge badge-secondary' data-toggle='tooltip' data-html='true' data-placement='top' data-title='#{sanitize(title)}'>Draft</span>"
  end

  def status_released_html(notification)
    title = "<div class='text-left'>#{I18n.t('notification.released_at')}: #{display_date(notification.released_at)}</div>"
    title += "<div class='text-left'>#{I18n.t('notification.released_by')}: #{notification.releasor.display_name}</div>"

    "<span class='badge badge-success' data-toggle='tooltip' data-html='true' data-placement='top' data-title='#{sanitize(title)}'>Released</span>"
  end

  def status_cancelled_html(notification)
    title = "<div class='text-left'>#{I18n.t('notification.cancelled_at')}: #{display_date(notification.cancelled_at)}</div>"
    title += "<div class='text-left'>#{I18n.t('notification.cancelled_by')}: #{notification.canceller.try(:display_name)}</div>"

    "<span class='badge badge-danger' data-toggle='tooltip' data-html='true' data-placement='top' data-title='#{sanitize(title)}'>Cancelled</span>"
  end

  def status_completed_html(notification)
    title = "<div class='text-left'>#{I18n.t('notification.completed_at')}: #{display_date(notification.updated_at)}</div>"

    "<span class='badge badge-primary' data-toggle='tooltip' data-html='true' data-placement='top' data-title='#{sanitize(title)}'>Completed</span>"
  end

  def css_active_tab(status)
    return "active" if params[:status].to_a.join(",") == status

    "active" if status == "all" && params[:status].blank?
  end

  private
    def occurrences_list(notification, number)
      str = "<div class='text-left'>"
      str += "Delivered/Total: #{number}"
      str += "<ol>"

      notification.notification_occurrences.each do |occurrence|
        str += "<li>#{display_date(occurrence.occurrence_date)}៖ Success: #{occurrence.success_count} / Total: #{occurrence.failure_count} (#{occurrence.status}) </li>"
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
