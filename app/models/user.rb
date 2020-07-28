class User < ActiveRecord::Base
  validate :cpf_unique?
  validates :email, :password, presence: true
  validates :email, uniqueness: true
  validates :cpf, uniqueness: true
  validates_cpf :cpf
  validates :password, :format => { :with => /(?=.*[a-zA-Z])(?=.*[0-9])/, :message => "Senha tem que diversificar entre letras e números"}
  validates :password, length: { minimum: 6, :message => "Senha tem que ser maior que seis dígitos" }
  has_many :visits
  has_secure_password

  def cpf_unique?
    if cpf.include? "."
      user = User.where(cpf: cpf.gsub!(".","").gsub!("-",""))
      if !user.empty?
        errors.add(:cpf, "Cpf já foi cadastrado")
      end
    end
  end
end
