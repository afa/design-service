require "spec_helper"

describe SpecialistMailer do
  describe "new_order" do
    let(:mail) { SpecialistMailer.new_order }

    it "renders the headers" do
      mail.subject.should eq("New order")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "payment" do
    let(:mail) { SpecialistMailer.payment }

    it "renders the headers" do
      mail.subject.should eq("Payment")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
