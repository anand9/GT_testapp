class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first, :last, :password, :password_confirmation, :remember_me
  attr_protected :admin
  attr_accessor :user_code
  has_one :user_code
  validates :email, :uniqueness => true
  validates :user_code, :presence =>true , :unless => Proc.new{|p| p.admin}
  validate :check_code , :unless => Proc.new{|p| p.admin}
  after_create :add_code , :unless => Proc.new{|p| p.admin}


  def check_code
    @secret_code = SecretCode.where(:code => user_code , :user_id => nil).first
    errors.add(:code, "Incorrect") if @secret_code.blank?
  end

  def add_code
    @secret_code = SecretCode.where(:code => user_code).first
    @secret_code.user = self
    @secret_code.save
  end


end
