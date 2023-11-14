# frozen_string_literal: true

module NotificationsHelper
  def occurrence_description(notification)
    return "" if notification.draft?

    number = notification_occurence_number(notification)

    link_to number, notification_path(notification), class: "text-primary", remote: true
  rescue
    ""
  end

  def notification_occurence_number(notification)
    "#{number_with_delimiter(notification.occurrences_delivered_count)} / #{number_with_delimiter(notification.occurrences_count)}"
  end

  def status_html(notification)
    status_method = ["status", notification.status, "html"].compact.join("_")

    send(status_method, notification) rescue notification.status
  end

  def status_draft_html(notification)
    title = "#{I18n.t('notification.drafted_at')}: #{I18n.l(notification.updated_at)}"
    "<span class='badge badge-secondary' data-toggle='tooltip' data-html='true' data-placement='top' data-title='#{sanitize(title)}'>#{t('notification.draft')}</span>"
  end

  def status_in_progress_html(notification)
    title = "<div class='text-left'>#{I18n.t('notification.released_at')}: #{display_date(notification.released_at)}</div>"
    title += "<div class='text-left'>#{I18n.t('notification.released_by')}: #{notification.releasor.display_name}</div>"
    title += "<div class='text-left'>#{I18n.t('notification.next_schedule')}: #{display_datetime(notification.next_schedule.occurrence_date)}</div>" if notification.next_schedule.present?

    "<span class='badge badge-warning' data-toggle='tooltip' data-html='true' data-placement='top' data-title='#{sanitize(title)}'>#{t('notification.in_progress')}</span>"
  end

  def status_cancelled_html(notification)
    title = "<div class='text-left'>#{I18n.t('notification.cancelled_at')}: #{display_date(notification.cancelled_at)}</div>"
    title += "<div class='text-left'>#{I18n.t('notification.cancelled_by')}: #{notification.canceller.try(:display_name)}</div>"

    "<span class='badge badge-danger' data-toggle='tooltip' data-html='true' data-placement='top' data-title='#{sanitize(title)}'>#{t('notification.cancelled')}</span>"
  end

  def status_completed_html(notification)
    title = "<div class='text-left'>#{I18n.t('notification.completed_at')}: #{display_date(notification.updated_at)}</div>"

    "<span class='badge badge-success' data-toggle='tooltip' data-html='true' data-placement='top' data-title='#{sanitize(title)}'>#{t('notification.completed')}</span>"
  end

  def css_active_tab(status)
    return "active" if params[:status].to_a.join(",") == status

    "active" if status == "all" && params[:status].blank?
  end
end
