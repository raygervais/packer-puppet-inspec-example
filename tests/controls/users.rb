control 'users' do
    impact 1.0
    title 'Ensure user accounts were created'
    
    # Resource: https://docs.chef.io/inspec/resources/user/
    describe user('dev') do
        it { should exist }
        its('home') { should eq '/home/dev' }
        its('badpasswordattempts') { should eq 0 }
    end

    describe user('qat') do
        it { should exist }
        its('home') { should eq '/home/qat' }
        its('badpasswordattempts') { should eq 0 }
    end

    describe user('uat') do
        it { should exist }
        its('home') { should eq '/home/uat' }
        its('badpasswordattempts') { should eq 0 }
    end
end