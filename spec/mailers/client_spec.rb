require "spec_helper"

describe Client do
  describe "payment_failed" do
    let(:mail) { Client.payment_failed }

    it "renders the headers" do
      mail.subject.should eq("Payment failed")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
