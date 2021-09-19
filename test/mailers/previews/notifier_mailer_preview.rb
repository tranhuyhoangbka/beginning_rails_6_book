# Preview all emails at http://localhost:3000/rails/mailers/notifier_mailer
class NotifierMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notifier_mailer/email_friend
  def email_friend
    NotifierMailer.email_friend(Article.find(15), 'Hoàng Trần test', 'faker@example.com')
  end

  def comment_added
    NotifierMailer.comment_added(Comment.find(5))
  end

end
