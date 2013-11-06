require "spec_helper"

describe Client do
  before do
   @user = FactoryGirl.create(:user)
   @purchase = FactoryGirl.create(:purchase)
  end
  describe "payment_failed" do
    let(:mail) { Client.payment_failed(@user, @purchase) }

    it "renders the headers" do
      mail.subject.should eq("Payment failed")
      mail.to.should eq([@user.email])
      mail.from.should eq([SITE_EMAIL])
    end

    it "renders the body" do
      #mail.body.encoded.should match("Hi")
    end
  end

end
