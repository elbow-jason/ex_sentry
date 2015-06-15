defmodule Lis.Password do
  alias Comeonin.Bcrypt

  def create_hash(string) do
    Bcrypt.hashpwsalt(string)
  end

  def check_password(plaintext_pw, hashed_pw) do
    Bcrypt.checkpw(plaintext_pw, hashed_pw)
  end

end
