class EmailNotificationJob
  include SuckerPunch::Job
  def perform(other_user_id, current_user_id, text)
    other_user = User.find(other_user_id)
    current_user = User.find(current_user_id)
    NotificationMailer.send_notification( other_user, current_user, text ).deliver
  end
end

