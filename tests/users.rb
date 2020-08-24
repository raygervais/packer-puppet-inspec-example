control "user" do
    impact 1.0
    title "Ensure user accounts were created"
    
    # Resource: https://docs.chef.io/inspec/resources/user/
    for user in ["dev", "qat", "uat"]
        describe user(user) do
            it { should exist }
            its("home") { should eq "/home/#{user}" }
            its('badpasswordattempts') { should eq 0 }
        end
    end
end