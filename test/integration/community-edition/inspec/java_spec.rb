control 'Java version' do
  impact 1.0
  title 'Check for Oracle Java'
  desc 'Determine if Java flavor is OracleJDK and not OpenJDK'
  describe command("java -version 2>&1 >/dev/null | grep 'java' | awk '{print $1}'") do
    its(:stdout) { should match(/java/) }
    its(:stdout) { should_not match(/openjdk/) }
  end
end
