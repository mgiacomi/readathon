desc "Email Pledges"
task :email_pledges => :environment do

  #Pledge.where("email_sent_date is null").limit(10).each do |pledge|
  #  GeneralMailer.pledge_payment(pledge).deliver
  #  p "Sending pledge to #{pledge.email}"
  #end

  pledge = Pledge.find 1
    GeneralMailer.pledge_payment(pledge).deliver

end