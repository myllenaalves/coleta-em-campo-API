class User < ActiveRecord::Base
  validates :email, :password, presence: true
  validates :email, uniqueness: true
  validates :cpf, presence: true, uniqueness: true, cpf: true
  validates :password, :format => { :with => /(?=.*[a-zA-Z])(?=.*[0-9])/, :message => "Senha tem que diversificar entre letras e números"}
  validates :password, length: { minimum: 6, :message => "Senha tem que ser maior que seis dígitos" }
  has_many :visits
  has_secure_password
end
