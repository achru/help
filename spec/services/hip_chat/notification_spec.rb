require 'spec_helper'

describe HipChat::Notification do
  subject { HipChat::Notification.new(double) } 
  let(:room) { double }

  before do
    allow(subject.client).to receive(:[]).and_return(room)
    allow(room).to receive(:send).and_return(true)
  end

  describe '#notify' do
    it "sends message to hipchat channel"  do
      expect(subject.client[]).to receive(:send).
                        with('Help App', subject.message, message_format: 'text')
      subject.notify  
    end
  end
end
