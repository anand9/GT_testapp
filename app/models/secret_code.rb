class SecretCode < ActiveRecord::Base
  belongs_to :user
  attr_accessible :code
  validates :code, :uniqueness => true
  paginates_per 20


  def self.generate_code(nos)
   nos.times do |i|
    generate = true
    while  generate
      code = SecureRandom.hex(5)
      coupons = SecretCode.where(:code => code)
      generate = coupons.present?
    end
    SecretCode.create(:code => code)
  end
end



end
