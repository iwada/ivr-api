defmodule Ivr.Notifications do
import Swoosh.Email
	def send_account_verification_email(user, verification_url) do
	    new()
	    |> to({user.email,user.email})
	    |> from({"Fooje Support", "hulk.smash@Fooje.com"})
	    |> subject("Hello, Avengers!")
	    |> html_body("<h1>Hello #{user.email}</h1>
	    				<p> Follow this link #{verification_url} to verify your account")
	    |> text_body("Hello #{user.email}\n")
	end
end