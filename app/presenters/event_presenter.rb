class EventPresenter < SimpleDelegator
  def format_start_time
    I18n.localize(start_time, format: :long)
  end

  def format_end_time
    I18n.localize(end_time, format: :long) if end_time.present?
  end
end
