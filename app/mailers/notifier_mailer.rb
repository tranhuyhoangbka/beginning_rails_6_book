class NotifierMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier_mailer.email_friend.subject
  #
  def email_friend(article, sender_name, receiver_email)
    @article = article
    @sender_name = sender_name

    if @article.cover_image.present?
      attachments[@article.cover_image.filename.to_s] = @article.cover_image.download
    end

    mail to: receiver_email, subject: "Vv Tôi có bài viết mới, bạn có thời gian rảnh không?"
  end

  def comment_added(comment)
    @article = comment.article
    mail to: @article.user.email, subject: "New Comment for '#{@article.title}'"
  end
end
