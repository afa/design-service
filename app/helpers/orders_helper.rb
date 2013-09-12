module OrdersHelper
  def robo_pay(order)
   if order.can_pay?
    prch = order.payments.where(:state => :requested).order("id desc").map{|p| p.purchases.where(:state => :requested).order("id desc") }.flatten.compact.first
    sign = Digest::MD5.hexdigest("#{Rubykassa.login}:#{prch.amount.to_s}:#{prch.id.to_s}:#{Rubykassa.first_password}")
    content_for(:script, :language => 'JavaScript', :src => "https://auth.robokassa.ru/Merchant/Handler/MrchSumPreview.ashx?MrchLogin=#{Rubykassa.login}&OutSum=#{prch.amount}&InvId=#{prch.id.to_s }&SignatureValue=#{sign}&Description=#{'Оплата заказа ' + order.id.to_s}")
    #Rubykassa.pay_url(order.payments.create(:amount => order.need_amount, :user_id => current_user.id).id, order.need_amount, {:login => 'instyle'})
   else
    ''
   end
  end
end
