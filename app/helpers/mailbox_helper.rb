module MailboxHelper

  def unread_messages_count
    mailbox.inbox(:unread => true).count(:id)
  end

  def unread_notification_count
    mailbox.notifications(:unread => true).where(:subject => current_user.username).count(:id)
  end

  def unread_count
    unread_notification_count + unread_messages_count
  end

end
