class CommentOnSupport

  attr_accessor :user, :support, :comment_params

  def initialize(user, support, comment_params)
    self.user = user
    self.support = support
    self.comment_params = comment_params
  end

  def commence!
    new_comment.save!
    deliver_email
    send_hipchat_notification
  end

  def new_comment
    @comment ||= Comment.new(user: user,
                             support: support,
                             body: comment_params[:body])
  end

  def deliver_email
    subscribers.each { |user| SupportMailer.new_comment(support, @comment, user).deliver }
  end

  private

  def subscribers
    ids = support.comments.pluck(:user_id).uniq - [user.id] + [support.receiver_id]
    User.where id: ids
  end

  def send_hipchat_notification
    HipChat::CommentOnSupportNotification.notify!(new_comment)
  end
  
end
