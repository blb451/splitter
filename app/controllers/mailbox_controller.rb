class MailboxController < ApplicationController
  before_action :authenticate_user!

  def inbox
    @inbox = mailbox.inbox
    @active = :inbox
  end

  def notifications
    @notifications = mailbox.notifications.where(:subject => current_user.username)
    @active = :notifications
  end

  def sent
    @sent = mailbox.sentbox
    @active = :sent
  end

  def trash
    @trash = mailbox.trash
    @active = :trash
  end

  def empty_trash
    current_user.mailbox.empty_trash
    redirect_to mailbox_trash_path
  end

  def notification_read
    notification = mailbox.notifications.find(params[:format])
    notification.mark_as_read(current_user)
    redirect_to mailbox_notifications_path
  end

  def notification_all_read
    @notifications = mailbox.notifications.where(:subject => current_user.username)
    @notifications.each do |notification|
      notification.mark_as_read(current_user)
    end
    redirect_to mailbox_notifications_path
  end

end
