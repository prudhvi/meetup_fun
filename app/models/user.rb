class User < ActiveRecord::Base
  attr_accessible :name, :provider, :uid

  def self.find_or_create_with_omniauth(auth)
    unless user = find_by_provider_and_uid(auth["provider"], auth["uid"])
      user = create! do |user|
        user.provider = auth["provider"]
        user.uid = auth["uid"]
        user.name = auth["info"]["name"]
      end
    end
    user
  end
end
