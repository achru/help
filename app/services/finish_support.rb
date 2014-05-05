class FinishSupport

  attr_accessor :support, :user

  def initialize(user, support)
    self.user = user_receiving_credit user, support
    self.support = support
  end

  def commence!
    reasign_user
    finish_support
    update_counter
    send_hipchat_notification
  end

  private

  def user_receiving_credit(user_finishing_support, support)
    if support.receiver == user_finishing_support
      support.user
    else
      user_finishing_support
    end
  end

  def reasign_user
    support.user = user
  end

  def finish_support
    support.done = true
    support.save!
  end

  def update_counter
    user.increment!(:supports_count)
  end

  def send_hipchat_notification
    HipChat::FinishSupportNotification.notify!(support)
  end
end
