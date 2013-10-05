module OrdersHelper
  def robo_pay(order)
   if order.can_pay?
    prch = order.payments.where(:state => :requested).order("id desc").map{|p| p.purchases.where(:state => :requested).order("id desc") }.flatten.compact.first
    p "---sign", ("#{Rubykassa.login}:#{prch.amount.to_s}:#{prch.id.to_s}:#{Rubykassa.first_password}")
    sign = Digest::MD5.hexdigest("#{Rubykassa.login}:#{prch.amount.to_s}:#{prch.id.to_s}:#{Rubykassa.first_password}")
    content_tag(:script, nil, :language => 'JavaScript', :src => "https://auth.robokassa.ru/Merchant/Handler/MrchSumPreview.ashx?MrchLogin=#{Rubykassa.login}&OutSum=#{prch.amount}&InvId=#{prch.id.to_s }&SignatureValue=#{sign}&Description=#{'Оплата заказа ' + order.id.to_s}")
    #Rubykassa.pay_url(order.payments.create(:amount => order.need_amount, :user_id => current_user.id).id, order.need_amount, {:login => 'instyle'})
   else
    ''
   end
  end

  def robo_place
   #prch = order.payments.where(:state => :requested).order("id desc").map{|p| p.purchases.where(:state => :requested).order("id desc") }.flatten.compact.first
   prch = current_user.payments.where(:order_id => nil, :state => :requested, :amount => 0.0).map{|p| p.purchases.where(:state => :requested) }.flatten.compact.sort_by{|v| v.created_at }.last
   unless prch
    paym = current_user.payments.create(:order_id => nil, :amount => 0.0)
    paym.request!
    prch = paym.purchases.where(:state => :requested, :amount => 0.0).order("id desc").first
   end
   p "---sign", ("#{Rubykassa.login}:#{prch.amount.to_s}:#{prch.id.to_s}:#{Rubykassa.first_password}")
   sign = Digest::MD5.hexdigest("#{Rubykassa.login}:#{prch.amount.to_s}:#{prch.id.to_s}:#{Rubykassa.first_password}")
   content_tag(:script, nil, :language => 'JavaScript', :src => "https://auth.robokassa.ru/Merchant/Handler/MrchSumPreview.ashx?MrchLogin=#{Rubykassa.login}&OutSum=#{prch.amount}&InvId=#{prch.id.to_s }&SignatureValue=#{sign}&Description=#{'Деньги на счет пользователя ' + current_user.name}")
   #Rubykassa.pay_url(order.payments.create(:amount => order.need_amount, :user_id => current_user.id).id, order.need_amount, {:login => 'instyle'})
  end
end
