class User < ActiveRecord::Base
  
  has_many :messages,      class_name: "Message", foreign_key: "recipient_id"
  has_many :send_messages, class_name: "Message", foreign_key: "sender_id"

  def self.from_omniauth(auth)
  
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      if auth.info.email
        user.email = auth.info.email
      else
        user.email = auth.info.name
      end
      user.save!
    end
  end
  
  def online?
    $redis.exists(self.id)
  end
  
end
