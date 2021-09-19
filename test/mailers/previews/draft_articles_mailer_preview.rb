# Preview all emails at http://localhost:3000/rails/mailers/draft_articles_mailer
class DraftArticlesMailerPreview < ActionMailer::Preview
  def created
    DraftArticlesMailer.created('test@example.com', Article.find(15))
  end

  def no_author
    DraftArticlesMailer.no_author('test@example.com')
  end
end
