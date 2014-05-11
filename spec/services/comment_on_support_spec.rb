require 'spec_helper'

describe CommentOnSupport do
  subject { described_class.new(User.new, Support.new, {}) }

  describe '#commence!' do
    before do
      allow(subject).to receive(:deliver_email)
      allow(subject.new_comment).to receive(:save!)
      allow(subject).to receive(:send_hipchat_notification)
    end

    it 'saves new comment' do
      expect(subject.new_comment).to receive(:save!)
      subject.commence!
    end

    it 'sends email to subscribers' do
      expect(subject).to receive(:deliver_email)
      subject.commence!
    end

    it 'sends notification on hipchat' do
      expect(subject).to receive(:send_hipchat_notification)
      subject.commence!
    end
  end
end
