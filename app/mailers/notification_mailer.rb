class NotificationMailer < ActionMailer::Base
  default from: 'notifications@bookfriend.com'
  def send_notification(user, otheruser, message)
    @user = user
    @message = message
    @otheruser = otheruser
    mail(to: @user.email, subject: 'Unread Notifications on BookMeetup.com')
  end
end