class SocialAccount < ApplicationRecord
  # Each strategy has a method `name`. The name looks like:
  # "OmniAuth::Strategies::Facebook", so we take the last part of the name,
  # then downcase it and convert to symbol. However, the list of strategies also
  # includes "OmniAuth::Strategies::OAuth2" (the basic strategy, so we remove it).
  # As a result we get something like AVAILABLE_PROVIDERS = [:twitter, :facebook]
  AVAILABLE_PROVIDERS = OmniAuth.strategies.map do |s|
      s.name.match(/::(\w+)\z/)[1].downcase.to_sym
  end.delete_if {|p| p == :oauth2}

  belongs_to :user
  validates :provider, presence: true# in?
  validates :uid, uniqueness: true

  class << self
    def from_omniauth(auth, user)
      provider = auth['provider']
      uid = auth['uid']
      social_account = find_or_initialize_by(provider: provider, uid: uid)
      if social_account && social_account.user != user
        raise
      else
        social_account.name = auth['info']['name']
      end
    end
  end
end