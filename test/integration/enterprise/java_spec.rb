describe command('java -version') do
  its(:stdout) { should match /java/ }
  its(:stdout) { should_not match /openjdk/ }
end