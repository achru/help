require 'spec_helper'

describe CommentOnSupport do
  subject { described_class.new(User.new, Support.new, {}) }

  describe '#commence!' do
    before do
      allow(subject).to receive(:deliver_email) 
      allow(subject.new_comment).to receive(:save!) 
      allow(HipChat::CommentOnSupportNotification).to receive(:notify!)
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
      expect(HipChat::CommentOnSupportNotification).to receive(:notify!)   
      subject.commence!
    end
  end
end
